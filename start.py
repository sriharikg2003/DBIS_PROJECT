import auth.signup as signup
import auth.login as login
import menu as menu
from customerDashboard import customerDashboard

option = menu.menu("Authenticate", ["Signup", "SignIn"], "red")
if option == 0:
    userid = signup.signup()
    customerDashboard(userid)
    # placeOrder.placeOrder(int(userid))
elif option == 1:
    userid = login.login()
    customerDashboard(userid)
    # placeOrder.placeOrder(int(userid))
