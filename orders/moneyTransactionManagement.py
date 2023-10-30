from conn import cursor
from conn import psycopg2
from conn import conn
from datetime import datetime, timedelta


def moneyTransactionManagement(
    userid,
    totalamt,
    myorderitemsid,
    demandedQuantity,
    selleridarray,
    price,
    availableQuantity,
    orderid,
    discount_percentage,
):
    try:
        cursor.execute("SELECT NOW()")
        current_timestamp = cursor.fetchone()[0]
    except:
        print("ERROR Could not get current timestamp")

    query = f"select balance from wallet where userid={userid};"
    try:
        cursor.execute(query)
        rows = cursor.fetchall()
    except:
        print("ERROR Could not find balance")

    walletproceed = False
    codproceed = False
    print(rows)
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
        value = (demandedQuantity[k] * price[k]) * (1 - (discount_percentage / 100))
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
        except:
            print("ERROR Could not update sellerid balance")

    for k in range(len(selleridarray)):
        value = availableQuantity[k] - demandedQuantity[k]
        query = f"UPDATE product SET stockqty = {value} WHERE productid = {myorderitemsid[k]};"
        try:
            cursor.execute(query)
        except:
            print("ERROR Could not decrease stock quantity")

    query = f"UPDATE orders SET userid = {userid}, orderdate = '{current_timestamp}', totalamt = {totalamt}, shippingaddressid = 1 , paymentmethodid = {paymentmethodid} WHERE orderid = {orderid};"

    try:
        cursor.execute(query)
    except:
        print("ERROR Could not set orders")

    shipping_status = "On the way"  # Corrected variable name
    deliveryboyid = 1
    insert_query = """
    INSERT INTO shipment (orderid, shipmentdate, estimateddeliverydate, shippingstatus, deliverypersonID)
    VALUES (%s, %s, %s, %s, %s);
    """
    try:
        cursor.execute(
            insert_query,
            (
                orderid,
                current_timestamp,
                current_timestamp + timedelta(days=7),
                shipping_status,
                deliveryboyid,
            ),
        )
    except psycopg2.DatabaseError as e:
        print(f"Error inserting shipment data: {e}")
    print("Successfull")
