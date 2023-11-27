# -*- coding: utf-8 -*-
"""make_vector_woknet.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1FXjYFMIYcV-iilgVC1spo7Sd2aNjfedi
"""

import mysql.connector
from sqlalchemy import create_engine
import sys
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer

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

# SQLAlchemy 엔진 생성
engine = create_engine(f'mysql+mysqlconnector://{db_params["user"]}:{db_params["password"]}@{db_params["host"]}:{db_params["port"]}/{db_params["database"]}')


# SQL 쿼리 작성 (Amazon RDS의 데이터를 가져오는 적절한 쿼리로 수정)
sql_query = "SELECT * FROM worknet"   # 여기서 'your_table'을 Amazon RDS의 실제 테이블 이름으로 수정

# SQL 쿼리 실행
cursor.execute(sql_query)

# 데이터 불러오기
data = cursor.fetchall()

df = pd.DataFrame(data, columns=['title', 'company','location','sal', 'wantedInfoUrl','closeDt','wantedAuthNo','jobsCd', 'occupation'])
df = df.drop(['title', 'company','wantedInfoUrl','closeDt','jobsCd'], axis=1)

# '만원'을 지우고 '~'으로 구분된 값을 평균값으로 변경하는 함수 (sal 칼럼에 1만원 단위의 데이터가 있어서 정수형이 아닌 실수형으로 변환, 예) 201만원, 201만원~220만원)
def process_sal(value):
    # '만원' 문자열을 빈 문자열로 대체하고 정수로 변환
    value = value.replace('만원', '').replace(',', '').replace('원', '').strip()

    # '~'로 구분된 경우에는 평균값으로 처리
    if '~' in value:
        values = value.split('~')
        value = (int(values[0]) + int(values[1])) / 2
    else:
        # 단일 값인 경우에는 정수로 변환
        value = int(value)

    # 만약 값이 1000 미만이라면 12를 곱하여 연간 급여로 변환
    if value < 1000:
        value *= 12

    return value
    print(sal)

# TF-IDF 벡터화를 위한 객체 생성
tfidf_vectorizer = TfidfVectorizer()

#df
# 'sal' 칼럼에 함수 적용
df['sal'] = df['sal'].apply(process_sal)

# 직종 데이터를 TF-IDF로 벡터화
job_text_data = df['occupation'].astype(str)  # 데이터 타입을 문자열로 변환
job_vector = tfidf_vectorizer.fit_transform(job_text_data)

# 벡터화한 데이터를 데이터프레임에 추가
for i, col in enumerate(tfidf_vectorizer.get_feature_names_out()):
    df[f'occupation_{i}'] = job_vector[:, i].toarray()

# 지역 데이터에 대해서도 동일한 작업 수행
location_text_data = df['location'].astype(str)
location_vector = tfidf_vectorizer.fit_transform(location_text_data)

for i, col in enumerate(tfidf_vectorizer.get_feature_names_out()):
    df[f'location_{i}'] = location_vector[:, i].toarray()

# 데이터프레임을 MySQL 테이블로 저장
table_name = 'vector_worknet'
df.to_sql(table_name, con=engine, if_exists='replace', index=False)

# 연결과 커서 닫기
cursor.close()
connection.close()