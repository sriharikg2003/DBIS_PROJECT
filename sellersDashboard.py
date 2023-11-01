import sys

sys.path.append("sellers")

from sellers import addProduct
from sellers import displayStats


def display():
    inp = int(input("Enter\n1.Add Products\n2.Show my statistics \n3.Logout\n"))
    return inp


def sellersDashboard(userid):
    ret_val = display()
    if ret_val == 1:
        addProduct.addProduct(userid)
        sellersDashboard(userid)
    if ret_val == 2:
        displayStats.displayStats(userid)
        sellersDashboard(userid)
    if ret_val == 3:
        print("Thank you for using flipkart")
        SystemExit()
