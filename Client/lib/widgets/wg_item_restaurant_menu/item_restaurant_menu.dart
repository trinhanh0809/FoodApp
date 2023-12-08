import "package:flutter/material.dart";
import 'package:foodapp/screen/sc_dish_details/dish_details.dart';
import 'package:intl/intl.dart';

class ItemRestaurantMenuWidget extends StatelessWidget {
  final int id;
  final String name;
  final double price;
  final String ingredients;
  final String description;
  final String imgThumbnail;
  final int totalOrders;

  const ItemRestaurantMenuWidget({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.description,
    required this.imgThumbnail,
    required this.totalOrders,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DishDetailsScreen(idProduct: id)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                color: const Color.fromARGB(255, 220, 139, 139),
                child: Image.network(
                  imgThumbnail,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
                      child: Text(
                        ingredients,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(price)}₫",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 102, 144, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${totalOrders.toString()} lượt bán",
                            style: const TextStyle(
                              color: Color.fromRGBO(96, 96, 96, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
