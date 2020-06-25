// To parse this JSON data, do
//
//     final todayOrderModel = todayOrderModelFromJson(jsonString);

import 'dart:convert';

TodayOrderModel todayOrderModelFromJson(String str) => TodayOrderModel.fromJson(json.decode(str));

String todayOrderModelToJson(TodayOrderModel data) => json.encode(data.toJson());

class TodayOrderModel {
  TodayOrderModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  String data;

  factory TodayOrderModel.fromJson(Map<String, dynamic> json) => TodayOrderModel(
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
