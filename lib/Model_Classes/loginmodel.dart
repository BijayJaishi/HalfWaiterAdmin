// To parse this JSON data, do
//
//     final loginmodel = loginmodelFromJson(jsonString);

import 'dart:convert';

Loginmodel loginmodelFromJson(String str) => Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  Loginmodel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
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
    this.id,
    this.email,
    this.name,
    this.company,
    this.online,
    this.active,
    this.phone,
    this.groupName,
  });

  String id;
  String email;
  String name;
  String company;
  String online;
  String active;
  String phone;
  String groupName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    company: json["company"] == null ? null : json["company"],
    online: json["online"] == null ? null : json["online"],
    active: json["active"] == null ? null : json["active"],
    phone: json["phone"] == null ? null : json["phone"],
    groupName: json["group_name"] == null ? null : json["group_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "company": company == null ? null : company,
    "online": online == null ? null : online,
    "active": active == null ? null : active,
    "phone": phone == null ? null : phone,
    "group_name": groupName == null ? null : groupName,
  };
}