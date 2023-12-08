import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InitializationPage extends StatelessWidget {
  const InitializationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: const Color.fromRGBO(247, 255, 235, 1),
              child: Image.asset(
                'assets/images/logoBanner.png', // Make sure the asset path is correct
              ),
            ),
          ),
        ],
      ),
    );
  }
}
