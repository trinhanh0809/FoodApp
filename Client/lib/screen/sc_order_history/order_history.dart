import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/models/entities/order.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/wg_bottom_bar/bottom_bar.dart';
import 'package:foodapp/widgets/wg_list_order_history/list_order_history.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int selectedTab = 2;
  List<Order> listHistory = [];
  LoadStatus loadStatus = LoadStatus.loading;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';

      String apiUrl = "${dotenv.env['BASE_URL']}/orders/list/$idUser";
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);
        await Future.delayed(const Duration(seconds: 2));

        if (data.isNotEmpty) {
          setState(() {
            loadStatus = LoadStatus.success;
            listHistory = data.map((item) {
              final order = Order.fromJson(item);
              print("Order from JSON: $order");
              return order;
            }).toList();
          });
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 102, 144, 1.0),
        title: const Text(
          "MÓN ĂN ĐÃ ĐẶT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 68,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromRGBO(0, 102, 144, 0.2),
              child: loadStatus == LoadStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : loadStatus == LoadStatus.failure
                      ? const Center(child: Text("Chưa có món ăn nào được đặt"))
                      : ListView.builder(
                          itemCount: listHistory.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final itemOrder = listHistory[index];
                            return ListOrderHistoryWidget(
                              orderID: itemOrder.orderId!,
                              foodID: itemOrder.foodId!,
                              name: itemOrder.name!,
                              imageUrl: itemOrder.imgThumbnail!,
                              orderDatetime: itemOrder.orderDatetime!,
                              quantity: itemOrder.quantity!,
                              price: itemOrder.price!,
                              totalPrice: itemOrder.totalPrice!,
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(tab: selectedTab, changeTab: changeTab),
    );
  }
}
