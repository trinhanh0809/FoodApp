import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/sc_login/login.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hatoyama - Nhà hàng nhật',
      home: Login(),
    );
  }
}
