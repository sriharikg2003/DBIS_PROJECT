from conn import cursor
from conn import psycopg2


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
