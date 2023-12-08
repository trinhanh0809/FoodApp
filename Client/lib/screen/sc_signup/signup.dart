import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodapp/models/entities/user.entity.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/sc_login/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _mess = "";
  LoadStatus loadStatus = LoadStatus.initial;
  User? userSignup;

  Future<void> _signup(context) async {
    String signupApi = "${dotenv.env['BASE_URL']}/users/signup";
    userSignup = User(
      name: _usernameController.text,
      password: _passwordController.text,
      phoneNumber: _phonenumberController.text,
      address: _addressController.text,
    );

    setState(() {
      loadStatus = LoadStatus.loading;
    });
    try {
      final http.Response response = await http.post(
        Uri.parse(signupApi),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userSignup?.toJson()),
      );

      if (response.statusCode == 200) {
        setState(() {
          loadStatus = LoadStatus.success;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        setState(() {
          _mess = "Đăng ký thất bại. Email hoặc SĐT đã được tạo trước đó";
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
      body: Container(
        color: const Color.fromRGBO(0, 102, 144, 1.0),
        padding: const EdgeInsets.only(top: 30),
        child: ListView(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            width:
                MediaQuery.of(context).size.width * 0.8, // Maximum width of 80%
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên người dùng',
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ nhà ở/chung cư',
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
                              _signup(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(102, 190, 111, 1.0),
                            ),
                            child: loadStatus == LoadStatus.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Đăng ký',
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
                const SizedBox(height: 10),
                Center(
                    child: Text(
                  _mess,
                  style: const TextStyle(color: Colors.red),
                )),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "Nếu đã có tài khoản?",
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
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        'Đăng nhập ngay',
                        style: TextStyle(
                          color: Colors.lightGreenAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
