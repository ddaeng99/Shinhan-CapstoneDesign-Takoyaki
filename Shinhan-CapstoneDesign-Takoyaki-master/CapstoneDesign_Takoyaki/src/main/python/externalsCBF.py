import mysql.connector
import sys
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
from konlpy.corpus import kobill
from konlpy.tag import Kkma

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
sql_query = "SELECT * FROM externals"

# SQL 쿼리 실행
cursor.execute(sql_query)

# 데이터 불러오기
data = cursor.fetchall()

df = pd.DataFrame(data, columns=['extid', 'title', 'location','date','href'])

# KoNLPy의 Kkma 형태소 분석기를 초기화
kkma = Kkma()

# 불용어 목록 생성
stop_words = ["의", "가", "이", "은", "들", "는", "좀", "잘", "걍", "과", "도", "를", "으로", "자", "에", "와", "한", "하다"]

tfidf_vectorizer = TfidfVectorizer(stop_words=stop_words)
tfidf_matrix = tfidf_vectorizer.fit_transform(df['title'] + ' ' + df['location'] )
cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)

# SQL 쿼리 작성
sql_query2 = "SELECT extid FROM cbf_ext  where id = %s"

# SQL 쿼리 실행
cursor.execute(sql_query2, (user_id,))

# extid 값 가져오기
extid_list = [row[0] for row in cursor.fetchall()]

# 연결과 커서 닫기
cursor.close()
connection.close()

# extid 값을 사용하여 해당 값이 externals 테이블에서 몇 번째 인덱스에 있는지 찾기
selected_ext_indices = []
for extid in extid_list:
    index = df.index[df['extid'] == extid].tolist()
    if index:
        selected_ext_indices.extend(index)

        # 선택한 공고의 제목 출력
selected_ext_titles = [df['title'][i] for i in selected_ext_indices]
print(f"Selected Job Titles: {', '.join(selected_ext_titles)}")

# extid 컬럼 문자열타입으로 변경
df['extid'] = df['extid'].astype(str)

# 선택한 공고들을 하나로 합친 데이터를 생성
selected_ext_descriptions = " ".join([df['extid'][i] + ' ' + df['title'][i] + ' ' + df['location'][i] + ' ' + df['date'][i] + ' ' + df['href'][i] for i in selected_ext_indices])

# 합친 데이터에 대한 TF-IDF 벡터 생성
selected_ext_tfidf_matrix = tfidf_vectorizer.transform([selected_ext_descriptions])

# 선택한 공고와 유사한 공고 생성
similar_exts = list(enumerate(linear_kernel(selected_ext_tfidf_matrix, tfidf_matrix)[0]))
similar_exts = [job for job in similar_exts if (job[1] + 1) * 100 / 2 >= 55]  # 유사도가 55% 이상인 것만 선택
similar_exts = sorted(similar_exts, key=lambda x: x[1], reverse=True)

selected_exts_set = set(selected_ext_indices)

for ext in similar_exts:
    similarity_score = ext[1]
    ext_index = ext[0]
    extid = df['extid'][ext_index]

    # 선택한 공고를 건너뜁니다
    if ext_index in selected_exts_set:
        continue

    if (similarity_score + 1) * 100 / 2 >= 55:
        cosine_similarity = (similarity_score + 1) * 100 / 2

        print(f"extid: {extid}")
        print(f"cosine_similarity: {cosine_similarity:.3f}%")