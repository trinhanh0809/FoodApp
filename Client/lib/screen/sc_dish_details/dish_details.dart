import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/enums/loadStatus.dart';
import 'package:foodapp/screen/sc_order_processing/order_processing.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/entities/food.entity..dart';

class DishDetailsScreen extends StatefulWidget {
  final int? idProduct;

  const DishDetailsScreen({super.key, required this.idProduct});

  @override
  State<DishDetailsScreen> createState() => _DishDetailsScreenState();
}

class _DishDetailsScreenState extends State<DishDetailsScreen> {
  Food? foodItem;
  LoadStatus foodLoadStatus = LoadStatus.loading;

  late int idFood;

  @override
  void initState() {
    super.initState();
    idFood = widget.idProduct!;
    getDishDetail();
  }

  Future<void> getDishDetail() async {
    try {
      String apiDishDetail = "${dotenv.env['BASE_URL']}/foods/find/$idFood";
      final response = await http.get(Uri.parse(apiDishDetail));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)["data"];
        setState(() {
          foodItem = Food.fromJson(data);
          foodLoadStatus = LoadStatus.success;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        foodLoadStatus = LoadStatus.failure;
      });
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: foodLoadStatus == LoadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : foodLoadStatus == LoadStatus.failure
                    ? const Center(child: Text("No food available"))
                    : ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                height: 350,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${foodItem?.imgThumbnail}"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: const Color.fromARGB(255, 173, 8, 8),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                          padding: const EdgeInsets.all(17),
                                          child: Image.asset(
                                              "assets/images/arrow-left.png"))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 17,
                                  left: 17,
                                  right: 17,
                                  bottom: 4,
                                ),
                                child: Text(
                                  "${foodItem?.name}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 17,
                                ),
                                child: Text(
                                  "${foodItem?.totalOrders} lượt bán",
                                  style: const TextStyle(
                                      color: Color.fromRGBO(147, 147, 147, 1),
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 10),
                                child: Text(
                                  "${NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0).format(foodItem?.price ?? 0.0)}₫",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color.fromRGBO(0, 102, 144, 1),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(17, 5, 17, 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            "Mở cửa:",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "6:00am - 22:00pm",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  147, 147, 147, 1)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 50),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderProcessingScreen(
                                                        idProduct:
                                                            foodItem!.id)));
                                      },
                                      child: Expanded(
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                0, 102, 144, 1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'ĐẶT HÀNG NGAY',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 17.0),
                                child: Divider(
                                  color: Color.fromRGBO(243, 243, 243, 1),
                                  thickness: 14,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(17, 5, 17, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Mô tả",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromRGBO(147, 147, 147, 1)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "${foodItem?.description}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 17.0),
                                child: Divider(
                                  color: Color.fromRGBO(243, 243, 243, 1),
                                  thickness: 14,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(17, 5, 17, 17),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Một vài lưu ý nhỏ có ích:",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 3, 62, 167),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "✳ Kiểm tra đơn hàng ngay khi nhận để đảm bảo đầy đủ món ăn và chất lượng.\n✳ Đảm bảo rằng món ăn vẫn nóng hoặc lạnh như mong đợi.\n✳ Kiểm tra lại thông tin đơn hàng để đảm bảo đúng đặt hàng và địa chỉ giao hàng.\n✳ Xác nhận thanh toán đúng số tiền và kiểm tra tiền thừa nếu có.\n✳ Liên hệ ngay nếu bạn gặp bất kỳ vấn đề nào với đơn hàng của bạn.\n✳ Đánh giá dịch vụ để chúng tôi có thể cải thiện trải nghiệm của bạn.\n✳ Bảo quản thực phẩm cần lạnh ngay sau khi nhận.\n✳ Cuối cùng mọi thắc mắc hay vấn đề tồi tệ bạn gặp phải, hãy liên hệ với chúng tôi!",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 3, 62, 167),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
