import psycopg2
from psycopg2 import sql

# Establish connection to your PostgreSQL database
conn = psycopg2.connect(
    database="flipkart",
    host="localhost",
    user="postgres",
    password="1234",
    port=5432,
)
cur = conn.cursor()


def get_pending_shipments(delivery_person_id):
    query = sql.SQL(
        """
        SELECT shipmentid, shipmentdate, shippingstatus 
        FROM shipment 
        WHERE deliverypersonID = %s AND shippingstatus = %s
    """
    )
    cur.execute(query, (delivery_person_id, "In Transit"))
    for x in cur.fetchall():
        print(x)


def update_shipment_status(shipment_id, status):
    query = sql.SQL(
        """
        UPDATE shipment 
        SET shippingstatus = %s, actualdeliverydate = %s 
        WHERE shipmentid = %s
    """
    )
    try:
        cur.execute("SELECT NOW()")
        ts = cur.fetchone()[0]
        cur.execute(query, (status, ts, shipment_id))
        conn.commit()
        print("Updated shipment status successfully.\n")
    except:
        print("failed to update.")
        conn.rollback()


def mark_shipment_delivered(shipment_id):
    update_shipment_status(shipment_id, "Delivered")


def get_delivery_person_orders(delivery_person_id):
    query = sql.SQL(
        """
        SELECT orders.orderid, orders.totalamt, shipment.shipmentdate, shipment.shippingstatus 
        FROM orders 
        JOIN shipment ON orders.orderid = shipment.orderid 
        WHERE shipment.deliverypersonID = %s
    """
    )
    try:
        cur.execute(query, (delivery_person_id,))
        for i in cur.fetchall():
            print(i)
        if len(cur.fetchall()):
            print("No orders found")
    except:
        print("Somethong went wrong")
