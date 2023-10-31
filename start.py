import auth.signup as signup
import auth.login as login
import menu as menu
from customerDashboard import customerDashboard
import psycopg2
import sys
from sellersDashboard import sellersDashboard

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

option = menu.menu("Authenticate", ["Signup", "SignIn"], "red")
if option == 0:
    userid = signup.signup()
    query = f"SELECT usertype from users where userid={userid}"
    try:
        cursor.execute(query)
        role = cursor.fetchone()[0]
        print(role)
    except:
        print("failed to execute")
    if role == "customer":
        customerDashboard(userid)
    if role == "seller":
        sellersDashboard(userid)
        # addProduct.addProduct(userid)
    if role == "delivery-person":
        pass
elif option == 1:
    userid = login.login()
    query = f"SELECT usertype from users where userid={userid}"
    try:
        cursor.execute(query)
        role = cursor.fetchone()[0]
        print(role)
    except:
        print("failed to execute")
    if role == "customer":
        customerDashboard(userid)
    if role == "seller":
        # addProduct.addProduct(userid)
        sellersDashboard(userid)
    if role == "delivery-person":
        pass
