import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halfwaiteradminapp/Model_Classes/DeliveryModel.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:halfwaiteradminapp/Custom_dialog/customDialog.dart' as customDialog;

class Delivery extends StatefulWidget with NavigationStates {
  String id,name;

  Delivery(this.id, this.name);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  List<Datum> deliveryName = [];
  List<Order> orderName =[];
  int _selectedIndex ;
  String clientName;




//  _onSelected(int index) {
//    setState(() => _selectedIndex = index);
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SiteTabView(sitesName[index].siteName,sitesName[index].siteId)),
//    );
//  }

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
                        child: Center(child: Text('Delivery',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.deepOrangeAccent,
                        child: IconButton(
                          splashColor: Colors.blue,
                          icon: Icon(
                            Icons.dashboard,
                            size: 28,
                            color: Colors.black,
                          ),
                          tooltip: "DashBoard",
                          onPressed: () {
//                            Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      DashBoardManager(widget.id, widget.name)),
//                            );
                          },
                        )),
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

  Widget getOrderCard(context,name,orders){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: getOrderElementList(name,orders),
      ),
    );
  }

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
                          if (snapshot.error == null) ...[
                            CircularProgressIndicator(),
                          ],
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
  Widget getOrderFirstView(name,orders){
    return Container(
        child :  Container(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 6),
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, int position) {
                          return getOrderRow(position,name,orders);
                        }
                        )
        )
    );
//              }
            }
//            )
//    )
//  }

  Widget getOrderRow(int index,String name,orders){
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
//            Container(
//              color: Colors.grey,
//              child: Center(child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
//              )),
//            ),
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
                      child: orders[index].status=='1'?Text('Active',style:TextStyle(color: Colors.white),):Text('Inactive',style:TextStyle(color: Colors.white),),
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
                  child: Text('Rate : Rs. ${orders[index].rate}'+ ' ''X'+ ' ''Qty : ${orderName[index].qty}')
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total : Rs. ${orders[index].amount}',style: TextStyle(fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget getRow(int index){
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
                child: Text(deliveryName[index].orderDate,style: TextStyle(fontWeight: FontWeight.bold),),
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
                                color: Colors.white ,
                              ),
                              tooltip: "View",
                              onPressed: () {
                                _showDialogOrderView(deliveryName[index].customerName,deliveryName[index].orders);
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
                                color: Colors.white ,
                              ),
                              tooltip: "Invoice View",
                              onPressed: () {

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
                                color: Colors.white ,
                              ),
                              tooltip: "Accept Delivery",
                              onPressed: () {

                              },
                            )),
                      )
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

  Widget _showDialogOrderView(name,List<Order> orders) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return customDialog.Dialog(



//            content:Container(width:double.maxFinite,child: getOrderCard(context,name,orders)),


//          title: Container(
//            color: Colors.grey,
//            width: double.infinity,
//            child: Center(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Text(
//                  name,
//                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                ),
//              ),
//            ),
//          ),
//          content: getOrderCard(context,name,orders),
          child:  Container(width:double.maxFinite,child: getOrderCard(context,name,orders))
        );
      },
    );
  }

  _fetchListItem(userId) async {
    String dataURL = "https://www.admin.halfwaiter.com/demo/api/request/adminDeliveryOrder?user_id=$userId";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Eprim@Res!"});
    deliveryName.clear();
    orderName.clear();
    for (Datum datum  in deliveryModelFromJson(response.body).data) {

      deliveryName.add(datum);
    }
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