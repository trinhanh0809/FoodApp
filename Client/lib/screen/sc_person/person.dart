import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/widgets/wg_bottom_bar/bottom_bar.dart';
import 'package:foodapp/screen/sc_login/login.dart';
import 'package:foodapp/screen/sc_order_history/order_history.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/entities/user.entity.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  int selectedTab = 5;
  LoadStatus loadStatus = LoadStatus.loading;

  void changeTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  User? userEntity;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('idUser') ?? '';
      String apiUrl = "${dotenv.env['BASE_URL']}/users/info/$idUser";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON data
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          userEntity = User.fromJson(data);
          loadStatus = LoadStatus.success;
        });
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
    return Scaffold(
      body: loadStatus == LoadStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : loadStatus == LoadStatus.failure
              ? const Center(child: Text("No data available"))
              : ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/bgPerson.png'), // Hình ảnh PNG
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                            Color.fromRGBO(0, 102, 144, 1),
                            BlendMode.multiply,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "assets/images/settings.png",
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${userEntity?.avatarThumbnail}" ??
                                        'https://e7.pngegg.com/pngimages/321/641/png-clipart-load-the-map-loading-load.png'),
                                radius: 35,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  '${userEntity?.name}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 3,
                          margin: const EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Thông tin cá nhân",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                ListTile(
                                  title: Text(
                                    '${userEntity?.id}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(76, 140, 229, 1.0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  leading: const Icon(
                                    Icons.person_2_sharp,
                                    color: Color.fromRGBO(76, 140, 229, 1.0),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    '${userEntity?.phoneNumber}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(76, 140, 229, 1.0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  leading: const Icon(
                                    Icons.phone,
                                    color: Color.fromRGBO(76, 140, 229, 1.0),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    '${userEntity?.address}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(76, 140, 229, 1.0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Color.fromRGBO(76, 140, 229, 1.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Color.fromRGBO(239, 239, 239, 1),
                          thickness: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const OrderHistoryScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/order.png"),
                                        ),
                                      ),
                                      child: Image.asset(
                                          "assets/images/OrderIcon.png"),
                                    ),
                                    const Text(
                                      "Orders History",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset("assets/images/chevronRight.png")
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          color: Color.fromRGBO(239, 239, 239, 1),
                          thickness: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(102, 190, 111, 1.0),
                            ),
                            child: const Text(
                              'Đăng xuất',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
      bottomNavigationBar: BottomBarWidget(tab: selectedTab, changeTab: changeTab),
    );
  }
}
