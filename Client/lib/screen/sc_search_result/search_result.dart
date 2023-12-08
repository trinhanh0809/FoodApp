import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/models/entities/food.entity..dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/wg_item_list_result/item_list_result.dart';
import 'package:http/http.dart' as http;

class SearchResultScreen extends StatefulWidget {
  final String keyword;

  const SearchResultScreen({Key? key, required this.keyword})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<Food> foodList = [];
  LoadStatus loadStatus = LoadStatus.loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String urlAPI = "${dotenv.env['BASE_URL']}/foods/search";
      final response = await http.post(
        Uri.parse(urlAPI),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "keyword": widget.keyword,
        },
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body)["data"]);
        if (data.isNotEmpty) {
          setState(() {
            foodList = data.map((item) => Food.fromJson(item)).toList();
            loadStatus = LoadStatus.success;
          });
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keywordSearch = widget.keyword ?? "''";

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 102, 144, 1.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "assets/images/arrow-left.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search for address, food...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (String keywordSearch) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResultScreen(
                                    keyword: keywordSearch,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color.fromRGBO(12, 80, 106, 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                Text(
                  "Có ${foodList.length} kết quả tìm kiếm cho từ khóa: ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "'$keywordSearch'",
                  style: const TextStyle(
                    color: Color.fromRGBO(3, 222, 36, 1.0),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: loadStatus == LoadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : loadStatus == LoadStatus.failure
                    ? const Center(child: Text("No food available"))
                    : Container(
                        color: const Color.fromRGBO(0, 102, 144, 0.2),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodList.length,
                          itemBuilder: (context, index) {
                            final foodItem = foodList[index];
                            return ItemListResultWidget(
                              key: UniqueKey(),
                              id: foodItem.id!,
                              name: foodItem.name!,
                              description: foodItem.description!,
                              ingredients: foodItem.ingredients!,
                              imageUrl: foodItem.imgThumbnail!,
                              price: foodItem.price!,
                              totalSold: foodItem.totalOrders!,
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
