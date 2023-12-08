import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/models/entities/order.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/sc_order_history/order_history.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/entities/food.entity..dart';

class OrderProcessingScreen extends StatefulWidget {
  final int? idProduct;

  const OrderProcessingScreen({
    Key? key,
    this.idProduct,
  }) : super(key: key);

  @override
  _OrderProcessingScreenState createState() => _OrderProcessingScreenState();
}

class _OrderProcessingScreenState extends State<OrderProcessingScreen> {
  Food? foodItem;
  Order? orderEntity;

  LoadStatus loadFoodStatus = LoadStatus.loading;
  LoadStatus loadOrderStatus = LoadStatus.success;

  double _totalPrice = 0;
  int? idUser;
  int _quantity = 1;
  int? idFood;

  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idFood = widget.idProduct;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String apiUrl = "${dotenv.env['BASE_URL']}/foods/find/$idFood";
      final response = await http.get(
        Uri.parse(apiUrl),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          loadFoodStatus = LoadStatus.success;
          foodItem = Food.fromJson(data);
          _totalPrice = foodItem?.price ?? 0;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadFoodStatus = LoadStatus.failure;
      });
    }
  }

  Future<void> pushData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrlOrder = "${dotenv.env['BASE_URL']}/orders/post_orders";
      setState(() {
        loadOrderStatus = LoadStatus.loading;
      });

      orderEntity = Order(
        foodId: idFood,
        userID: int.parse(idUser),
        quantity: _quantity,
        totalPrice: _totalPrice,
      );

      final response = await http.post(
        Uri.parse(apiUrlOrder),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode(orderEntity?.toJson()),
      );

      if (response.statusCode == 200) {
        setState(() {
          loadOrderStatus = LoadStatus.success;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OrderHistoryScreen(),
          ),
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadOrderStatus = LoadStatus.failure;
      });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 75,
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/images/arrow-left.png"),
                ),
                const Text(
                  "Đặt Hàng và Thanh Toán",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(245, 253, 233, 1),
              child: ListView(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
                    child: Column(
                      children: [
                        buildFoodDetails(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                _quantity = int.parse(text);
                                _totalPrice =
                                    _quantity * (foodItem?.price ?? 0) +
                                        15000;
                              });
                            },
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Số lượng"),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          thickness: 1.0,
                        ),
                        buildTotalPrice(),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/images/logoBanner.png",
                    fit: BoxFit.cover,
                    height: 500,
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ),
            ),
          ),
          buildPaymentButton(),
        ],
      ),
    );
  }

  Widget buildFoodDetails() {
    return loadFoodStatus == LoadStatus.loading
        ? const Center(child: CircularProgressIndicator())
        : loadFoodStatus == LoadStatus.failure
            ? const Center(child: Text("No food available"))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Image.network(
                          foodItem?.imgThumbnail ??
                              "https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png",
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
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
                            "${foodItem?.name}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${foodItem?.ingredients}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(149, 149, 149, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(foodItem?.price)}₫",
                              style: const TextStyle(
                                color: Color.fromRGBO(0, 102, 144, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }

  Widget buildTotalPrice() {
    return Column(
      children: [
        buildPriceRow(
          "Giá",
          "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(foodItem?.price)}₫",
        ),
        buildPriceRow("Số lượng:", "x $_quantity"),
        buildPriceRow("Phí ship:", "15.000 ₫"),
        const Divider(
          color: Color.fromRGBO(200, 200, 200, 1),
          thickness: 1.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Thành tiền:",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Column(
              children: [
                Text(
                  "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(_totalPrice)}₫",
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 102, 144, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color.fromRGBO(0, 102, 144, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentButton() {
    return GestureDetector(
      onTap: () {
        pushData();
      },
      child: Container(
        height: 50,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: loadOrderStatus == LoadStatus.loading
              ? const CircularProgressIndicator(color: Colors.white)
              : loadOrderStatus == LoadStatus.success
                  ? const Text(
                      'Thanh Toán Ngay',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  : const Text(
                      'ERROR!',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
        ),
      ),
    );
  }
}
