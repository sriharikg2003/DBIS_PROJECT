import psycopg2
import sys
from datetime import datetime
import smtplib
import random


try:
    conn = psycopg2.connect(
        database="flipkart",
        host="localhost",
        user="postgres",
        password="123456",
        port=5432,
    )
except:
    sys.exit("Failed to connect to the database")

cursor = conn.cursor()

SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SMTP_PASSWORD = "vjloqtoktdhstxjw"
SENDER_EMAIL = "mandardeshpande2003@gmail.com"


def send_otp(email, otp):
    try:
        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(SENDER_EMAIL, SMTP_PASSWORD)
        message = f"Subject: Your OTP for flipkart is{otp}"
        server.sendmail(SENDER_EMAIL, email, message)
        server.quit()
        print("OTP sent successfully.")
        return True
    except smtplib.SMTPException as e:
        print("Failed to send OTP, RESENDING... ")
        return False


def verifyOTP(otp):
    enteredOTP = input("Enter OTP: ")
    if enteredOTP == otp:
        return True
    return False


def signup():
    email = input("Enter Email ID: ")
    password = input("Enter Password: ")
    firstname = input("Enter firstname: ")
    lastname = input("Enter Lastname: ")
    dob = input("Enter Date of birth DD/MM/YYYY: ")
    usertype = input("Select role ('customer', 'delivery-person', 'seller'): ")
    try:
        otp = str(random.randint(100000, 999999))
        try:
            dob_date = datetime.strptime(dob, "%d/%m/%Y").date()
            dob_formatted = dob_date.strftime("%Y-%m-%d")
        except ValueError:
            print("Invalid date format. Please use DD/MM/YYYY format.")
            signup()
        if send_otp(email, otp):
            if verifyOTP(otp):
                add_user_query = f"INSERT INTO users ( email, password, firstname, lastname, dob, usertype) VALUES ('{email}','{password}','{firstname}','{lastname}','{dob_formatted}','{usertype}') RETURNING *"
                cursor.execute(add_user_query)
                new_user = cursor.fetchone()[0]
                conn.commit()
                print("Signed up successfully")
                print(new_user)
                return new_user
            else:
                while verifyOTP(otp) == False:
                    verifyOTP(otp)
                add_user_query = f"INSERT INTO users ( email, password, firstname, lastname, dob, usertype) VALUES ('{email}','{password}','{firstname}','{lastname}','{dob_formatted}','{usertype}') RETURNING *"
                cursor.execute(add_user_query)
                new_user = cursor.fetchone()[0]
                print(new_user)
                conn.commit()
                print("Signed up successfully")
                return new_user
    except psycopg2.DatabaseError as error:
        conn.rollback()
        print(error)
        signup()
    # conn.close()
    # cursor.close()
