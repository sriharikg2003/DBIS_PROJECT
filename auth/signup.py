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
        password="1234",
        port=5432,
    )
except:
    sys.exit("Failed to connect to the database")

cursor = conn.cursor()

SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SMTP_PASSWORD = "vjloqtoktdhstxjw"
SENDER_EMAIL = "mandardeshpande2003@gmail.com"


def print_message():
    pattern = r"""
*****************************************************************
*                                                               *
*                     Welcome to Flipkart                       *
*                   Signed up successfully                      *
*                 Thank you for choosing our service            *
*                                                               *
*****************************************************************
    """
    print(pattern)


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
        otp = str(random.randint(100000, 999999))
        send_otp(email, otp)


def verifyOTP(otp):
    enteredOTP = input("Enter OTP: ")
    if enteredOTP == otp:
        return True
    else:
        print("Incorrect OTP")
    return False


def signup():
    email = input("Enter Email ID: ")
    password = input("Enter Password: ")
    firstname = input("Enter firstname: ")
    lastname = input("Enter Lastname: ")
    usertype = input("Select role ('customer', 'delivery-person', 'seller'): ")
    try:
        otp = str(random.randint(100000, 999999))
        try:
            dob_date = datetime.strptime("01/01/2001", "%d/%m/%Y").date()
            dob_formatted = dob_date.strftime("%Y-%m-%d")
        except ValueError:
            print("Invalid date format. Please use DD/MM/YYYY format.")
            return
        if send_otp(email, otp):
            if verifyOTP(otp):
                add_user_query = f"INSERT INTO users ( email, password, firstname, lastname, dob, usertype) VALUES ('{email}','{password}','{firstname}','{lastname}','{dob_formatted}','{usertype}') RETURNING *"
                cursor.execute(add_user_query)
                new_user = cursor.fetchone()[0]
                create_wallet = (
                    f"INSERT INTO wallet (userid,balance) VALUES ({new_user},0);"
                )
                cursor.execute(create_wallet)
                conn.commit()
                print_message()
                # print(new_user)
                return new_user
            else:
                while verifyOTP(otp) == False:
                    verifyOTP(otp)
                add_user_query = f"INSERT INTO users ( email, password, firstname, lastname, dob, usertype) VALUES ('{email}','{password}','{firstname}','{lastname}','{dob_formatted}','{usertype}') RETURNING *"
                cursor.execute(add_user_query)
                new_user = cursor.fetchone()[0]
                create_wallet = (
                    f"INSERT INTO wallet (userid,balance) VALUES ({new_user},0);"
                )
                cursor.execute(create_wallet)
                print(new_user)
                conn.commit()
                print_message()
                # return new_user
    except psycopg2.DatabaseError as error:
        conn.rollback()
        print(error)
        signup()
