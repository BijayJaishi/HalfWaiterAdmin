//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:halfwaiteradminapp/Model_Classes/DeliveryModel.dart';
//import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
//import 'package:http/http.dart' as http;
//import 'package:halfwaiteradminapp/Custom_dialog/customDialog.dart' as customDialog;
//
//class Delivery extends StatefulWidget with NavigationStates {
//  String id,name;
//
//  Delivery(this.id, this.name);
//
//  @override
//  _DeliveryState createState() => _DeliveryState();
//}
//
//class _DeliveryState extends State<Delivery> {
//  List<Datum> deliveryName = [];
//  List<Order> orderName =[];
//  int _selectedIndex ;
//  String clientName;
//  DateTime dateTime;
//
//
//
//
////  _onSelected(int index) {
////    setState(() => _selectedIndex = index);
////    Navigator.push(
////      context,
////      MaterialPageRoute(builder: (context) => SiteTabView(sitesName[index].siteName,sitesName[index].siteId)),
////    );
////  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      body: Stack(
//        children: <Widget>[
//          Positioned(
//            top: 24.3,
//            left: 0,
//            right: 0,
//            bottom: 0,
//            child: getInitialRow(),
//          ),
//          Positioned(
//            top: 145,
//            left: 0,
//            right: 0,
//            bottom: 0,
//            child: getCard(context),
//          ),
//
//        ],
//      ),
//    );
//
//  }
//
//
//  Widget getInitialRow() {
//    return Align(
//      alignment: Alignment.topCenter,
//      child: Container(
//        height: 122,
//        child: Card(
//          elevation: 5,
//          margin: EdgeInsets.all(0.0),
//          color: Colors.white70,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(left:50.0),
//                    child: Container(
//                      width: MediaQuery.of(context).size.width - 160,
//                      height: 60,
//                      child: Card(
//                        child: Center(child: Text('Delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 4.0),
//                    child: CircleAvatar(
//                        radius: 28,
//                        backgroundColor: Colors.deepOrangeAccent,
//                        child: IconButton(
//                          splashColor: Colors.blue,
//                          icon: Icon(
//                            Icons.dashboard,
//                            size: 28,
//                            color: Colors.black,
//                          ),
//                          tooltip: "DashBoard",
//                          onPressed: () {
////                            Navigator.pushReplacement(
////                              context,
////                              MaterialPageRoute(
////                                  builder: (context) =>
////                                      DashBoardManager(widget.id, widget.name)),
////                            );
//                          },
//                        )),
//                  ),
//                ],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget getCard(context) {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: Card(
//        shape:
//        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//        clipBehavior: Clip.antiAlias,
//        elevation: 2,
//        child: getElementList(),
//      ),
//    );
//  }
//
////  Widget getInvoiceCard(context,name,resName,panNo, DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders){
////    return Container(
////        child: ListView.builder(
////            padding: EdgeInsets.only(top: 6),
////            itemCount: orders.length,
////            itemBuilder: (BuildContext context, int position) {
////              return getInvoiceRow(position,name,resName,panNo,deliverDate,serviceCharge,subTotal,total,vatCharge,orders);
////            }));
////  }
//
//  Widget getInvoiceCard(context,name,resName,panNo, DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders){
//    return
//      Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Container(
//            child: ListView.builder(
//                shrinkWrap: true,
//                padding: EdgeInsets.only(top: 6),
//                itemCount: orders.length,
//                itemBuilder: (BuildContext context, int position) {
//                  return getInvoiceRow(position,name,resName,panNo,deliverDate,serviceCharge,subTotal,total,vatCharge,orders);
//                }
//            ),
//          )
//        ],
//      );
//  }
//
////  Widget getOrderCard(context,name,List<Order> orders){
////    return Container(
////        child: ListView.builder(
////            padding: EdgeInsets.only(top: 6),
////            itemCount: orders.length,
////            itemBuilder: (BuildContext context, int position) {
////              return getOrderRow(position,name,orders);
////            }));
////  }
//
//  Widget getOrderCard(context,name,List<Order> orders){
//    return
//      Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Container(
//            child: ListView.builder(
//                shrinkWrap: true,
//                padding: EdgeInsets.only(top: 6),
//                itemCount: orders.length,
//                itemBuilder: (BuildContext context, int position) {
//                  return getOrderRow(position,name,orders);
//                }
//            ),
//          )
//        ],
//      );
//  }
//
//  Widget getFirstView(){
//    return Container(
//        child : FutureBuilder(
//            future: _fetchListItem(widget.id),
//            builder: (context, AsyncSnapshot snapshot) {
//              if (!snapshot.hasData) {
//                return Padding(
//                  padding: const EdgeInsets.only(top: 200.0),
//                  child: Center(
//                      child: Column(
//                        children: <Widget>[
//                          if (snapshot.error == null) ...[
//                            CircularProgressIndicator(),
//                          ],
//                          Padding(
//                            padding: const EdgeInsets.only(top: 8.0),
//                            child: Text(
//                              snapshot.error == null
//                                  ? "Please Wait ..."
//                                  : "There Is No Any Menu List",
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontSize: 16,
//                                  fontFamily: "Poppins",
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          )
//                        ],
//                      )),
//                );
//              } else {
//                return Container(
//                    child: ListView.builder(
//                        padding: EdgeInsets.only(top: 6),
//                        itemCount: deliveryName.length,
//                        itemBuilder: (BuildContext context, int position) {
//                          return getRow(position);
//                        }));
//              }
//            })
//    );
//  }
//
//  Widget getInvoiceRow(int index,String name,resName,panNo,DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders){
//    return Card(
//      clipBehavior: Clip.antiAlias,
//      elevation: 2,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(4.0),
//        side: BorderSide(color: Colors.white10, width: 1),
//      ),
//      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
//      color: _selectedIndex != null && _selectedIndex == index
//          ? Colors.lightBlueAccent
//          : Colors.white70,
//      child: Container(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
////            Container(
////              color: Colors.grey,
////              child: Center(child: Padding(
////                padding: const EdgeInsets.all(8.0),
////                child: Text('INVOICE',style: TextStyle(fontWeight: FontWeight.bold),),
////              )),
////            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(resName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text('To,'),
//                )
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(resName,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey)),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey)),
//                  )
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text('Pan No: '+panNo,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey)),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: FittedBox(fit:BoxFit.scaleDown,child: Text('Invoice Date: '+deliverDate.toString().replaceAll('00:00:00.000', ''),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,))),
//                )
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(orders[index].menuName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink),),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Card(
//                    color:orders[index].status=='1'?Colors.green:Colors.red,
//                    clipBehavior: Clip.antiAlias,
//                    child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: orders[index].status=='1'?Text('Active',style:TextStyle(color: Colors.white),):Text('Inactive',style:TextStyle(color: Colors.white),),
//                    ),
//                  ),
//                )
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text('Rate : Rs. ${orders[index].rate}'+ ' ''X'+ ' ''Qty : ${orders[index].qty}',style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w500),)
//                ),
//                Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text('Total : Rs. ${orders[index].amount}',style: TextStyle(fontWeight: FontWeight.w500),)
//                ),
//              ],
//            ),
//            Divider(height: 1,color: Colors.blueGrey,),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('Sub - Total Amount: Rs. $subTotal'),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('VAT(13%): Rs. $vatCharge'),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('Delivery Charge: Rs. $serviceCharge'),
//            ),
//            Divider(height: 1,color: Colors.blueGrey,),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('Total: Rs. $total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.blueGrey),),
//            ),
//
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget getOrderRow(int index,String name,List<Order> orders){
//    return Card(
//      elevation: 2,
//      clipBehavior: Clip.antiAlias,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(4.0),
//        side: BorderSide(color: Colors.white10, width: 1),
//      ),
//      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
//      color: _selectedIndex != null && _selectedIndex == index
//          ? Colors.lightBlueAccent
//          : Colors.white70,
//
//      child: Container(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
////            Container(
////              color: Colors.grey,
////              child: Center(child: Padding(
////                padding: const EdgeInsets.all(8.0),
////                child: Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
////              )),
////            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text(orders[index].menuName,style: TextStyle(fontWeight: FontWeight.bold),),
//                ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Card(
//                    color:orders[index].status=='1'?Colors.green:Colors.red,
//                    clipBehavior: Clip.antiAlias,
//                    child: Padding(
//                      padding: const EdgeInsets.all(4.0),
//                      child: orders[index].status=='1'?Text('Active',style:TextStyle(color: Colors.white),):Text('Inactive',style:TextStyle(color: Colors.white),),
//                    ),
//                  ),
//                )
//              ],
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text('Rate : Rs. ${orders[index].rate}'+ ' ''X'+ ' ''Qty : ${orders[index].qty}')
//                ),
//                Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text('Total : Rs. ${orders[index].amount}',style: TextStyle(fontWeight: FontWeight.bold),)
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//  Widget getRow(int index){
//    return Card(
//
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(4.0),
//        side: BorderSide(color: Colors.white10, width: 1),
//      ),
//      margin: EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 4.0),
//      color: _selectedIndex != null && _selectedIndex == index
//          ? Colors.lightBlueAccent
//          : Colors.white70,
//    child: Container(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(deliveryName[index].deliveryId,style: TextStyle(fontWeight: FontWeight.bold),),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Card(
//                  color: Colors.blue,
//                  clipBehavior: Clip.antiAlias,
//                  child: Padding(
//                    padding: const EdgeInsets.all(4.0),
//                    child: Text(deliveryName[index].paidStatus,style:TextStyle(color: Colors.white) ,),
//                  ),
//                ),
//              )
//            ],
//          ),
//          Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Text(deliveryName[index].customerName),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Text(deliveryName[index].phone),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Text(deliveryName[index].address),
//          ),
//
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(deliveryName[index].orderDate,style: TextStyle(fontWeight: FontWeight.bold),),
//              ),
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Row(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: CircleAvatar(
//                            radius: 15,
//                            backgroundColor: Colors.green,
//                            child: IconButton(
//                              splashColor: Colors.blue,
//                              icon: Icon(
//                                Icons.tv,
//                                size: 15,
//                                color: Colors.white ,
//                              ),
//                              tooltip: "View",
//                              onPressed: () {
//                                _showDialogOrderView(deliveryName[index].customerName,deliveryName[index].orders);
//                              },
//                            )),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: CircleAvatar(
//                            radius: 15,
//                            backgroundColor: Colors.green,
//                            child: IconButton(
//                              splashColor: Colors.blue,
//                              icon: Icon(
//                                Icons.insert_drive_file,
//                                size: 15,
//                                color: Colors.white ,
//                              ),
//                              tooltip: "Invoice View",
//                              onPressed: () {
//                                setState(() {
//                                  dateTime = deliveryName[index].deliverDate;
//                                });
//
//                                _showDialogInvoiceView(deliveryName[index].customerName,deliveryName[index].resName,deliveryName[index].panNo,
//                                    dateTime,deliveryName[index].serviceCharge,deliveryName[index].subTotal,deliveryName[index].total,
//                                    deliveryName[index].vat,
//                                    deliveryName[index].orders);
//                              },
//                            )),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: CircleAvatar(
//                            radius: 15,
//                            backgroundColor: Colors.green,
//                            child: IconButton(
//                              splashColor: Colors.blue,
//                              icon: Icon(
//                                Icons.save,
//                                size: 15,
//                                color: Colors.white ,
//                              ),
//                              tooltip: "Accept Delivery",
//                              onPressed: () {
//
//                              },
//                            )),
//                      )
//                    ],
//                  )
//                ),
//              )
//            ],
//          ),
//        ],
//      ),
//    ),
//    );
//  }
//
//  Widget _showDialogOrderView(name,List<Order>orders) {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return Padding(
//          padding: const EdgeInsets.all(15.0),
//          child: customDialog.Dialog(
//              child : Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Container(
//                    color: Colors.white,
//                    child: Center(child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
//                    )),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Container(width:double.maxFinite, child: getOrderCard(context,name,orders)),
//                  ),
//                  RaisedButton(
//                    onPressed: () {},
//                    textColor: Colors.white,
//                    padding: const EdgeInsets.all(0.0),
//                    child: Container(
//                        decoration: const BoxDecoration(
//
//                          gradient: LinearGradient(
//                            colors: <Color>[
//                              Color(0xFF0D47A1),
//                              Color(0xFF1976D2),
//                              Color(0xFF42A5F5),
//                            ],
//                          ),
//
//                        ),
//                        padding: const EdgeInsets.all(10.0),
//                        child:
//                        const Text('Accept Order', style: TextStyle(fontSize: 20))
//                    ),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  )
//                ],
//              )
//          ),
//        );
//      },
//    );
//  }
//
////  Widget _showDialogOrderView(name,List<Order> orders) {
////    // flutter defined function
////    showDialog(
////      context: context,
////      builder: (BuildContext context) {
////        // return object of type Dialog
////        return Padding(
////          padding: const EdgeInsets.all(15.0),
////          child: FittedBox(
////            fit: BoxFit.scaleDown,
////            child: customDialog.AlertDialog(
////              title:  Container(
////                width:MediaQuery.of(context).size.width,
////                color: Colors.grey,
////                child: Center(child: Padding(
////                  padding: const EdgeInsets.all(8.0),
////                  child:Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
////                )),
////              ),
////              content:Container(width:MediaQuery.of(context).size.width,child: getOrderCard(context,name,orders)),
////              actions: <Widget>[
////
////                Align(
////                  alignment: Alignment.bottomCenter,
////                  child: InkWell(
////                    child: Container(
////                      width: ScreenUtil.getInstance().setWidth(235),
////                      height: ScreenUtil.getInstance().setHeight(80),
////                      decoration: BoxDecoration(
////                        gradient: LinearGradient(
////                            colors: <Color>[
////                              Color(0xFF0D47A1),
////                              Color(0xFF1976D2),
////                              Color(0xFF42A5F5),
////                            ],
////                          ),
////                          borderRadius: BorderRadius.circular(6.0),
////                          boxShadow: [
////                            BoxShadow(
////                                color: Colors.black12.withOpacity(.3),
////                                offset: Offset(5.0, 8.0),
////                                blurRadius: 8.0)
////                          ]),
////                      child: Material(
////                        color: Colors.transparent,
////                        child: InkWell(
////                          onTap: () async {
//////
////                            setState(() {
//////                            _isLoading = true;
////                            });
//////                          _validateInputs();
////                          },
////                          child: Center(
////                            child: Text("Accept Order",
////                                style: TextStyle(
////                                    color: Colors.white,
////                                    fontFamily: "Poppins-Bold",
////                                    fontSize: 16,
////                                    letterSpacing: 1.0)),
////                          ),
////                        ),
////                      ),
////                    ),
////                  ),
////                ),
////              ],
////            ),
////          ),
////        );
////      },
////    );
////  }
//
//  Widget _showDialogInvoiceView(name,resName,panNo,DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders) {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return Padding(
//          padding: const EdgeInsets.all(15.0),
//          child: FittedBox(
//            fit: BoxFit.scaleDown,
//            child: customDialog.AlertDialog(
//              title:  Container(
//                width:MediaQuery.of(context).size.width,
//                color: Colors.grey,
//                child: Center(child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Text('INVOICE',style: TextStyle(fontWeight: FontWeight.bold),),
//                )),
//              ),
//                content:Container(width:MediaQuery.of(context).size.width,child: getInvoiceCard(context,name,resName,panNo, deliverDate,serviceCharge,subTotal,total,vatCharge,orders)),
//                actions: <Widget>[
//                  Align(
//                    alignment: Alignment.bottomCenter,
//                    child: InkWell(
//                      child: Container(
//                        width: ScreenUtil.getInstance().setWidth(300),
//                        height: ScreenUtil.getInstance().setHeight(80),
//                        decoration: BoxDecoration(
//                          gradient: LinearGradient(
//                              colors: <Color>[
//                                Color(0xFF0D47A1),
//                                Color(0xFF1976D2),
//                                Color(0xFF42A5F5),
//                              ],
//                            ),
//                            borderRadius: BorderRadius.circular(6.0),
//                            boxShadow: [
//                              BoxShadow(
//                                  color: Colors.black12.withOpacity(.3),
//                                  offset: Offset(5.0, 8.0),
//                                  blurRadius: 8.0)
//                            ]),
//                        child: Material(
//                          color: Colors.transparent,
//                          child: InkWell(
//                            onTap: () async {
////
//                              setState(() {
////                            _isLoading = true;
//                              });
////                          _validateInputs();
//                            },
//                            child: Center(
//                              child: Text("Accept Payment",
//                                  style: TextStyle(
//                                      color: Colors.white,
//                                      fontFamily: "Poppins-Bold",
//                                      fontSize: 16,
//                                      letterSpacing: 1.0)),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//
////  Widget _showDialogInvoiceView(name,resName,panNo,DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders) {
////    // flutter defined function
////    showDialog(
////      context: context,
////      builder: (BuildContext context) {
////        // return object of type Dialog
////        return Padding(
////          padding: const EdgeInsets.all(15.0),
////          child: customDialog.Dialog(
////              child : Column(
////                mainAxisSize: MainAxisSize.min,
////                children: <Widget>[
////                  Container(
////                    color: Colors.white,
////                    child: Center(child: Padding(
////                      padding: const EdgeInsets.all(8.0),
////                      child: Text('INVOICE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
////                    )),
////                  ),
////                  Padding(
////                    padding: const EdgeInsets.all(8.0),
////                    child: Container(width:double.maxFinite, child:getInvoiceCard(context,name,resName,panNo, deliverDate,serviceCharge,subTotal,total,vatCharge,orders)),
////                  ),
////                  RaisedButton(
////                    onPressed: () {},
////                    textColor: Colors.white,
////                    padding: const EdgeInsets.all(0.0),
////                    child: Container(
////                        decoration: const BoxDecoration(
////
////                          gradient: LinearGradient(
////                            colors: <Color>[
////                              Color(0xFF0D47A1),
////                              Color(0xFF1976D2),
////                              Color(0xFF42A5F5),
////                            ],
////                          ),
////
////                        ),
////                        padding: const EdgeInsets.all(10.0),
////                        child:
////                        const Text('Accept Order', style: TextStyle(fontSize: 20))
////                    ),
////                  ),
////                  SizedBox(
////                    height: 20,
////                  )
////                ],
////              )
////          ),
////        );
////      },
////    );
////  }
//  _fetchListItem(userId) async {
//    String dataURL = "https://www.admin.halfwaiter.com/demo/api/request/adminDeliveryOrder?user_id=$userId";
//    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Eprim@Res!"});
//    deliveryName.clear();
//    for (Datum datum  in deliveryModelFromJson(response.body).data) {
//
//      deliveryName.add(datum);
//    }
//    return deliveryName;
//  }
//
//  Widget getElementList() {
//    return Padding(
//        padding: const EdgeInsets.only(bottom: 8.0),
//        child: getFirstView()
//    );
//  }
//
//}