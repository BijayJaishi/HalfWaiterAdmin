// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
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
    this.mcateId,
    this.categoryname,
    this.parentCat,
    this.userId,
    this.status,
    this.createdDate,
  });

  String mcateId;
  String categoryname;
  String parentCat;
  String userId;
  String status;
  DateTime createdDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    mcateId: json["mcate_id"] == null ? null : json["mcate_id"],
    categoryname: json["categoryname"] == null ? null : json["categoryname"],
    parentCat: json["parent_cat"] == null ? null : json["parent_cat"],
    userId: json["user_id"] == null ? null : json["user_id"],
    status: json["status"] == null ? null : json["status"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "mcate_id": mcateId == null ? null : mcateId,
    "categoryname": categoryname == null ? null : categoryname,
    "parent_cat": parentCat == null ? null : parentCat,
    "user_id": userId == null ? null : userId,
    "status": status == null ? null : status,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
  };
}
