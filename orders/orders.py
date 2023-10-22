import psycopg2
import sys
from datetime import datetime, timedelta

# Pending wallet balance insertion
conn = psycopg2.connect(database='flipkart', host="localhost", user="postgres", password="11042003", port=5432)
cursor = conn.cursor()

# Code starts
def applycoupon():
    try:
        cursor.execute("SELECT NOW()")
        current_timestamp = cursor.fetchone()[0]
    except:
        print("ERROR Could not find TIME")

    
    query = """
        SELECT couponid, couponcode, discountpercentage
        FROM coupon
        WHERE expirationdate > %s ;
    """
    try:
        cursor.execute(query, (current_timestamp,))
        rows = cursor.fetchall()
    except:
        print("ERROR Could not find coupon")
    if len(rows) == 0:
        print("No non-expired coupons available.")
        return 0
    else:
        print("Your coupons are:")
        print("{:<12} {:<15} {:<18}".format("Coupon ID", "Coupon Code", "Discount Percentage"))
        print("-" * 45)

        for row in rows:
            print("{:<12} {:<15} {:<18}".format(row[0], row[1], f"{row[2]}%"))

        coupon_id = input("Enter COUPON ID you want to use: ")
        query = "SELECT discountpercentage FROM coupon WHERE couponid = %s;"
        try:
            cursor.execute(query, (coupon_id,))
            discount_percentage_tuple = cursor.fetchone()
        except:
            print("ERROR Could not find discount percentage")


        if discount_percentage_tuple:
            discount_percentage = discount_percentage_tuple[0]
            print(f"Selected coupon's discount percentage: {discount_percentage}%")
            return discount_percentage
        else:
            print("Coupon not found.")
            return applycoupon()

def viewProducts():
    query = """
    SELECT p.productid, p.productname, p.description, p.price, p.stockqty, c.category
    FROM product p
    JOIN categories c ON p.categoryid = c.categoryid;
    """
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
    except:
        print("ERROR Could not find products")


    if len(rows) == 0:
        print("No products available.")
    else:
        headers = ("ID", "Product Name", "Description", "Price ($)", "Stock Qty", "Category")
        max_widths = [len(header) for header in headers]
        for row in rows:
            for i, element in enumerate(row):
                max_widths[i] = max(max_widths[i], len(str(element)))
            format_string = " | ".join(["{{:<{}}}".format(width) for width in max_widths])
            print(format_string.format(*headers))
            print("-" * (sum(max_widths) + len(max_widths) * 3 - 1))
            for row in rows:
                print(format_string.format(*row))

def placeOrder(userid):
    print("The products are as follows:")
    viewProducts()
    query = f"insert into  orders  (userid) values  ({userid}) returning orderid;"
    try:
        cursor.execute(query)
        orderid = cursor.fetchone()[0]
        print("Orderid:", orderid)
    except:
        print("ERROR Could not insert orderid")


    myorderitemsid = []
    demandedQuantity = []
    selleridarray = []
    availableQuantity = []
    price = []
    
    while True:
        i = input("Enter product id: type 'q' to end\n")
        if i == "q":
            break
        q = int(input("Enter quantity"))
        query = f"select stockqty, price, sellerid from product where productid={int(i)};"
        try:
            cursor.execute(query)
            rows = cursor.fetchall()
            x, y, z = rows[0]
            if int(x) >= q:
                availableQuantity.append(int(x))
                price.append(y)
                selleridarray.append(int(z))
                myorderitemsid.append(int(i))
                demandedQuantity.append(q)
            else:
                print("Stock not available.")
        except:
                print("ERROR Could not append quantity")

    
    print("\n\nYOUR ORDERS ARE:")
    totalamt = 0
    print("ProductID    Qty    Price    Subtotal")
    
    for i in range(len(availableQuantity)):
        subtotal = demandedQuantity[i] * price[i]
        totalamt += subtotal
        print(f"{myorderitemsid[i]:<12} {demandedQuantity[i]:<6} ${price[i]:<7} ${subtotal:<9}")
    
    discountpercentage = applycoupon()
    totalamt = totalamt * (1 - (discountpercentage / 100))
    print(f"TOTAL BILL AMT  ${totalamt}")
    
    confirm = input("Click 1 to confirm")
    if confirm == "1":
        print("Proceeding to payments page...")
        
        for k in range(len(myorderitemsid)):
            query = f"insert into  orderitem  (orderid, productid, quantity ) values  ({orderid},{myorderitemsid[k]},{demandedQuantity[k]});"
            try:
                cursor.execute(query)
            except:
                print("ERROR Could not insert orderitem")

        moneyTransactionManagement(userid, totalamt, myorderitemsid, demandedQuantity, selleridarray, price, availableQuantity,orderid, discountpercentage)
        print("ORDER PLACED SUCCESSFULLY ")
        conn.commit()
    else:
        print("Order cancelled ")

def moneyTransactionManagement(userid, totalamt, myorderitemsid, demandedQuantity, selleridarray, price, availableQuantity,orderid, discount_percentage):
   
    try:
        cursor.execute("SELECT NOW()")
        current_timestamp = cursor.fetchone()[0]
    except:
        print("ERROR Could not get current timestamp")


    query = f"select balance from wallet where userid={userid};"
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
    except :
        print("ERROR Could not find balance")


    walletproceed = False
    codproceed = False
    availablebalance = rows[0][0]
    
    if availablebalance < totalamt:
        print("You must proceed to COD due to insufficient balance")
        codproceed = True
        ptype = "COD"
    else:
        paymentType = input("Enter 1 for Wallet Payment: 2 for Cash on Delivery")
        if paymentType == "1":
            walletproceed = True
            ptype = "Wallet"
        elif paymentType == "2":
            codproceed = True
            ptype = "COD"
        else:
            print("Transaction failed")
            return
    
    query = f"insert into  paymentsmethod  (userid, paymenttype) values  ( {userid} , '{ptype}') returning paymentmethodid;"

    try:
        cursor.execute(query)
        paymentmethodid = cursor.fetchone()[0]
    except:
        print("ERROR Could not find coupon")


    print("INSERT INTO paymentsmethod ")
    
    if walletproceed:
        new_balance = availablebalance - totalamt
        query = f"UPDATE wallet SET balance = {new_balance} WHERE userid = {userid};"
        try:
            cursor.execute(query)
        except:
            print("ERROR Could not update user balance")
        
        query = f"select balance from wallet where userid={userid};"

        try:
            cursor.execute(query)
            rows = cursor.fetchall()
        except:
            print("ERROR Could not get user balance")

        print(f"Amount deduced from your wallet.\nCurrent Balance: {rows[0][0]}")
    
    for k in range(len(selleridarray)):
        value = (demandedQuantity[k] * price[k])*(1-(discount_percentage/100))
        query = f"select balance from wallet where userid={selleridarray[k]};"
        try:
            cursor.execute(query)
            rows = cursor.fetchall()
            availablebalance = rows[0][0]
        except:
            print("ERROR Could not find sellerid balance")


        query = f"UPDATE wallet SET balance = {value + availablebalance} WHERE userid = {selleridarray[k]};"
        try:
            cursor.execute(query)
        except :
            print("ERROR Could not update sellerid balance")


    for k in range(len(selleridarray)):
        value = availableQuantity[k] - demandedQuantity[k]
        query = f"UPDATE product SET stockqty = {value} WHERE productid = {myorderitemsid[k]};"
        try:
            cursor.execute(query)
        except :
            print("ERROR Could not decrease stock quantity")
    
    query = f"UPDATE orders SET userid = {userid}, orderdate = '{current_timestamp}', totalamt = {totalamt}, shippingaddressid = 1 , paymentmethodid = {paymentmethodid} WHERE orderid = {orderid};"
    print(query)

    try:
        cursor.execute(query)
    except :
        print("ERROR Could not set orders")

    shipping_status = "On the way"  # Corrected variable name
    deliveryboyid = 1
    insert_query = """
    INSERT INTO shipment (orderid, shipmentdate, estimateddeliverydate, shippingstatus, deliverypersonID)
    VALUES (%s, %s, %s, %s, %s);
    """

    try:
        cursor.execute(insert_query, (orderid, current_timestamp, current_timestamp + timedelta(days=7), shipping_status, deliveryboyid))
        # shipment_id = cursor.fetchone()[0]
        # conn.commit()
        # print(f"Shipment data with ID {shipment_id} inserted successfully.")
    except psycopg2.DatabaseError as e:
        # conn.rollback()
        print(f"Error inserting shipment data: {e}")



    print("Successfull")

# viewProducts()
placeOrder(3)
conn.commit()
