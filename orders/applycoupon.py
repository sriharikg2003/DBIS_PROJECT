from conn import cursor

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