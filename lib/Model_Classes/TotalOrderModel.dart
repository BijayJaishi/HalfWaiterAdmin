// To parse this JSON data, do
//
//     final totalOrderModel = totalOrderModelFromJson(jsonString);

import 'dart:convert';

TotalOrderModel totalOrderModelFromJson(String str) => TotalOrderModel.fromJson(json.decode(str));

String totalOrderModelToJson(TotalOrderModel data) => json.encode(data.toJson());

class TotalOrderModel {
  TotalOrderModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  String data;

  factory TotalOrderModel.fromJson(Map<String, dynamic> json) => TotalOrderModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}
