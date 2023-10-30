import psycopg2

conn = psycopg2.connect(
    database="flipkart", host="localhost", user="postgres", password="1234", port=5432
)
cursor = conn.cursor()
