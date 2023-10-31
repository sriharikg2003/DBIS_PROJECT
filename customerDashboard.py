import menu as menu
import updateAddress as updateAddress
import sys

sys.path.append("orders")
from orders import viewProducts
from orders import placeOrder
import manageWallet as manageWallet
import wishList


def display():
    return menu.menu(
        "Dashboard",
        [
            "View Products",
            "Manage Wallet",
            "Update Personal Address",
            "Logout",
        ],
        "red",
    )


def customerDashboard(user_id):
    ret_val = display()
    if ret_val == 0:
        viewProducts.viewProducts()
        print()
        x = int(input("Enter 1 to buy products. Enter 2 to add product to wishlist\n"))
        if x == 1:
            placeOrder.placeOrder(user_id)
        if x == 2:
            wishList.wishList(user_id)
        customerDashboard(user_id)
    if ret_val == 1:
        success = manageWallet.manageWallet(user_id)
        print()
        customerDashboard(user_id)
    if ret_val == 2:
        updateAddress.updateAddress(user_id)
        customerDashboard(user_id)
    if ret_val == 3:
        print("Thank you for using flipkart")
        SystemExit()
