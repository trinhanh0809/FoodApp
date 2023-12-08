class User {
  int? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? password;
  String? avatarThumbnail;

  User(
      {this.id,
      this.name,
      this.phoneNumber,
      this.address,
      this.password,
      this.avatarThumbnail});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "Người dùng FoodApp";
    phoneNumber = json['phone_number'] ?? "";
    address = json['address'] ?? "";
    password = json['password'] ?? "";
    avatarThumbnail = json['avatar_thumbnail'] ??
        "https://cdn-icons-png.flaticon.com/512/186/186313.png";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['password'] = password;
    data['avatar_thumbnail'] = avatarThumbnail;
    return data;
  }
}
