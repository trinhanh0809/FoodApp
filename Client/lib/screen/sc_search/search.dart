import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/models/entities/user.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../widgets/wg_bottom_bar/bottom_bar.dart';
import '../sc_search_result/search_result.dart';

class SearchFood extends StatefulWidget {
  const SearchFood({super.key});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  int selectedTab = 1;
  LoadStatus loadStatus = LoadStatus.loading;
  final TextEditingController _keyword = TextEditingController();
  User? userEntity;

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

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser') ?? '';
    final response = await http
        .get(Uri.parse("${dotenv.env['BASE_URL']}/users/info/$idUser"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)["data"];
      setState(() {
        loadStatus = LoadStatus.success;
        userEntity = User.fromJson(data);
      });
    } else {
      loadStatus = LoadStatus.failure;
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgsearch.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: loadStatus == LoadStatus.loading
              ? const CircularProgressIndicator()
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 42,
                        left: 25,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              '${userEntity?.avatarThumbnail}',
                              height: 56,
                              width: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Text(
                              "Xin chào, ${userEntity?.name}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 94,
                        left: 25,
                        right: 25,
                      ),
                      child: SizedBox(
                        width: 314,
                        height: 163,
                        child: Text(
                          "Chọn món, chúng tôi sẽ làm nổi bật mỗi khẩu phần của bạn!",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _keyword,
                                          onSubmitted: (String keywordSearch) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultScreen(
                                                        keyword: keywordSearch),
                                              ),
                                            );
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText:
                                                'Tìm kiếm món ăn yêu thích ngay...',
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            prefixIcon: const Icon(Icons.search,
                                                color: Colors.grey),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SearchResultScreen(
                                          keyword: _keyword
                                              .text, // Use the null-aware operator directly
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(0, 102, 144, 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'TÌM KIẾM',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomBarWidget(tab: selectedTab, changeTab: changeTab),
    );
  }
}
