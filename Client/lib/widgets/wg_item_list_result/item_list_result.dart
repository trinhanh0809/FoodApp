import 'package:flutter/material.dart';
import 'package:foodapp/screen/sc_dish_details/dish_details.dart';
import 'package:intl/intl.dart';

class ItemListResultWidget extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;
  final double price;
  final int totalSold;

  const ItemListResultWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
    required this.price,
    required this.totalSold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DishDetailsScreen(idProduct: id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          ingredients,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(95, 95, 95, 1),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(price)}₫",
                            style: const TextStyle(
                                color: Color.fromRGBO(0, 102, 144, 1.0),
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              "$totalSold lượt bán",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(134, 134, 134, 1),
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
      ),
    );
  }
}
