import psycopg2
import sys

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


def viewCategories():
    query = "SELECT * from categories;"
    try:
        cursor.execute(query)
        print(cursor.fetchall())
    except psycopg2.DatabaseError as error:
        print("Failed to fetch categories")


def addProduct(seller):
    productname = input("Enter productname: ")
    description = input("Enter product description: ")
    price = float(input("Enter product price: "))
    stockqty = int(input("Enter Stock Quantity: "))
    print("enter product category ID from categories shown below: ")
    viewCategories()
    categoryid = input()
    sellerid = seller.userid
    query = f"INSERT INTO product (productname, description, price, stockqty, categoryid, sellerid) VALUES ('{productname}', '{description}', {price}, {stockqty}, {categoryid},{sellerid})"
    try:
        cursor.execute(query)
        conn.commit()
    except psycopg2.DatabaseError as error:
        conn.rollback()
        print(error)
        inp = input("Enter 1 to exit and 2 to try again")
        if inp == 1:
            return
        else:
            addProduct(seller)


conn.close()
cursor.close()
