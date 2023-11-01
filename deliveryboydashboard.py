import sys

sys.path.append("deliveryboy")

from deliveryboy import manageShipment


def display():
    inp = int(
        input(
            "Enter\n1.Get pending shipment\n2.mark shipment as delivered.\n3Get delivery person orders\n4.Logout\n"
        )
    )
    return inp


def DeliveryDashboard(userid):
    ret_val = display()
    if ret_val == 1:
        manageShipment.get_pending_shipments(userid)
        DeliveryDashboard(userid)
    if ret_val == 2:
        if  not (manageShipment.get_pending_shipments(userid)==0):
            x = int(input("\nEnter shipment ID"))
            manageShipment.mark_shipment_delivered(x)
        else:
            print("\nYou have no orders")

        DeliveryDashboard(userid)
    if ret_val == 3:
        manageShipment.get_delivery_person_orders(userid)
        DeliveryDashboard(userid)
    if ret_val == 4:
        print("\nThank you for using flipkart")
        SystemExit()
