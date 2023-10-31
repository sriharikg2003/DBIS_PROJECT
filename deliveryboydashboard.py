import sys

sys.path.append("deliveryboy")

from deliveryboy import manageShipment


def display():

    inp = int(
        input(
            "Enter\n1.Get pending shipment\n2.Update shipment \n3.Mark shipment\n4.Get delivery person orders\n5.Logout"
        )
    )
    return inp

def DeliveryDashboard(userid):
    ret_val = display()
    if ret_val == 1:
        manageShipment.get_pending_shipments(userid)
        DeliveryDashboard(userid)
    if ret_val == 2:
        manageShipment.update_shipment_status(userid)
        DeliveryDashboard(userid)
    if ret_val == 3:
        manageShipment.mark_shipment_delivered(userid)
        DeliveryDashboard(userid)
    if ret_val == 4:
        manageShipment.get_delivery_person_orders(userid)
        DeliveryDashboard(userid)
    if ret_val == 5:
        print("Thank you for using flipkart")
        SystemExit()
