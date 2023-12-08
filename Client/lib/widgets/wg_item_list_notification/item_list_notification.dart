import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemListNotificationWidget extends StatelessWidget {
  final int orderID;
  final String noticesMessage;
  final String foodImage;
  final String foodName;
  final int quantity;
  final DateTime time;

  const ItemListNotificationWidget({
    super.key,
    required this.orderID,
    required this.noticesMessage,
    required this.foodImage,
    required this.foodName,
    required this.quantity,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Ink(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    foodImage,
                    height: 59,
                    width: 59,
                    fit: BoxFit.cover,
                  ),
                  noticesMessage == "success"
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Success (ĐH$orderID - $foodName x$quantity)",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Invoice ĐH$orderID has been created, the order has been transferred to the shipping unit.",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(time),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(95, 95, 95, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Error (ĐH$orderID - $foodName x$quantity)",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "Invoice ĐH$orderID has been canceled, possibly due to overbooking, please reorder",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(time),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(95, 95, 95, 1)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
          const Divider(
            color: Color.fromRGBO(204, 204, 204, 1),
            thickness: 1,
          )
        ],
      ),
    );
  }
}
