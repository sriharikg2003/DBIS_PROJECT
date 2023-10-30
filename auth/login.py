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

SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
SMTP_PASSWORD = "vjloqtoktdhstxjw"
SENDER_EMAIL = "mandardeshpande2003@gmail.com"


def print_message():
    pattern = r"""
*****************************************************************
*                                                               *
*                     Welcome to Flipkart                       *
*                   Logged in successfully                      *
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
    return False


def login():
    email = input("Enter Email ID: ")
    password = getpass.getpass("Enter your password: ")
    try:
        cursor.execute(
            "SELECT * FROM users WHERE email = %s AND password = %s",
            (email, password),
        )
        user = cursor.fetchone()
        if user:
            print_message()
            return user[0]
        else:
            print("Invalid email or password.")
            choice = int(input("Enter:\n1.Retry\n2.Forgot Password?\n"))
            if choice == 1:
                login()
            elif choice == 2:
                otp = str(random.randint(100000, 999999))
                if send_otp(email, otp):
                    if verifyOTP(otp):
                        new_password = input("Enter new password: ")
                        add_user_query = f"UPDATE users SET password = '{new_password}' WHERE email ='{email}'"
                        cursor.execute(add_user_query)
                        conn.commit()
                        print("Password Changed Succesfully")
                        cursor.execute(
                            "SELECT * FROM users WHERE email = %s AND password = %s",
                            (email, new_password),
                        )
                        user = cursor.fetchone()
                        return user[0]
                    else:
                        print("Invalid OTP")
                        login()
                else:
                    print("Invalid choice.")
                    login()
    except psycopg2.DatabaseError as error:
        conn.rollback()
        print("DB Error")
        login()
    # conn.close()
    # cursor.close()
