// To parse this JSON data, do
//
//     final pendingOrderModel = pendingOrderModelFromJson(jsonString);

import 'dart:convert';

PendingOrderModel pendingOrderModelFromJson(String str) => PendingOrderModel.fromJson(json.decode(str));

String pendingOrderModelToJson(PendingOrderModel data) => json.encode(data.toJson());

class PendingOrderModel {
  PendingOrderModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  String data;

  factory PendingOrderModel.fromJson(Map<String, dynamic> json) => PendingOrderModel(
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
