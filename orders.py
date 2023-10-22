import psycopg2
import sys


# pending wallet balace insertion
try:
    conn = psycopg2.connect(database='flipkart',
                            host="localhost",
                            user="postgres",
                            password="11042003",
                            port=5432) 
                            
    cursor = conn.cursor()

except:
    sys.exit("Failed to connect to the database")



#code starts
       

def viewProducts():
    try:
        query = """
        SELECT p.productid, p.productname, p.description, p.price, p.stockqty, c.category
        FROM product p
        JOIN categories c ON p.categoryid = c.categoryid;
        """
        cursor.execute(query)
        rows = cursor.fetchall()

        if len(rows) == 0:
            print("No products available.")
        else:
            # Define the column headers
            headers = ("ID","Product Name", "Description", "Price ($)", "Stock Qty", "Category")

            # Calculate the maximum column widths for formatting
            max_widths = [len(header) for header in headers]
            for row in rows:
                for i, element in enumerate(row):
                    max_widths[i] = max(max_widths[i], len(str(element)))

            # Create a format string with dynamic column widths
            format_string = " | ".join(["{{:<{}}}".format(width) for width in max_widths])

            # Print the column headers
            print(format_string.format(*headers))
            print("-" * (sum(max_widths) + len(max_widths) * 3 - 1))

            # Print the product data
            for row in rows:
                print(format_string.format(*row))
    except psycopg2.DatabaseError as error:
        print("Error:", error)


def placeOrder(userid):
    print("The products are as follows:")
    viewProducts()
    myorderitemsid=[]
    quantity = []
    # i = input("Enter number ")
    ctr = ""
    while(True):
        # print("Enter product id and the quantity you want to buy")
        i = input("Enter product id : type q to end\n")

        if (i=="q"):
            break
        q = int(input("Enter quantity"))

        myorderitemsid.append(int(i))
        quantity.append(q)

    stk = []
    price = []
    for k in range(len(myorderitemsid)):

        query = f"select stockqty,price from product where productid={myorderitemsid[k]};"
        cursor.execute(query)
        rows = cursor.fetchall()
        x,y = rows[0]
        stk.append(int(x))
        price.append(y)
    


    for i in range(len(stk)):
        if quantity[i] > stk[i]:
            quantity[i] = stk[i]
            print(f"ORDER {myorderitemsid[i]} CLIPPED DOWN TO {quantity[i]} DUE TO SHORTAGE")
            
    print("\n\nYOUR ORDERS ARE:")
        
    totalamt = 0
    print("ProductID    Qty    Price    Subtotal")
    for i in range(len(stk)):
        subtotal = quantity[i] * price[i]
        totalamt += subtotal
        print(f"{myorderitemsid[i]:<12} {quantity[i]:<6} ${price[i]:<7} ${subtotal:<9}")

    print(f"TOTAL BILL AMT  ${totalamt}")

    confirm  = input("Click 1 to confirm")
    if confirm=="1":
        print("Proceeding to payments page...")
        moneyTransactionManagement(userid, totalamt,myorderitemsid,quantity)
    else :
        print("Order cancelled ")
        

def moneyTransactionManagement(userid, totalamt,myorderitemsid,quantity):
    query = f"select balance from wallet where userid={userid};"
    cursor.execute(query)
    rows = cursor.fetchall()
    walletproceed = False
    codproceed = False
    availablebalance = rows[0]
    if availablebalance<totalamt:
        print("You must proceed to COD due to insufficient balance")
        codproceed  = True
    else:
        paymentType = input("Enter 1 for Wallet Payment : 2 for Cash on Delivery")
        if(paymentType=="1"):
            walletproceed = True    
        
        elif paymentType=="2":
            codproceed = True
        else:
            print("Transaction failed")
            return 

    if(walletproceed):
        

# viewProducts()
placeOrder(1)