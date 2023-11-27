import mysql.connector
import sys
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
from konlpy.corpus import kobill
from konlpy.tag import Kkma

# KoNLPy의 Kkma 형태소 분석기를 초기화
kkma = Kkma()

# 불용어 목록 생성
stop_words = ["의", "가", "이", "은", "들", "는", "좀", "잘", "걍", "과", "도", "를", "으로", "자", "에", "와", "한", "하다"]

# 이 불용어 목록을 활용하여 TfidfVectorizer 초기화


# MySQL 연결 설정
db_params = {
    'host': 'AWS_RDS_ADDRESS',
    'user': 'DBID',
    'password': 'DBPW',
    'database': 'DATABASE',
    'port': 3306  # MySQL의 기본 포트
}

# 데이터베이스 연결
connection = mysql.connector.connect(**db_params)

# 커서 생성
cursor = connection.cursor()

# 사용자 아이디 저장
user_id = sys.stdin.readline().strip()

# SQL 쿼리 작성 (Amazon RDS의 데이터를 가져오는 적절한 쿼리로 수정)
sql_query = "SELECT * FROM worknet"  # 여기서 'your_table'을 Amazon RDS의 실제 테이블 이름으로 수정

# SQL 쿼리 실행
cursor.execute(sql_query)

# 데이터 불러오기
data = cursor.fetchall()

df = pd.DataFrame(data, columns=['title', 'company', 'location','sal','wantedInfoUrl','closeDt','wantedAuthNo','jobsCd','occupation'])

tfidf_vectorizer = TfidfVectorizer(stop_words=stop_words)
tfidf_matrix = tfidf_vectorizer.fit_transform(df['title'] + ' ' + df['location'] + ' ' +  df['sal'])

cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)

# SQL 쿼리 작성 (reco_tb에서 wantedAuthNo 가져오기)
sql_query2 = "SELECT wantedAuthNo FROM reco_tb where id = %s"

# SQL 쿼리 실행
cursor.execute(sql_query2,(user_id,))

# wantedAuthNo 값 가져오기
wantedAuthNo_list = [row[0] for row in cursor.fetchall()]

# 연결과 커서 닫기
cursor.close()
connection.close()

# wantedAuthNo 값을 사용하여 해당 값이 worknet 테이블에서 몇 번째 인덱스에 있는지 찾기
selected_job_indices = []
for wantedAuthNo in wantedAuthNo_list:
    index = df.index[df['wantedAuthNo'] == wantedAuthNo].tolist()
    if index:
        selected_job_indices.extend(index)

# 선택한 공고의 제목 출력
selected_job_titles = [df['title'][i] for i in selected_job_indices]
print(f"Selected Job Titles: {', '.join(selected_job_titles)}")

# 선택한 공고들을 하나로 합친 데이터를 생성
selected_job_descriptions = " ".join([df['title'][i] + ' ' + df['company'][i] + ' ' + df['location'][i] + ' ' + df['sal'][i] + ' ' + df['wantedInfoUrl'][i] + ' ' + df['closeDt'][i] + ' ' + df['wantedAuthNo'][i] for i in selected_job_indices])

# 합친 데이터에 대한 TF-IDF 벡터 생성
selected_job_tfidf_matrix = tfidf_vectorizer.transform([selected_job_descriptions])

# 선택한 공고와 유사한 공고 생성
similar_jobs = list(enumerate(linear_kernel(selected_job_tfidf_matrix, tfidf_matrix)[0]))
similar_jobs = sorted(similar_jobs, key=lambda x: x[1], reverse=True)

count = 0
selected_jobs_set = set(selected_job_indices)  # 선택한 공고 인덱스를 집합으로 변환

for job in similar_jobs:
    similarity_score = job[1]
    job_index = job[0]
    wantedAuthNo = df['wantedAuthNo'][job_index]

    # 선택한 공고를 건너뜁니다
    if job_index in selected_jobs_set:
        continue

    if (similarity_score + 1) * 100 / 2 >= 55:
        cosine_similarity = (similarity_score + 1) * 100 / 2

        print(f"wantedAuthNo: {wantedAuthNo}")
        print(f"cosine_similarity: {cosine_similarity:.3f}%")


