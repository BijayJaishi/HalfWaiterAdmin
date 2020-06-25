// To parse this JSON data, do
//
//     final parentCategoryListModel = parentCategoryListModelFromJson(jsonString);

import 'dart:convert';

ParentCategoryListModel parentCategoryListModelFromJson(String str) => ParentCategoryListModel.fromJson(json.decode(str));

String parentCategoryListModelToJson(ParentCategoryListModel data) => json.encode(data.toJson());

class ParentCategoryListModel {
  ParentCategoryListModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory ParentCategoryListModel.fromJson(Map<String, dynamic> json) => ParentCategoryListModel(
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
    this.parentId,
    this.name,
    this.createdDate,
  });

  String parentId;
  String name;
  DateTime createdDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    name: json["name"] == null ? null : json["name"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "parent_id": parentId == null ? null : parentId,
    "name": name == null ? null : name,
    "created_date": createdDate == null ? null : createdDate.toIso8601String(),
  };
}