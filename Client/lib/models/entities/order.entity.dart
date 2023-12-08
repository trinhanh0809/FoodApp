class Order {
  int? orderId;
  double? price;
  int? foodId;
  String? name;
  String? ingredients;
  String? imgThumbnail;
  String? orderDatetime;
  int? quantity;
  double? totalPrice;
  int? userID;

  Order({
    this.orderId,
    this.price,
    this.foodId,
    this.name,
    this.ingredients,
    this.imgThumbnail,
    this.orderDatetime,
    this.quantity,
    this.totalPrice,
    this.userID,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    price = double.parse(json['price'].toString());
    foodId = json['food_id'];
    name = json['name'];
    ingredients = json['ingredients'];
    imgThumbnail = json['img_thumbnail'];
    orderDatetime = (json['order_datetime']);
    quantity = json['quantity'] ?? 1;
    totalPrice = double.parse(json['total_price'].toString());
    userID = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['price'] = price;
    data['food_id'] = foodId;
    data['name'] = name;
    data['ingredients'] = ingredients;
    data['img_thumbnail'] = imgThumbnail;
    data['order_datetime'] = orderDatetime;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['user_id'] = userID;
    return data;
  }
}
