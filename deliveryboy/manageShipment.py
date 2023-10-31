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
        SELECT shipmentid, orderid, shipmentdate, shippingstatus 
        FROM shipment 
        WHERE deliverypersonID = %s AND shippingstatus = %s
    """
    )
    cur.execute(query, (delivery_person_id, "On the way"))
    print(cur.fetchall())


def update_shipment_status(shipment_id, status, delivery_date):
    query = sql.SQL(
        """
        UPDATE shipment 
        SET shippingstatus = %s, actualdeliverydate = %s 
        WHERE shipmentid = %s
    """
    )
    cur.execute(query, (status, delivery_date, shipment_id))
    conn.commit()


def mark_shipment_delivered(shipment_id, delivery_date):
    update_shipment_status(shipment_id, "Delivered", delivery_date)


def get_delivery_person_orders(delivery_person_id):
    query = sql.SQL(
        """
        SELECT orders.orderid, orders.totalamt, shipment.shipmentdate, shipment.shippingstatus 
        FROM orders 
        JOIN shipment ON orders.orderid = shipment.orderid 
        WHERE shipment.deliverypersonID = %s
    """
    )
    cur.execute(query, (delivery_person_id,))
    return cur.fetchall()
