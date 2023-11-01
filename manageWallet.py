import psycopg2
import sys
import getpass
import smtplib
import random
from psycopg2.extras import DictCursor
import menu as menu
import time

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


def display():
    return menu.menu(
        "Dashboard",
        ["Deposit", "Withdraw"],
        "red",
    )


def manageWallet(userid):
    try:
        cursor.execute(f"SELECT balance from wallet where userid = {userid}")
        balance = cursor.fetchone()
        print("Current balance : ", balance)
        time.sleep(3)
        res = display()
        if res == 0:
            amt = int(input("Enter amount to deposit : "))
            if amt < 0:
                print("invalid amount")
                return 0
            try:
                cursor.execute(
                    f"UPDATE wallet SET balance = balance + {amt} where userid = {userid};"
                )
                conn.commit()
                print("successfully deposited")
                return 1
            except psycopg2.DatabaseError as error:
                conn.rollback()
                print(error)
                return 0
        if res == 1:
            try:
                amt = int(input("Enter amount to withdraw : "))
                if amt < 0:
                    print("invalid amount")
                    return 0
                cursor.execute(f"SELECT balance FROM wallet WHERE userid = {userid};")
                balance = int(cursor.fetchone()[0])
                if balance < amt:
                    print("Not enough money to withdraw")
                else:
                    cursor.execute(
                        f"UPDATE wallet SET balance = balance - {amt} where userid = {userid};"
                    )
                    conn.commit()
                    print("successfully withdrawn")
                    return 1
            except psycopg2.DatabaseError as error:
                conn.rollback()
                print(error)
                return 0
    except psycopg2.DatabaseError as error:
        conn.rollback()
        print(error)
        return 0
