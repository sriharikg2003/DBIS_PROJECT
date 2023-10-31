from addProduct import addProduct
from displayStats import displayStats

def sellersDashboard(userid):
    print("Choose options")
    print("1: Add products")
    print("2: Show my statistics")
    print("3: Quit")
    
    while(True):
        choseOptions = input("Enter your option")
        if int(choseOptions)==1:
            addProduct.addProduct(userid) 
        elif int(choseOptions)==2:
            displayStats.displayStats(userid)
        elif int(choseOptions)==3:
            print("Thank you")
            break
