import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/Model_Classes/TodayEarningModel.dart';
import 'package:halfwaiteradminapp/Model_Classes/TodayOrderModel.dart';
import 'package:halfwaiteradminapp/Model_Classes/TotalEarningModel.dart';
import 'package:halfwaiteradminapp/Model_Classes/TotalOrderModel.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget with NavigationStates {
  String id,name,onStatus;

  Dashboard(this.id, this.name,this.onStatus);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var todayEarning = "0";
  var todayOrder = "0";
  var totalEarning = "0";
  var totalOrder = "0";
  bool toogleValue;
  String onValue;
  bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.onStatus=='1'?toogleValue=true:toogleValue=false;
    _fetchTodayEarningItem(widget.id);
    _fetchTodayOrderItem(widget.id);
    _fetchTotalEarningItem(widget.id);
    _fetchTotalOrderItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          child: mainbody(),

        )
      ],
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
                      child: Center(child: AnimatedContainer(
                        duration:Duration(milliseconds: 1000) ,
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toogleValue?Colors.greenAccent[100]:Colors.redAccent[100].withOpacity(0.5),
                        ),
                        child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                              duration:Duration(milliseconds: 1000),
                              curve: Curves.easeIn,
                              top: 3.0,
                              left: toogleValue?63.0:10.0,
                              right: toogleValue?10.0:63.0,
                              child: InkWell(
                                onTap: (){
                                  toogleButton();
                                },
                                child: AnimatedSwitcher(
                                  duration:Duration(milliseconds: 1000),
                                  transitionBuilder: (Widget child,Animation<double>animation){
                                    return ScaleTransition(child: child, scale: animation,);
                                  },
                                  child: toogleValue?Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right:8.0),
                                        child: Text('OnLine',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                                      ),
                                      Icon(Icons.check_circle,color: Colors.green,size: 30.0,key: UniqueKey()),
                                    ],
                                  ):
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right:8.0),
                                        child: Text('Offline',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black),),
                                      ),
                                      Icon(Icons.remove_circle_outline,color: Colors.red,size:35.0,key: UniqueKey()),
                                    ],
                                  ),
                                ),
                              ),

                            )
                          ],
                        ),
                      )),
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

  toogleButton() {
    setState(() {
      toogleValue =!toogleValue;
      toogleValue?onValue='1':onValue='0';
      postData(widget.id, onValue);

    });
  }

  Widget mainbody() {
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 18),
            child: Card(
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                width: double.infinity,
                //height: ScreenUtil.getInstance().setHeight(680),
                //height: MediaQuery.of(context).size.height,

                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0),
                    ]),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 22.0,left: 8.0,right: 8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins-bold")),
                        ),
                      ),
                    ),

//                    //Total number of sites
//
//                    SizedBox(
//                      height: ScreenUtil.getInstance().setHeight(20),
//                    ),
//                    InkWell(
//                      child: Card(
//                        elevation: 5,
//                        child: Container(
//                          width: ScreenUtil.getInstance().setWidth(630),
//                          height: ScreenUtil.getInstance().setHeight(210),
//                          decoration: BoxDecoration(
//                              gradient: LinearGradient(colors: [
//                                Colors.white,
//                                Colors.white,
//                              ]),
//                              borderRadius: BorderRadius.circular(2.0),
//                              boxShadow: [
//                                BoxShadow(
//                                    color: Colors.white12.withOpacity(.1),
//                                    offset: Offset(0.0, 8.0),
//                                    blurRadius: 8.0)
//                              ]),
//                          child: Material(
//                            color: Colors.transparent,
//                            child: InkWell(
//                              splashColor: Colors.blue,
//                              onTap: () {
//                                BlocProvider.of<NavigationBloc>(context)
//                                    .add(NavigationEvents.DeliveryClickedEvent);
//                              },
//                              child: Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: <Widget>[
//                                  Align(
//                                    alignment: Alignment.topCenter,
//                                    child: Padding(
//                                      padding: const EdgeInsets.only(
//                                          bottom: 5, left: 5.0, right: 5.0),
//                                      child: Image.asset(
//                                          "assets/images/supplier_list.png"
//                                      ),
//                                    ),
//                                  ),
//                                  Align(
//                                    alignment: Alignment.center,
//                                    child: Padding(
//                                      padding: const EdgeInsets.only(
//                                          top: 2, left: 5.0, right: 5.0),
//                                      child: FittedBox(
//                                        fit: BoxFit.scaleDown,
//                                        child: Text("Delivery",
//                                            style: TextStyle(
//                                                color: Colors.black,
//                                                fontFamily: "Poppins",
//                                                fontSize: 15,
//                                                letterSpacing: 0.8)),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),


                    //Today order , Today Earning

                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: ScreenUtil.getInstance().setWidth(300),
                              height: ScreenUtil.getInstance().setHeight(250),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white,
                                  ]),
                                  borderRadius: BorderRadius.circular(2.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white12.withOpacity(.1),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () {
//                                    BlocProvider.of<NavigationBloc>(context)
//                                        .add(NavigationEvents.SitePhotoClickedEvent);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, left: 5, right: 5),
//                                          child: Image.asset(
//                                              'assets/images/sitephoto.png'
//                                          ),
                                        child: Text(todayOrder),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 5, right: 5),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("Today Order",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Poppins",
                                                    fontSize: 15,
                                                    letterSpacing: 0.8)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: ScreenUtil.getInstance().setWidth(300),
                              height: ScreenUtil.getInstance().setHeight(250),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white,
                                  ]),
                                  borderRadius: BorderRadius.circular(2.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white12.withOpacity(.1),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () {

//                                    BlocProvider.of<NavigationBloc>(context)
//                                        .add(NavigationEvents.BillPhotoClickedEvent);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, left: 5, right: 5),
//                                          child: Image.asset(
//                                              'assets/images/bill.png'
//                                          ),
                                        child: Text('Rs. '+ todayEarning),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 5, right: 5),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("Today Earning",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Poppins",
                                                    fontSize: 15,
                                                    letterSpacing: 0.8)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Total order , Total Earning

                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          child: Card(
                            child: Container(
                              width: ScreenUtil.getInstance().setWidth(300),
                              height: ScreenUtil.getInstance().setHeight(250),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white,
                                  ]),
                                  borderRadius: BorderRadius.circular(2.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white12.withOpacity(.1),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () {
//                                    BlocProvider.of<NavigationBloc>(context)
//                                        .add(NavigationEvents.AttendanceClickedEvent);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
//                                          child: Image.asset('assets/images/attendance.png'),
                                        child: Text(totalOrder),
                                        ),
                                      ),
//                                          }
//                                        }
//                                    ),

                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 5, right: 5),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("Total Order",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Poppins",
                                                    fontSize: 15,
                                                    letterSpacing: 0.8)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: ScreenUtil.getInstance().setWidth(300),
                              height: ScreenUtil.getInstance().setHeight(250),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white,
                                  ]),
                                  borderRadius: BorderRadius.circular(2.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white12.withOpacity(.1),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () {
//                                    BlocProvider.of<NavigationBloc>(context)
//                                        .add(NavigationEvents.StockClickedEvent);
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, left: 0.0, right: 5.0),
//                                          child: Image.asset('assets/images/stock.png'),
                                        child: Text('Rs. '+totalEarning),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2.0, left: 5, right: 5),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text("Total Earning",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Poppins",
                                                    fontSize: 15,
                                                    letterSpacing: 0.8)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  _fetchTodayEarningItem(userId) async {
    String dataURL =
        "https://www.admin.halfwaiter.com/demo/api/request/todayEarning?user_id=$userId";

    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});
    final todayEarningList = todayEarningModelFromJson(response.body);
    setState(() {
      todayEarning = todayEarningList.data;
    });
    return todayEarning;
  }
  _fetchTodayOrderItem(userId) async {
    String dataURL =
        "https://www.admin.halfwaiter.com/demo/api/request/todayOrder?user_id=$userId";

    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});
    final todayOrderList = todayOrderModelFromJson(response.body);
    setState(() {
      todayOrder = todayOrderList.data;
    });

    return todayOrder;
  }
  _fetchTotalEarningItem(userId) async {
    String dataURL =
        "https://www.admin.halfwaiter.com/demo/api/request/totalEarning?user_id=$userId";

    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});
    final totalEarningList = totalEarningModelFromJson(response.body);
    setState(() {
      totalEarning = totalEarningList.data;
    });

    return totalEarning;
  }
  _fetchTotalOrderItem(userId) async {
    String dataURL =
        "https://www.admin.halfwaiter.com/demo/api/request/totalOrder?user_id=$userId";

    http.Response response =
    await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});
    final totalOrderList = totalOrderModelFromJson(response.body);
    setState(() {
      totalOrder = totalOrderList.data;
    });

    return totalOrder;
  }

  void postData( String userId,String onValue) async {
    Map data = {
      'user_id': userId,
      'online':onValue,
    };
    var jsonResponse;
    var response = await http.post(
        "https://www.admin.halfwaiter.com/demo/api/request/resStatus",
        headers: {"x-api-key": r"Eprim@Res!"},
        body: data);
//    print(response.body);
    if (response.statusCode == 200) {
//      final loginResponseData = loginResponseFromJson(response.body);
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        Fluttertoast.showToast(
            msg: "Status Changed Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            timeInSecForIos: 1);

//        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed to add Data",
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
}



