import 'dart:convert';
import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/Model_Classes/DeliveryModel.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:halfwaiteradminapp/Custom_dialog/customDialog.dart'
    as customDialog;

import '../MainSideNav.dart';

class Delivery extends StatefulWidget with NavigationStates {
  String id, name,onStatus;

  Delivery(this.id, this.name,this.onStatus);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  List<Datum> deliveryName = [];
  List<Order> orderName = [];
  int _selectedIndex;
  String clientName;
  DateTime dateTime;
  bool _isLoading;
  final TextEditingController controllerReferenceId =
      new TextEditingController();
  String typedReference;

//  _onSelected(int index) {
//    setState(() => _selectedIndex = index);
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SiteTabView(sitesName[index].siteName,sitesName[index].siteId)),
//    );
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
//    Navigator.pushReplacement(
//      context,
//      MaterialPageRoute(
//          builder: (context) => SideMain(
//              widget.id,widget.name,widget.onStatus)),
//    );
    Fluttertoast.showToast(
      msg: "Press Dashboard Button At Top Right",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blueAccent,
      timeInSecForIos: 1,
      textColor: Colors.white,
    ); // Do
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 24.3,
            left: 0,
            right: 0,
            bottom: 0,
            child: getInitialRow(),
          ),
          Positioned(
            top: 145,
            left: 0,
            right: 0,
            bottom: 0,
            child: getCard(context),
          ),
        ],
      ),
    );
  }

  Widget getInitialRow() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 122,
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(0.0),
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 160,
                      height: 60,
                      child: Card(
                        child: Center(
                            child: Text('Delivery',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
//                    child: InkWell(
//                      splashColor: Colors.blue,
//                      onTap: (){
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => SideMain(
//                                  widget.id,widget.name,widget.onStatus)),
//                        );
//                      },
                    child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Color.fromRGBO(59, 128, 198, 1),
                        child: IconButton(
                          splashColor: Colors.blue,
                          icon: Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.white,
                          ),
                          tooltip: "DashBoard",
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SideMain(
                                      widget.id,widget.name,widget.onStatus)),
                            );
                          },
                        )
//                        child: Image.asset('assets/images/dashboard.png'),
                    ),
//                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCard(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: getElementList(),
      ),
    );
  }

//  Widget getOrderCard(context,name,orders){
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//
////      child: Card(
////        shape:
////        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
////        clipBehavior: Clip.antiAlias,
////        elevation: 2,
////
////      ),
//    );
//  }

  Widget getFirstView() {
    return Container(
        child: FutureBuilder(
            future: _fetchListItem(widget.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      if (snapshot.error == null) CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          snapshot.error == null
                              ? "Please Wait ..."
                              : "There Is No Any Menu List",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
                );
              } else {
                return Container(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 6),
                        itemCount: deliveryName.length,
                        itemBuilder: (BuildContext context, int position) {
                          return getRow(position);
                        }));
              }
            }));
  }

  Widget getOrderFirstView(name, List<Order> orders) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 6),
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int position) {
                return getOrderRow(position, name, orders);
              }),
        )
      ],
    );
  }

  /////// --------------------------------- invoice view --------------------------------- ///////

  Widget _showDialogInvoiceView(
      deliveryId,
      name,
      resName,
      panNo,
      DateTime deliverDate,
      serviceCharge,
      subTotal,
      total,
      vatCharge,
      List<Order> orders,
      String paidStatus,
      referenceId) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: customDialog.Dialog(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'INVOICE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
              ),
//                  Container(
//                    color: Colors.grey,
//                    child: Center(child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text('INVOICE',style: TextStyle(fontWeight: FontWeight.bold),),
//                    )),
//                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(resName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('To,'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Invoice Id : $deliveryId',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Pan No: ' + panNo,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            'Invoice Date: ' +
                                deliverDate
                                    .toString()
                                    .replaceAll('00:00:00.000', ''),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ))),
                  )
                ],
              ),
//  Text('I am here'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  child: getInvoiceCard(
                      context,
                      name,
                      resName,
                      panNo,
                      deliverDate,
                      serviceCharge,
                      subTotal,
                      total,
                      vatCharge,
                      orders),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.blueGrey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sub - Total Amount: Rs. $subTotal'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('VAT(13%): Rs. $vatCharge'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Delivery Charge: Rs. $serviceCharge'),
              ),
              Divider(
                height: 1,
                color: Colors.blueGrey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: Rs. $total',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueGrey),
                ),
              ),

              paidStatus == 'Paid'
                  ? Container(
                      child: RaisedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Already Paid",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              timeInSecForIos: 1);
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                            width: 95,
                            height: 50,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: const Text('Paid',
                                    style: TextStyle(fontSize: 20)))),
                      ),
                    )
                  : RaisedButton(
                      onPressed: () {
                        var rng = new Random();
                        var code = rng.nextInt(900000) + 100000;
//                     print(code.toString());
//                     if(deliveryId !=null){
//                       postInvoiceData(deliveryId,referenceId,code,total);
//                     }else{
//
//                     }
////

                        postInvoiceData(deliveryId, referenceId,
                            code.toString(), total.toString());
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('Accept Payment',
                              style: TextStyle(fontSize: 20))),
                    ),
              SizedBox(
                height: 20,
              )
            ],
          )
//          child:  Column(
//            children: [
//             ],
//          )
              ),
        );
        // return object of type Dialog
//        return FittedBox(
//          fit: BoxFit.scaleDown,
//          child: customDialog.AlertDialog(
//            content:Container(width:MediaQuery.of(context).size.width,height:700,child: getInvoiceCard(context,name,resName,panNo, deliverDate,serviceCharge,subTotal,total,vatCharge,orders)),
//          ),
//        );
      },
    );
  }

  Widget getInvoiceCard(context, name, resName, panNo, DateTime deliverDate,
      serviceCharge, subTotal, total, vatCharge, List<Order> orders) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 6),
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int position) {
                return getInvoiceOrderRow(position, name, orders);
              }),
        )
      ],
    );
//    return Container(
//        child: ListView.builder(
//            padding: EdgeInsets.only(top: 6),
//            itemCount: orders.length,
//            itemBuilder: (BuildContext context, int position) {
//              return getInvoiceRow(position,name,resName,panNo,deliverDate,serviceCharge,subTotal,total,vatCharge,orders);
//            }));
  }

  Widget getInvoiceOrderRow(int index, String name, List<Order> orders) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      color: _selectedIndex != null && _selectedIndex == index
          ? Colors.lightBlueAccent
          : Colors.white70,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    orders[index].menuName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Card(
//                    color:orders[index].status=='1'?Colors.green:Colors.red,
//                    clipBehavior: Clip.antiAlias,
//                    child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: orders[index].status=='1'?Text('Active',style:TextStyle(color: Colors.white),):Text('Pending',style:TextStyle(color: Colors.white),),
//                    ),
//                  ),
//                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Rate : Rs.' + orders[index].rate),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'X',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Qty : ' + orders[index].qty),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total : Rs.' + orders[index].amount,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //////////////////// ----------------- end invoice view -------------------------------- ///////

  Widget getOrderRow(int index, String name, List<Order> orders) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      color: _selectedIndex != null && _selectedIndex == index
          ? Colors.lightBlueAccent
          : Colors.white70,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    orders[index].menuName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color:
                        orders[index].status == '1' ? Colors.green : Colors.red,
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: orders[index].status == '1'
                          ? Text(
                              'Accepted',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              'Pending',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('Rate : Rs.' + orders[index].rate),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'X',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Qty : ' + orders[index].qty),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total : Rs.' + orders[index].amount,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
      color: _selectedIndex != null && _selectedIndex == index
          ? Colors.lightBlueAccent
          : Colors.white70,
//      child: ListTile(
//        contentPadding: EdgeInsets.only(left : 10.0,top: 0,bottom: 0,right: 10.0),
//        title: Text("${index+1}. "+ deliveryName[index].customerName),
//        subtitle: Text("     "+deliveryName[index].address),
//        onTap: () {
//
////          _onSelected(index);
//        },
//      ),

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    deliveryName[index].deliveryId,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.blue,
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        deliveryName[index].paidStatus,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(deliveryName[index].customerName),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(deliveryName[index].phone),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(deliveryName[index].address),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    deliveryName[index].orderDate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                  splashColor: Colors.blue,
                                  icon: Icon(
                                    Icons.tv,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  tooltip: "View",
                                  onPressed: () {
//                                print("IndexOrder : ${deliveryName[index].orders[0].amount}");
                                    _showDialogOrderView(
                                        deliveryName[index].customerName,
                                        deliveryName[index].orders,
                                        deliveryName[index].deliveryId);
                                  },
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                  splashColor: Colors.blue,
                                  icon: Icon(
                                    Icons.insert_drive_file,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  tooltip: "Invoice View",
                                  onPressed: () {
                                    setState(() {
                                      dateTime =
                                          deliveryName[index].deliverDate;
                                    });

                                    _showDialogInvoiceView(
                                        deliveryName[index].deliveryId,
                                        deliveryName[index].customerName,
                                        deliveryName[index].resName,
                                        deliveryName[index].panNo,
                                        dateTime,
                                        deliveryName[index].serviceCharge,
                                        deliveryName[index].subTotal,
                                        deliveryName[index].total,
                                        deliveryName[index].vat,
                                        deliveryName[index].orders,
                                        deliveryName[index].paidStatus,
                                        deliveryName[index].referenceId);
                                  },
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                  splashColor: Colors.blue,
                                  icon: Icon(
                                    Icons.save,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  tooltip: "Accept Delivery",
                                  onPressed: () {
                                    _showDialogdeliveryView(
                                        deliveryName[index].referenceId);
                                  },
                                )),
                          )
                        ],
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDialogOrderView(name, orders, deliverId) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: customDialog.Dialog(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
              ),
//  Text('I am here'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.maxFinite,
                  child: getOrderElementList(name, orders),
                ),
              ),
              RaisedButton(
                onPressed: () {
//                  print(deliverId);

                  if (deliverId != null) {
                    postData(deliverId);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Delivery Id Required !!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        timeInSecForIos: 1);
                  }
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Accept Order',
                        style: TextStyle(fontSize: 20))),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
//          child:  Column(
//            children: [
//             ],
//          )
              ),
        );
      },
    );
  }

  Widget _showDialogdeliveryView(referenceId) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: customDialog.Dialog(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Reference Id',
                                hintText: 'Enter Reference Id',
                              ),
                              controller: controllerReferenceId,
                              onChanged: (value) {
                                typedReference = value;
                              },
                              autofocus: false,
                            )))),
              ),
              RaisedButton(
                onPressed: () {
                  if (controllerReferenceId.text.trim() != '') {
                    Fluttertoast.showToast(
                      msg: "Compairing Reference Id ..",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blueAccent,
                      timeInSecForIos: 1,
                      textColor: Colors.white,
                    );
                    Navigator.of(context).pop();
                    if(controllerReferenceId.text == referenceId){

                      postDeliveryAccept(controllerReferenceId.text);
                    }else{

                      Fluttertoast.showToast(
                        msg: "Reference ID is Incorrect",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.blueAccent,
                        timeInSecForIos: 1,
                        textColor: Colors.white,
                      );
                      controllerReferenceId.clear();
                    }
                  }else{

                    Fluttertoast.showToast(
                      msg: "Reference ID is Required",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blueAccent,
                      timeInSecForIos: 1,
                      textColor: Colors.white,
                    );
                  }
//                  print(deliverId);
//
//                  if (deliverId != null) {
//                    postData(deliverId);
//                  } else {
//                    Fluttertoast.showToast(
//                        msg: "Delivery Id Required !!",
//                        toastLength: Toast.LENGTH_SHORT,
//                        gravity: ToastGravity.BOTTOM,
//                        backgroundColor: Colors.red,
//                        timeInSecForIos: 1);
//                  }
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Save Record',
                        style: TextStyle(fontSize: 20))),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
//          child:  Column(
//            children: [
//             ],
//          )
              ),
        );
      },
    );
  }


  void postDeliveryAccept(String referenceId) async {
    Map data = {
      'typed_ref_id': referenceId,
    };
    var jsonResponse;
    var response = await http.post(
        "https://www.admin.halfwaiter.com/demo/api/request/acceptDelivery",
        headers: {"x-api-key": r"Eprim@Res!"},
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        Fluttertoast.showToast(
            msg: "Delivery Completed Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);
        controllerReferenceId.clear();

//        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed to Complete Delivery",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
//      print(response.body);
    }
  }
  void postData(String deliverId) async {
    Map data = {
      'del_Id': deliverId,
    };
    var jsonResponse;
    var response = await http.post(
        "https://www.admin.halfwaiter.com/demo/api/request/acceptOrders",
        headers: {"x-api-key": r"Eprim@Res!"},
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        Fluttertoast.showToast(
            msg: "Order Accepted Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);

        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed to accept Order",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
//      print(response.body);
    }
  }

  void postInvoiceData(
      String deliverId, referenceId, String codeNumber, totalAmount) async {
//    print(deliverId);
//    print(referenceId);
//    print(codeNumber);
//    print(totalAmount);
    Map data = {
      'del_Id': deliverId,
      'ref_id': referenceId,
      'inv_id': codeNumber,
      'total_amount': totalAmount,
    };
    var jsonResponse;
    var response = await http.post(
        "https://www.admin.halfwaiter.com/demo/api/request/acceptPayment",
        headers: {"x-api-key": r"Eprim@Res!"},
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        Fluttertoast.showToast(
            msg: "Payment Accepted Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);

        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed to accept Payment",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
//      print(response.body);
    }
  }

  _fetchListItem(userId) async {
    String dataURL =
        "https://www.admin.halfwaiter.com/demo/api/request/adminDeliveryOrder?user_id=$userId";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});
    deliveryName.clear();
    orderName.clear();
    for (Datum datum in deliveryModelFromJson(response.body).data) {
      deliveryName.add(datum);
    }
//    print("Delivery : ${deliveryName[2].orders[1].amount}");
    return deliveryName;
  }

//  _fetchOrderListItem(userId) async {
//    String dataURL = "https://www.admin.halfwaiter.com/demo/api/request/adminDeliveryOrder?user_id=$userId";
//    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Eprim@Res!"});
//    deliveryName.clear();
//    orderName.clear();
//    for (Datum datum  in deliveryModelFromJson(response.body).data) {
//      deliveryName.add(datum);
//      for(Order order in datum.orders){
//        orderName.add(order);
////
//      }
//
//
//      return orderName;
//
//    }
//    return deliveryName;
//  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0), child: getFirstView());
  }

  Widget getOrderElementList(name, orders) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: getOrderFirstView(name, orders));
  }
}
