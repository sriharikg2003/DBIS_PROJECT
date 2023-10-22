import auth.signup as signup
import auth.login as login

option = int(input("Enter:\n1.New to Flipkart?\n2. Already have account?\n"))
if option == 1:
    signup.signup()
elif option == 2:
    login.login()
