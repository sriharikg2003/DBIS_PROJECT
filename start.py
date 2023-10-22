import signup
import login

option = int(input("Already have account? enter 2 \n new to flipkart? enter 1"))
if option == 1:
    signup()
elif option == 2:
    login()
