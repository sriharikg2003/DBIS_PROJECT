import psycopg2
import time

conn = psycopg2.connect(
    database="flipkart",
    host="localhost",
    user="postgres",
    password="1234",
    port=5432,
)

cur = conn.cursor()


def add_to_wishlist(user_id, product_id):
    try:
        cur.execute("SELECT wishlistid FROM wishlists WHERE userid = %s", (user_id,))
        row = cur.fetchone()
        if row:
            wishlist_id = row[0]
        else:
            cur.execute(
                "INSERT INTO wishlists (userid) VALUES (%s) RETURNING wishlistid",
                (user_id,),
            )
            wishlist_id = cur.fetchone()[0]

        cur.execute(
            "INSERT INTO wishlistitem (wishlistid, productid) VALUES (%s, %s)",
            (wishlist_id, product_id),
        )
        conn.commit()
        print("Product added to the wishlist successfully!")
    except psycopg2.Error as e:
        conn.rollback()
        print("Error adding product to wishlist:", e)


def delete_from_wishlist(wishlist_item_id):
    try:
        cur.execute(
            "DELETE FROM wishlistitem WHERE wishlistitemid = %s", (wishlist_item_id,)
        )
        conn.commit()
        print("Product deleted from the wishlist successfully!")
    except psycopg2.Error as e:
        conn.rollback()
        print("Error deleting product from wishlist:", e)


def view_wishlist(user_id):
    try:
        cur.execute(
            "SELECT wi.wishlistitemid, p.productname FROM wishlistitem wi \
                    INNER JOIN product p ON wi.productid = p.productid \
                    INNER JOIN wishlists w ON wi.wishlistid = w.wishlistid \
                    WHERE w.userid = %s",
            (user_id,),
        )
        rows = cur.fetchall()
        if rows:
            print("Your Wishlist:")
            for row in rows:
                print(f"Wishlist Item ID: {row[0]}, Product Name: {row[1]}")
        else:
            print("Wishlist is empty.")
    except psycopg2.Error as e:
        print("Error fetching wishlist:", e)


def wishList(userid):
    view_wishlist(userid)
    x = input(
        "Enter 1 to add product to wishlist. enter 2 to delete product from wishlist. q to return to dashboard\n"
    )
    if x == "1":
        productid = input("Enter product id. Enter q to cancel.")
        if productid == "q":
            wishList(userid)
        else:
            add_to_wishlist(userid, int(productid))
    if x == "2":
        wishListitem_id = input("Enter wishlistitem id. Enter q to cancel.")
        if wishListitem_id == "q":
            wishList(userid)
        else:
            delete_from_wishlist(int(wishListitem_id))
    else:
        return
