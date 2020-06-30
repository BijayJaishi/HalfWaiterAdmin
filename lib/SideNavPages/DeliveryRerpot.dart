import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/Model_Classes/DeliveryModel.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:halfwaiteradminapp/Custom_dialog/customDialog.dart' as customDialog;

import '../MainSideNav.dart';

class DeliveryReport extends StatefulWidget with NavigationStates {
  String id,name,onStatus;

  DeliveryReport(this.id, this.name,this.onStatus);

  @override
  _DeliveryReportState createState() => _DeliveryReportState();
}

class _DeliveryReportState extends State<DeliveryReport> {
  List<Datum> deliveryName = [];
  List<Order> orderName =[];
  int _selectedIndex;
  String clientName;
  DateTime dateTime;

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
                    padding: const EdgeInsets.only(left:50.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 160,
                      height: 60,
                      child: Card(
                        child: Center(child: Text('Delivery Report',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
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

  Widget getFirstView(){
    return Container(
        child : FutureBuilder(
            future: _fetchListItem(widget.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                      child: Column(
                        children: <Widget>[
                          if (snapshot.error == null)
                            CircularProgressIndicator(),

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
            })
    );
  }

  Widget getOrderFirstView(name,List<Order> orders){
    return
      Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
      Container(
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 6),
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int position) {
            return getOrderRow(position,name,orders);
          }
      ),
    )
    ],
    );
  }

  /////// --------------------------------- invoice view --------------------------------- ///////

  Widget _showDialogInvoiceView(deliveryId,name,resName,panNo,DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: customDialog.Dialog(

              child : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('INVOICE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                        child: Text(resName,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
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
                        child: Text('Invoice Id : $deliveryId',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Pan No: '+panNo,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(fit:BoxFit.scaleDown,child: Text('Invoice Date: '+deliverDate.toString().replaceAll('00:00:00.000', ''),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,))),
                      )
                    ],
                  ),
//  Text('I am here'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width:double.maxFinite, child: getInvoiceCard(context,name,resName,panNo, deliverDate,serviceCharge,subTotal,total,vatCharge,orders),),
                  ),
                  Divider(height: 1,color: Colors.blueGrey,),
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
                  Divider(height: 1,color: Colors.blueGrey,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total: Rs. $total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.blueGrey),),
                  ),
//
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
//                        const Text('PAID', style: TextStyle(fontSize: 20))
//                    ),
//                  ),
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

  Widget getInvoiceCard(context,name,resName,panNo, DateTime deliverDate,serviceCharge,subTotal,total,vatCharge,List<Order> orders){

    return
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 6),
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int position) {
                  return getInvoiceOrderRow(position,name,orders);
                }
            ),
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

  Widget getInvoiceOrderRow(int index,String name,List<Order> orders){
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
                  child: Text(orders[index].menuName,style: TextStyle(fontWeight: FontWeight.bold),),
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
                        Text('Rate : Rs.'+orders[index].rate),
                        SizedBox(
                          width: 5,
                        ),
                        Text('X',style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Qty : '+orders[index].qty),
                      ],
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total : Rs.'+orders[index].amount,style: TextStyle(fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //////////////////// ----------------- end invoice view -------------------------------- ///////

  Widget getOrderRow(int index,String name,List<Order> orders){
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
                  child: Text(orders[index].menuName,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color:orders[index].status=='1'?Colors.green:Colors.red,
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: orders[index].status=='1'?Text('Active',style:TextStyle(color: Colors.white),):Text('Pending',style:TextStyle(color: Colors.white),),
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
                      Text('Rate : Rs.'+orders[index].rate),
                      SizedBox(
                        width: 5,
                      ),
                      Text('X',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Qty : '+orders[index].qty),
                    ],
                  )
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total : Rs.'+orders[index].amount,style: TextStyle(fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index){
//    dateTime = ;
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
                child: Text(deliveryName[index].deliveryId,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(deliveryName[index].paidStatus,style:TextStyle(color: Colors.white) ,),
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
                child: Text(deliveryName[index].deliverDate.toString().replaceAll('00:00:00.000', ''),style: TextStyle(fontWeight: FontWeight.bold),),
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
                                Icons.insert_drive_file,
                                size: 15,
                                color: Colors.white ,
                              ),
                              tooltip: "Invoice View",
                              onPressed: () {
                                setState(() {
                                  dateTime = deliveryName[index].deliverDate;
                                });

                                _showDialogInvoiceView(deliveryName[index].deliveryId,deliveryName[index].customerName,deliveryName[index].resName,deliveryName[index].panNo,
                                    dateTime,deliveryName[index].serviceCharge,deliveryName[index].subTotal,deliveryName[index].total,
                                    deliveryName[index].vat,
                                    deliveryName[index].orders);
                              },
                            )),
                      ),

                    ],
                  )
                ),
              )
            ],
          ),
        ],
      ),
    ),
    );
  }

  Widget _showDialogOrderView(name,orders) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: customDialog.Dialog(

            child : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  )),
                ),
//  Text('I am here'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width:double.maxFinite, child: getOrderElementList(name,orders),),
                ),
              RaisedButton(
                onPressed: () {},
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
                  child:
                  const Text('Accept Order', style: TextStyle(fontSize: 20))
                ),
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

  _fetchListItem(userId) async {
    String dataURL = "https://www.admin.halfwaiter.com/api/request/adminDeliveryOrderHistory?user_id=$userId";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Eprim@Res!"});
    deliveryName.clear();
    orderName.clear();
    for (Datum datum  in deliveryModelFromJson(response.body).data) {

      deliveryName.add(datum);
      
    }
//    print("Delivery : ${deliveryName[2].orders[1].amount}");
    return deliveryName;
  }

//  _fetchOrderListItem(userId) async {
//    String dataURL = "https://www.admin.halfwaiter.com/api/request/adminDeliveryOrder?user_id=$userId";
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
        padding: const EdgeInsets.only(bottom: 8.0),
        child: getFirstView()
    );
  }

  Widget getOrderElementList(name,orders) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),


        child: getOrderFirstView(name,orders)
    );
  }
}