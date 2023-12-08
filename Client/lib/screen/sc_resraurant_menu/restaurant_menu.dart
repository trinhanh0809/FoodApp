import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/wg_bottom_bar/bottom_bar.dart';
import 'package:foodapp/widgets/wg_item_restaurant_menu/item_restaurant_menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/entities/food.entity..dart';

class RestaurantMenuScreen extends StatefulWidget {
  const RestaurantMenuScreen({super.key});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  int selectedTab = 3;
  List<Food> foodItem = [];
  LoadStatus loadStatus = LoadStatus.loading;

  Future<void> fetchData() async {
    try {
      String apiUrl = "${dotenv.env['BASE_URL']}/foods";
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);

        if (data.isNotEmpty) {
          setState(() {
            loadStatus = LoadStatus.success;
            foodItem = data.map((item) => Food.fromJson(item)).toList();
          });
        } else {
          print("không có data");
          throw Exception('Failed to load data');
        }
      } else {
        print("Lỗi 404");

        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Lỗi fetch: $error");

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

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 102, 144, 1),
        title: const Text(
          "MÓN ĂN ĐƯỢC YÊU THÍCH NHẤT",
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
                      ? const Center(child: Text("Lỗi Server"))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: foodItem.length,
                            itemBuilder: (BuildContext context, int index) {
                              final itemFavorite = foodItem[index];
                              return ItemRestaurantMenuWidget(
                                id: itemFavorite.id!,
                                name: itemFavorite.name!,
                                price: itemFavorite.price!,
                                ingredients: itemFavorite.ingredients!,
                                description: itemFavorite.description!,
                                imgThumbnail: itemFavorite.imgThumbnail!,
                                totalOrders: itemFavorite.totalOrders!,
                              );
                            },
                          ),
                        ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(tab: selectedTab, changeTab: changeTab),
    );
  }
}
