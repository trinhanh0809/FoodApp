import 'package:flutter/material.dart';
import 'package:foodapp/screen/sc_resraurant_menu/restaurant_menu.dart';
import 'package:foodapp/screen/sc_notification/notification.dart';
import 'package:foodapp/screen/sc_order_history/order_history.dart';
import 'package:foodapp/screen/sc_person/person.dart';
import 'package:foodapp/screen/sc_search/search.dart';

class BottomBarWidget extends StatefulWidget {
  final int tab;
  final Function changeTab;

  const BottomBarWidget({Key? key, required this.tab, required this.changeTab})
      : super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int tab1 = 1;
  int tab2 = 2;
  int tab3 = 3;
  int tab4 = 4;
  int tab5 = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(220, 220, 220, 0.95),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                widget.changeTab(tab1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchFood(),
                  ),
                );
              },
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/meal.png",
                  color: widget.tab == tab1
                      ? const Color.fromRGBO(0, 102, 144, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.changeTab(tab2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryScreen(),
                  ),
                );
              },
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/list.png",
                  color: widget.tab == tab2
                      ? const Color.fromRGBO(0, 102, 144, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.changeTab(tab3);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RestaurantMenuScreen(),
                  ),
                );
              },
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/heart.png",
                  color: widget.tab == tab3
                      ? const Color.fromRGBO(0, 102, 144, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.changeTab(tab4);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/note.png",
                  color: widget.tab == tab4
                      ? const Color.fromRGBO(0, 102, 144, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.changeTab(tab5);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersonScreen(),
                  ),
                );
              },
              highlightColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/person.png",
                  color: widget.tab == tab5
                      ? const Color.fromRGBO(0, 102, 144, 1)
                      : const Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
