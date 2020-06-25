// To parse this JSON data, do
//
//     final menuListModel = menuListModelFromJson(jsonString);

import 'dart:convert';

MenuListModel menuListModelFromJson(String str) => MenuListModel.fromJson(json.decode(str));

String menuListModelToJson(MenuListModel data) => json.encode(data.toJson());

class MenuListModel {
  MenuListModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory MenuListModel.fromJson(Map<String, dynamic> json) => MenuListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.menuId,
    this.fullname,
    this.photo,
    this.category,
    this.price,
    this.discountPrice,
    this.description,
    this.userId,
    this.isToday,
    this.status,
    this.featured,
    this.createdDate,
  });

  String menuId;
  String fullname;
  String photo;
  String category;
  String price;
  String discountPrice;
  String description;
  String userId;
  String isToday;
  String status;
  String featured;
  DateTime createdDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    menuId: json["menu_id"] == null ? null : json["menu_id"],
    fullname: json["fullname"] == null ? null : json["fullname"],
    photo: json["photo"] == null ? null : json["photo"],
    category: json["category"] == null ? null : json["category"],
    price: json["price"] == null ? null : json["price"],
    discountPrice: json["discount_price"] == null ? null : json["discount_price"],
    description: json["description"] == null ? null : json["description"],
    userId: json["user_id"] == null ? null : json["user_id"],
    isToday: json["is_today"] == null ? null : json["is_today"],
    status: json["status"] == null ? null : json["status"],
    featured: json["featured"] == null ? null : json["featured"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "menu_id": menuId == null ? null : menuId,
    "fullname": fullname == null ? null : fullname,
    "photo": photo == null ? null : photo,
    "category": category == null ? null : category,
    "price": price == null ? null : price,
    "discount_price": discountPrice == null ? null : discountPrice,
    "description": description == null ? null : description,
    "user_id": userId == null ? null : userId,
    "is_today": isToday == null ? null : isToday,
    "status": status == null ? null : status,
    "featured": featured == null ? null : featured,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
  };
}