import auth.signup as signup
import auth.login as login
import sellers.addProduct as addProduct

option = int(input("Enter:\n1.New to Flipkart?\n2. Already have account?\n"))
if option == 1:
    user = signup.signup()
    print(user)
    if user.usertype == "seller":
        addProduct(user)
elif option == 2:
    user = login.login()
    print(user)
    if user.usertype == "seller":
        addProduct(user)
