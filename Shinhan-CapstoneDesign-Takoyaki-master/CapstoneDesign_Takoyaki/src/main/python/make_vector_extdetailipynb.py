# -*- coding: utf-8 -*-
"""make_vector_extDetailipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/12O5MI0fC9rhM1gxpAwV5e9J2M3qgU-wW
"""

#!pip install mysql-connector-python
#!pip install sqlalchemy

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
sql_query = "SELECT * FROM extDetail"   # 여기서 'your_table'을 Amazon RDS의 실제 테이블 이름으로 수정

# SQL 쿼리 실행
cursor.execute(sql_query)

# 데이터 불러오기
data = cursor.fetchall()

# 테이블의 열 이름(칼럼 이름) 가져오기
column_names = [i[0] for i in cursor.description]

# 데이터프레임 생성
df = pd.DataFrame(data, columns=column_names)

df = df.drop(['name', 'agent', 'support', 'during', 'money1', 'money2', 'homepage', 'viewContents'], axis=1)

# TF-IDF 벡터화 할 경우 '/' 를 기준으로 나누는 코드
#def split_and_tokenize(text):
#    tokens = text.split('/')
#    return tokens

# TF-IDF 벡터화 객체 생성
#tfidf_vectorizer = TfidfVectorizer()

# 'category' 열 처리
#df['category'] = df['category'].apply(split_and_tokenize)
#df['category'] = df['category'].apply(lambda tokens: ' '.join(tokens))
#category_vectors = tfidf_vectorizer.fit_transform(df['category'])
#for i, col in enumerate(tfidf_vectorizer.get_feature_names_out()):
#    df[f'category_{i}'] = category_vectors[:, i].toarray()

# 'agent' 열 처리
#df['agent'] = df['agent'].apply(split_and_tokenize)
#df['agent'] = df['agent'].apply(lambda tokens: ' '.join(tokens))
#agent_vectors = tfidf_vectorizer.fit_transform(df['agent'])
#for i, col in enumerate(tfidf_vectorizer.get_feature_names_out()):
#    df[f'agent_{i}'] = agent_vectors[:, i].toarray()

# 범주형 데이터에 대한 인코딩 처리는 TF-IDF 방식 보다는 원핫 인코딩 방식이 더 타당하다고 판단하여 기존 TF-IDF 방식에서 원핫 인코딩 방식으로 수정
# TF-IDF 인코딩 코드는 혹시 몰라서 남겨둠.

# 'category' 열을 원핫 인코딩
category_dummies = df['category'].str.get_dummies(sep='/')
df = pd.concat([df, category_dummies], axis=1)

# 'category' 열 삭제
df = df.drop('category', axis=1)

# 데이터프레임을 MySQL 테이블로 저장
table_name = 'vector_extDetail'
df.to_sql(table_name, con=engine, if_exists='replace', index=False)

# 연결과 커서 닫기
cursor.close()
connection.close()