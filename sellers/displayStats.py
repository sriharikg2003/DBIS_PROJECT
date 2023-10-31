import psycopg2
import sys
import matplotlib.pyplot as plt


conn = psycopg2.connect(
        database="flipkart",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )
cursor = conn.cursor()

# Map the '10' to a month
month_mapping = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
}

months = [
    "January", "February", "March", "April",
    "May", "June", "July", "August",
    "September", "October", "November", "December"
]

def displayOptions(sellerid):
    # Input options
    print("Choose :\n1: Items sold per product")
    print("2: Monthly sales")
    print("3: Category wise sales")
    chosenOption = input("\n\nEnter the option number")
    return chosenOption


def plotfunction(title, x_data, y_data, x_label, y_label):
    plt.figure(figsize=(8, 5))  # Adjust the figure size as needed

    # Create a bar plot with a reduced width
    plt.bar(x_data, y_data, color='skyblue', alpha=0.7, edgecolor='k', width=0.6)  # Adjust the width as needed
    plt.title(title, fontsize=16)
    plt.xlabel(x_label, fontsize=14)
    plt.ylabel(y_label, fontsize=14)
    
    # Customize the tick labels and title font size
    plt.xticks(rotation=45, fontsize=12)  # Rotate x-axis labels for better readability
    plt.yticks(fontsize=12)

    plt.show()


def ItemSoldPerProduct(userid):

    query = f"select  product.productname, sum(orderitem.quantity) ,orderitem.productid from orders, product , orderitem where orderitem.orderid = orders.orderid and product.productid = orderitem.productid and product.sellerid = {userid}  group by orderitem.productid, product.productname ;"
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        x_data = []
        y_data = []
        for r in rows:
            x_data.append(r[0])
            y_data.append(r[1])
        plotfunction("Quanity vs Product Name", x_data, y_data, "Product Name", "Quantity Sold")

    except:
        print(" ERROR ")
    pass

def MonthlySales(userid):
    query = f"""
    SELECT
        EXTRACT(MONTH FROM orderdate) AS order_month,
        SUM(product.price * (1-(coupon.discountpercentage/100))) AS total_price_discount
    FROM
        coupon
    JOIN
        orders ON coupon.couponid = orders.couponid
    JOIN
        orderitem ON orders.orderid = orderitem.orderid
    JOIN
        product ON orderitem.productid = product.productid
    WHERE
        product.sellerid = {userid} and EXTRACT(YEAR FROM orders.orderdate) = EXTRACT(YEAR FROM CURRENT_TIMESTAMP)
    GROUP BY
        order_month
    ORDER BY
        order_month;
    """

    try:
        cursor.execute(query)
        rows = cursor.fetchall()
        x_data = []
        y_data = [0]*12
        for r in rows:
            y_data[int(r[0])-1]  = r[1]
        plotfunction("Monthly sales ", months, y_data, "Month", "Sales in Dollars")

    except:
        print(" ERROR")
    pass

def CategorySales(userid):
    pass


def choosePlotFunction(userid, option):
    if option == 1:
        ItemSoldPerProduct(userid,option)
    elif option == 2:
        MonthlySales(userid,option)

    
