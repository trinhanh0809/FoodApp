import 'package:flutter/material.dart';
import '../../widgets/wg_bottom_bar/bottom_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedTab = 4;

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "THÔNG BÁO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: ListView(
                children: [
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                  ItemListNotificationWidget(),
                ],
              ),
            ),
          ),
          BottomBarWidget(tab: selectedTab, changeTab: changeTab)
        ],
      ),
    );
  }

  Padding ItemListNotificationWidget() {
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
                  Image.asset(
                    "assets/images/avtuser.png",
                    height: 59,
                    width: 59,
                    fit: BoxFit.cover,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Good food and its benifits",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Good food makes cooking fun and easy. We'll provide you with all the ingredients in your meal kit that you need to make a delicious meal.",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "15 hours ago",
                                style: TextStyle(
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
