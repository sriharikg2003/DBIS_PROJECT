import psycopg2
import sys
import getpass
import smtplib
import random
from psycopg2.extras import DictCursor

try:
    conn = psycopg2.connect(
        database="flipkart",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )
except:
    sys.exit("Failed to connect to the database")
cursor = conn.cursor(cursor_factory=DictCursor)


def updateAddress(userid):
    street = input("Enter street : ")
    city = input("Enter city : ")
    state = input("Enter state : ")
    country = input("Enter country : ")
    postal_code = input("Enter postal code : ")
    try:
        cursor.execute(
            f"INSERT INTO addresses (street, city, state, country, postalcode) VALUES ('{street}', '{city}', '{state}', '{country}', '{postal_code}') RETURNING *;"
        )
        inserted_id = int(cursor.fetchone()[0])
        print(inserted_id)
        cursor.execute(
            f"UPDATE users SET addressid = {inserted_id} WHERE userid = {userid};"
        )
        conn.commit()
    except psycopg2.DatabaseError as error:
        conn.rollback()
        print(error)
    # conn.close()
    # cursor.close()
