import psycopg2
import sys

conn = psycopg2.connect(database='flipkart', host="localhost", user="postgres", password="11042003", port=5432)
cursor = conn.cursor()