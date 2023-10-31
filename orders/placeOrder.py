from conn import cursor
from conn import conn
from conn import psycopg2
from applycoupon import applycoupon
from moneyTransactionManagement import moneyTransactionManagement


def placeOrder(userid):
    print("The products are as follows:")
    try:
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
        totalamt = 0
        if len(myorderitemsid) == 0:
            print("No items are ordered..!")
            return
        query = f"insert into  orders (userid) values  ({userid}) returning orderid;"
        try:
            cursor.execute(query)
            orderid = cursor.fetchone()[0]
            print("Orderid:", orderid)
        except:
            print(query)
            print("ERROR Could not insert orderid")
        print("\n\nYOUR ORDERS ARE:")

        print("ProductID    Qty    Price    Subtotal")

        for i in range(len(availableQuantity)):
            subtotal = demandedQuantity[i] * price[i]
            totalamt += subtotal
            print(
                f"{myorderitemsid[i]:<12} {demandedQuantity[i]:<6} ${price[i]:<7} ${subtotal:<9}"
            )

        discount_percentage, coupon_id = applycoupon()
        totalamt = totalamt * (1 - (discount_percentage / 100))
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
                discount_percentage,
                coupon_id,
            )
            print("ORDER PLACED SUCCESSFULLY ")
            conn.commit()
        else:
            print("Order cancelled ")
    except:
        conn.rollback()
        print("\n\n Order could not be placed")
