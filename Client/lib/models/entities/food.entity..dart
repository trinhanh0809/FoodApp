class Food {
  int? id;
  String? name;
  double? price;
  String? ingredients;
  String? description;
  String? imgThumbnail;
  int? totalOrders;

  Food({
    this.id,
    this.name,
    this.price,
    this.ingredients,
    this.description,
    this.imgThumbnail,
    this.totalOrders,
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "Tên món không khả dụng";
    price = double.parse(json['price'] ?? '0.0');
    ingredients = json['ingredients'] ?? "";
    description = json['description'] ?? "";
    imgThumbnail = json['img_thumbnail'] ?? "assets/images/errImg.jpg";
    totalOrders = int.parse(json['total_orders'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['ingredients'] = ingredients;
    data['description'] = description;
    data['img_thumbnail'] = imgThumbnail;
    data['total_orders'] = totalOrders;
    return data;
  }
}
