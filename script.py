import tkinter as tk
from tkinter import messagebox, ttk
import psycopg2


# Function to display orders with product details in a new window
def display_orders(username):
    # Create a new window for displaying orders
    order_window = tk.Tk()
    order_window.title("Orders")
    order_window.geometry("700x400")

    # Add a label to show the user's name
    user_label = tk.Label(order_window, text=f"Welcome, {username}", bg="#FFDDC1")
    user_label.pack(pady=10)

    # Create a treeview widget to display orders and product details
    tree = ttk.Treeview(
        order_window,
        columns=(
            "OrderID",
            "OrderDate",
            "TotalAmount",
            "Product",
            "Description",
            "Seller",
        ),
    )
    tree.heading("#1", text="Order ID")
    tree.heading("#2", text="Order Date")
    tree.heading("#3", text="Total Amount")
    tree.heading("#4", text="Product")
    tree.heading("#5", text="Description")
    tree.heading("#6", text="Seller")
    tree.pack(pady=10)

    # Connect to the PostgreSQL database
    conn = psycopg2.connect(
        database="flipkart",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )

    mycursor = conn.cursor()

    # Query to retrieve orders and product details for the logged-in user
    query = """
    SELECT o.orderid, o.orderdate, o.totalamt, p.productname, p.description, s.sellername
    FROM "order" o
    JOIN orderitem oi ON o.orderid = oi.orderid
    JOIN product p ON oi.productid = p.productid
    JOIN sellerproducts sp ON p.productid = sp.productid
    JOIN seller s ON sp.sellerid = s.sellerid
    WHERE o.userid = (SELECT userid FROM users WHERE username = %s)
    """
    mycursor.execute(query, (username,))
    orders = mycursor.fetchall()

    for order in orders:
        tree.insert("", "end", values=order)

    mycursor.close()
    conn.close()

    order_window.mainloop()


# Function to display all available products in a new window
def display_all_products():
    # Create a new window for displaying products
    product_window = tk.Tk()
    product_window.title("Available Products")
    product_window.geometry("700x400")

    # Create a treeview widget to display all available products
    tree = ttk.Treeview(product_window, columns=("Product", "Description", "Seller"))
    tree.heading("#1", text="Product")
    tree.heading("#2", text="Description")
    tree.heading("#3", text="Seller")
    tree.pack(pady=10)

    # Connect to the PostgreSQL database
    conn = psycopg2.connect(
        database="flipkart",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )

    mycursor = conn.cursor()

    # Query to retrieve all available products
    query = """
    SELECT p.productname, p.description, s.sellername
    FROM product p
    JOIN sellerproducts sp ON p.productid = sp.productid
    JOIN seller s ON sp.sellerid = s.sellerid
    """
    mycursor.execute(query)
    products = mycursor.fetchall()

    for product in products:
        tree.insert("", "end", values=product)

    mycursor.close()
    conn.close()

    product_window.mainloop()


# Function to validate login
def login():
    email = entry_email.get()
    password = entry_password.get()

    # Connect to the PostgreSQL database
    conn = psycopg2.connect(
        database="flipkart",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )

    mycursor = conn.cursor()

    # Query to check if the provided email and password exist in the database
    query = "SELECT COUNT(*) FROM users WHERE email = %s AND password = %s"
    mycursor.execute(query, (email, password))
    count = mycursor.fetchone()[0]

    if count == 1:
        # Get the username of the logged-in user
        username_query = "SELECT username FROM users WHERE email = %s"
        mycursor.execute(username_query, (email,))
        username = mycursor.fetchone()[0]

        messagebox.showinfo("Login", "Login Successful")
        # Close the login window
        root.destroy()
        # Open a new window with buttons for displaying orders and all available products
        option_window = tk.Tk()
        option_window.title("Options")
        option_window.geometry("300x100")

        button_orders = tk.Button(
            option_window,
            text="Display My Orders",
            command=lambda: display_orders(username),
        )
        button_products = tk.Button(
            option_window,
            text="Display All Available Products",
            command=display_all_products,
        )

        button_orders.pack(pady=10)
        button_products.pack(pady=10)

        option_window.mainloop()
    else:
        messagebox.showerror("Login", "Invalid email or password")

    mycursor.close()
    conn.close()


# Create the main window
root = tk.Tk()
root.title("Login Form")
root.geometry("300x200")

bg_color = "#FFDDC1"
text_color = "#333333"

root.configure(bg=bg_color)

label_email = tk.Label(root, text="Email:", bg=bg_color, fg=text_color)
label_password = tk.Label(root, text="Password:", bg=bg_color, fg=text_color)
entry_email = tk.Entry(root, bg="#E2E2E2")
entry_password = tk.Entry(root, show="*", bg="#E2E2E2")
button_login = tk.Button(root, text="Login", command=login, bg="#4CAF50", fg="white")

label_email.grid(row=0, column=0, padx=10, pady=5)
entry_email.grid(row=0, column=1, padx=10, pady=5)
label_password.grid(row=1, column=0, padx=10, pady=5)
entry_password.grid(row=1, column=1, padx=10, pady=5)
button_login.grid(row=2, columnspan=2, pady=10)

root.mainloop()


# import tkinter as tk

# class SampleApp:
#     def _init_(self, root):
#         self.root = root
#         self.root.geometry("400x300")
#         self.root.title("Tkinter Routing Example")

#         self.frame = None

#         self.show_home()

#     def show_home(self):
#         if self.frame is not None:
#             self.frame.destroy()

#         self.frame = tk.Frame(self.root)
#         self.frame.pack(fill="both", expand=True)

#         label = tk.Label(self.frame, text="Welcome to the Home Page", font=("Helvetica", 18))
#         label.pack(pady=20)

#         button = tk.Button(self.frame, text="Go to Page 2", command=self.show_page2)
#         button.pack()

#     def show_page2(self):
#         if self.frame is not None:
#             self.frame.destroy()

#         self.frame = tk.Frame(self.root)
#         self.frame.pack(fill="both", expand=True)

#         label = tk.Label(self.frame, text="This is Page 2", font=("Helvetica", 18))
#         label.pack(pady=20)

#         button = tk.Button(self.frame, text="Go back to Home", command=self.show_home)
#         button.pack()

# if _name_ == "_main_":
#     root = tk.Tk()
#     app = SampleApp(root)
#     root.mainloop()
