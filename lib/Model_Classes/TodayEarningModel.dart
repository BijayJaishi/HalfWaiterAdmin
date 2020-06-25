// To parse this JSON data, do
//
//     final todayEarningModel = todayEarningModelFromJson(jsonString);

import 'dart:convert';

TodayEarningModel todayEarningModelFromJson(String str) => TodayEarningModel.fromJson(json.decode(str));

String todayEarningModelToJson(TodayEarningModel data) => json.encode(data.toJson());

class TodayEarningModel {
  TodayEarningModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  String data;

  factory TodayEarningModel.fromJson(Map<String, dynamic> json) => TodayEarningModel(
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
