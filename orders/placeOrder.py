from conn import cursor
from conn import conn
from conn import psycopg2
from applycoupon import applycoupon
from viewProducts import viewProducts
from moneyTransactionManagement import moneyTransactionManagement


def placeOrder(userid):
    print("PRODUCT LIST")
    viewProducts()
    print(userid)
    query = f"insert into  orders  (userid) values  ({userid}) returning orderid;"
    try:
        cursor.execute(query)
        orderid = cursor.fetchone()[0]
        # print("Orderid:", orderid)
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
        query = (
            f"select stockqty, price, sellerid from product where productid={int(i)};"
        )
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
        print(
            f"{myorderitemsid[i]:<12} {demandedQuantity[i]:<6} ${price[i]:<7} ${subtotal:<9}"
        )

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

        moneyTransactionManagement(
            userid,
            totalamt,
            myorderitemsid,
            demandedQuantity,
            selleridarray,
            price,
            availableQuantity,
            orderid,
            discountpercentage,
        )
        print("ORDER PLACED SUCCESSFULLY ")
        conn.commit()
    else:
        print("Order cancelled ")
