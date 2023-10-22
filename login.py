import psycopg2
import sys
import getpass

try:
    conn = psycopg2.connect(
        database="moviedb",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )
except:
    sys.exit("Failed to connect to the database")

cursor = conn.cursor()

email = input("Enter your registered email ID: ")
password = getpass.getpass("Enter your password: ")
print("Password: " + password)
