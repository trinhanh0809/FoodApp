import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import 'package:foodapp/screen/sc_dish_details/dish_details.dart';
import "package:intl/intl.dart";

class ListOrderHistoryWidget extends StatelessWidget {
  final int orderID;
  final int foodID;
  final String name;
  final String imageUrl;
  final String orderDatetime;
  final int quantity;
  final double price;
  final double totalPrice;

  // Constructor
  const ListOrderHistoryWidget({
    super.key,
    required this.orderID,
    required this.foodID,
    required this.name,
    required this.imageUrl,
    required this.orderDatetime,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DishDetailsScreen(idProduct: foodID),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.network(
                        imageUrl,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 3, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(price)}₫",
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 102, 144, 1.0),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text("x$quantity"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              color: Color.fromRGBO(200, 200, 200, 1),
              thickness: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/vectors/listIcon.svg'),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                orderDatetime,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                        "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(totalPrice)}₫",
                        style: const TextStyle(
                            color: Color.fromRGBO(0, 102, 144, 1.0),
                            fontSize: 17,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
