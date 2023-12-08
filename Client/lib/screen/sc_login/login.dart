import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/sc_initialization_page/initialization_page.dart';
import 'package:foodapp/screen/sc_search/search.dart';
import 'package:foodapp/screen/sc_signup/signup.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/entities/user.entity.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoadStatus loadLogin = LoadStatus.loading;
  LoadStatus loadStatus = LoadStatus.initial;
  String _mess = "";
  User? userEntity;

  Future<void> LoadLogin() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      loadLogin = LoadStatus.success;
    });
  }

  @override
  void initState() {
    super.initState();
    LoadLogin();
  }

  Future<void> LoginHandle(context) async {
    userEntity = User(
      phoneNumber: _phonenumberController.text,
      password: _passwordController.text,
    );

    try {
      String apiLogin = "${dotenv.env['BASE_URL']}/users/login";
      final http.Response response = await http.post(
        Uri.parse(apiLogin),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userEntity?.toJson()),
      );
      setState(() {
        loadStatus = LoadStatus.loading;
      });
      var resBody = json.decode(response.body);
      if (response.statusCode == 200) {
        var idUser = resBody['data'].toString();
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('idUser', idUser);
        setState(() {
          loadStatus = LoadStatus.success;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchFood(),
          ),
        );
      } else {
        setState(() {
          _mess = "Lỗi! Tài khoản không có sẵn";
          loadStatus = LoadStatus.failure;
        });
      }
    } catch (e) {
      setState(() {
        loadStatus = LoadStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadLogin == LoadStatus.loading
          ? const InitializationPage()
          : Container(
              color: const Color.fromRGBO(0, 102, 144, 1.0),
              child: Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: 200,
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _phonenumberController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Email/Số điện thoại',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Mật khẩu',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      LoginHandle(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          102, 190, 111, 1.0),
                                    ),
                                    child: loadStatus == LoadStatus.loading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            'Đăng nhập',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          _mess,
                          style: const TextStyle(color: Colors.red),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                "Không có tài khoản?",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signup(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Đăng ký ngay',
                                style: TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
