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
        manageShipment.get_pending_shipments(userid)
        x = int(input("Enter shipment ID"))
        manageShipment.mark_shipment_delivered(x)
        DeliveryDashboard(userid)
    if ret_val == 3:
        manageShipment.get_delivery_person_orders(userid)
        DeliveryDashboard(userid)
    if ret_val == 4:
        print("Thank you for using flipkart")
        SystemExit()
