import auth.signup as signup
import auth.login as login
import menu as menu

import sys

sys.path.append("orders")
import placeOrder as placeOrder

option = menu.menu("Authenticate", ["Signup", "SignIn"], "red")
if option == 0:
    userid = signup.signup()
    placeOrder.placeOrder(int(userid))
elif option == 1:
    userid = login.login()
    placeOrder.placeOrder(int(userid))
