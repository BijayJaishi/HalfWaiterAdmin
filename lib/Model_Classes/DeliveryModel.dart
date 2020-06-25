// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

DeliveryModel deliveryModelFromJson(String str) => DeliveryModel.fromJson(json.decode(str));

String deliveryModelToJson(DeliveryModel data) => json.encode(data.toJson());

class DeliveryModel {
  DeliveryModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<Datum> data;

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
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
    this.customerName,
    this.address,
    this.phone,
    this.resName,
    this.logo,
    this.deliveryId,
    this.orderDate,
    this.deliverDate,
    this.vatPer,
    this.serPer,
    this.discPer,
    this.referenceId,
    this.paidStatus,
    this.paymentMethod,
    this.panNo,
    this.delCharge,
    this.serviceCharge,
    this.vat,
    this.subTotal,
    this.discountCharge,
    this.total,
    this.orders,
  });

  String customerName;
  String address;
  String phone;
  String resName;
  String logo;
  String deliveryId;
  String orderDate;
  DateTime deliverDate;
  String vatPer;
  String serPer;
  String discPer;
  String referenceId;
  String paidStatus;
  String paymentMethod;
  String panNo;
  String delCharge;
  double serviceCharge;
  double vat;
  int subTotal;
  double discountCharge;
  double total;
  List<Order> orders;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    address: json["address"] == null ? null : json["address"],
    phone: json["phone"] == null ? null : json["phone"],
    resName: json["res_name"] == null ? null : json["res_name"],
    logo: json["logo"] == null ? null : json["logo"],
    deliveryId: json["delivery_id"] == null ? null : json["delivery_id"],
    orderDate: json["order_date"] == null ? null : json["order_date"],
    deliverDate: json["deliver_date"] == null ? null : DateTime.parse(json["deliver_date"]),
    vatPer: json["vat_per"] == null ? null : json["vat_per"],
    serPer: json["ser_per"] == null ? null : json["ser_per"],
    discPer: json["disc_per"] == null ? null : json["disc_per"],
    referenceId: json["reference_id"] == null ? null : json["reference_id"],
    paidStatus: json["paid_status"] == null ? null : json["paid_status"],
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    panNo: json["pan_no"] == null ? null : json["pan_no"],
    delCharge: json["del_charge"] == null ? null : json["del_charge"],
    serviceCharge: json["service_charge"] == null ? null : json["service_charge"].toDouble(),
    vat: json["vat"] == null ? null : json["vat"].toDouble(),
    subTotal: json["sub_total"] == null ? null : json["sub_total"],
    discountCharge: json["discount_charge"] == null ? null : json["discount_charge"].toDouble(),
    total: json["total"] == null ? null : json["total"].toDouble(),
    orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customer_name": customerName == null ? null : customerName,
    "address": address == null ? null : address,
    "phone": phone == null ? null : phone,
    "res_name": resName == null ? null : resName,
    "logo": logo == null ? null : logo,
    "delivery_id": deliveryId == null ? null : deliveryId,
    "order_date": orderDate == null ? null : orderDate,
    "deliver_date": deliverDate == null ? null : "${deliverDate.year.toString().padLeft(4, '0')}-${deliverDate.month.toString().padLeft(2, '0')}-${deliverDate.day.toString().padLeft(2, '0')}",
    "vat_per": vatPer == null ? null : vatPer,
    "ser_per": serPer == null ? null : serPer,
    "disc_per": discPer == null ? null : discPer,
    "reference_id": referenceId == null ? null : referenceId,
    "paid_status": paidStatus == null ? null : paidStatus,
    "payment_method": paymentMethod == null ? null : paymentMethod,
    "pan_no": panNo == null ? null : panNo,
    "del_charge": delCharge == null ? null : delCharge,
    "service_charge": serviceCharge == null ? null : serviceCharge,
    "vat": vat == null ? null : vat,
    "sub_total": subTotal == null ? null : subTotal,
    "discount_charge": discountCharge == null ? null : discountCharge,
    "total": total == null ? null : total,
    "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    this.menuName,
    this.status,
    this.rate,
    this.qty,
    this.amount,
    this.notes,
  });

  String menuName;
  String status;
  String rate;
  String qty;
  String amount;
  String notes;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    menuName: json["menu_name"] == null ? null : json["menu_name"],
    status: json["status"] == null ? null : json["status"],
    rate: json["rate"] == null ? null : json["rate"],
    qty: json["qty"] == null ? null : json["qty"],
    amount: json["amount"] == null ? null : json["amount"],
    notes: json["notes"] == null ? null : json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "menu_name": menuName == null ? null : menuName,
    "status": status == null ? null : status,
    "rate": rate == null ? null : rate,
    "qty": qty == null ? null : qty,
    "amount": amount == null ? null : amount,
    "notes": notes == null ? null : notes,
  };
}