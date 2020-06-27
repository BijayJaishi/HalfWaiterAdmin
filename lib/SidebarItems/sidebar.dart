import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu_item.dart';
import 'navigation_bloc.dart';

class SideBar extends StatefulWidget {
  final id, name, onStatus;

   SideBar(this.id, this.name,this.onStatus);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {

  Color _addDashcolor = Color.fromRGBO(59, 128, 198, 0.4);
  Color _adddevcolor = Colors.white;
  Color _deliveryReportcolor = Colors.white;
  Color _addmenuListcolor = Colors.white;
  Color _categorycolor = Colors.white;
//  Color _attendcolor = Colors.white;
//  Color _transcolor = Colors.white;
//  Color _stockcolor = Colors.white;
//  Color _supplistcolor = Colors.white;
//  Color _prodlistcolor = Colors.white;
//  Color _unitlistcolor = Colors.white;
//  Color _expensecolor = Colors.white;

  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 25,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 35,
          child:
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height ,
                          margin: EdgeInsets.only(top: 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(59, 128, 198, 1),),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 115,
                                    child: Card(
                                      margin: EdgeInsets.all(0.0),
                                      color:Color.fromRGBO(59, 128, 198, 1),
                                      child: ListTile(
                                        title: Text(
                                          "Welcome",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Text(
                                            widget.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
//                      Divider(
//                        height: 64,
//                        thickness: 0.5,
//                        color: Colors.white.withOpacity(0.3),
//                        indent: 32,
//                        endIndent: 32,
//                      ),


                                  MenuItem(
                                    image: AssetImage('assets/images/dashboard.png'),
                                    title: "DashBoard",
                                    color: _addDashcolor,
                                    onTap: () {
                                      _addDashcolor = Color.fromRGBO(59, 128, 198, 0.4);
                                      _adddevcolor = Colors.white;
                                      _deliveryReportcolor = Colors.white;
                                      _addmenuListcolor = Colors.white;
                                      _categorycolor = Colors.white;

//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;

                                      onIconPressed();
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(NavigationEvents.DashBoardClickedEvent);
                                    },
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 0.5,
                                    color: Colors.grey.withOpacity(1),
                                  ),

                                  MenuItem(
                                    image: AssetImage('assets/images/delivery.png'),
                                    title: "Delivery",
                                    color: _adddevcolor,
                                    onTap: () {
                                      _addDashcolor = Colors.white;
                                      _adddevcolor = Color.fromRGBO(59, 128, 198, 0.4);
                                      _deliveryReportcolor = Colors.white;
                                      _addmenuListcolor = Colors.white;
                                      _categorycolor = Colors.white;

//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;

                                      onIconPressed();
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(NavigationEvents.DeliveryClickedEvent);
                                    },
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 0.5,
                                    color: Colors.grey.withOpacity(1),
                                  ),

                                  MenuItem(
                                    image: AssetImage('assets/images/report.png'),
                                    title: "Delivery Report List",
                                    color:_deliveryReportcolor ,
                                    onTap: () {
                                      _addDashcolor = Colors.white;
                                      _adddevcolor = Colors.white;
                                      _deliveryReportcolor = Color.fromRGBO(59, 128, 198, 0.4);
                                      _addmenuListcolor = Colors.white;
                                      _categorycolor = Colors.white;

//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
                                      onIconPressed();
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(NavigationEvents.DeliveryReportClickedEvent);
                                    },
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 0.5,
                                    color: Colors.grey.withOpacity(1),
                                  ),
                                  MenuItem(
                                    image: AssetImage('assets/images/menuList.png'),
                                    title: "Menu List",
                                    color: _addmenuListcolor,
                                    onTap: () {
                                      _addDashcolor = Colors.white;
                                      _adddevcolor = Colors.white;
                                      _deliveryReportcolor = Colors.white;
                                      _addmenuListcolor = Color.fromRGBO(59, 128, 198, 0.4);
                                      _categorycolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
                                      onIconPressed();
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(NavigationEvents.MenuListClickedEvent);
                                    },
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 0.5,
                                    color: Colors.grey.withOpacity(1),
                                  ),
                                  MenuItem(
                                    image: AssetImage('assets/images/category.png'),
                                    title: "Category List",
                                    color: _categorycolor,
                                    onTap: () {
                                      _addDashcolor = Colors.white;
                                      _adddevcolor = Colors.white;
                                      _deliveryReportcolor = Colors.white;
                                      _addmenuListcolor = Colors.white;
                                      _categorycolor = Color.fromRGBO(59, 128, 198, 0.4);
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
                                      onIconPressed();
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(NavigationEvents.CategoryClickedEvent);
                                    },
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 0.5,
                                    color: Colors.grey.withOpacity(1),
                                  ),

//                                  MenuItem(
//                                    image: AssetImage('assets/images/attendance.png'),
//                                    title: "Attendance",
//                                    color:_attendcolor ,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.deepOrangeAccent;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context)
//                                          .add(NavigationEvents.AttendanceClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
//                                  MenuItem(
//                                    image: AssetImage('assets/images/transportationcost.png'),
//                                    title: "Transportation Cost",
//                                    color: _transcolor,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.deepOrangeAccent;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context).add(
//                                          NavigationEvents.TransportationClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
//                                  MenuItem(
//                                    image: AssetImage('assets/images/stock.png'),
//                                    title: "Stock",
//                                    color:_stockcolor ,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.deepOrangeAccent;
//                                      _expensecolor =Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context)
//                                          .add(NavigationEvents.StockClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
//                                  MenuItem(
//                                    image: AssetImage('assets/images/expense_icon.png'),
//                                    title: "Add OverHead Expenses",
//                                    color: _expensecolor,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white ;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor = Colors.deepOrangeAccent;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context)
//                                          .add(NavigationEvents.ExpenseClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
//                                  MenuItem(
//                                    image: AssetImage('assets/images/supplier_list.png'),
//                                    title: "Supplier list",
//                                    color:_supplistcolor ,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor = Colors.white;
//                                      _supplistcolor = Colors.deepOrangeAccent;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.white;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context)
//                                          .add(NavigationEvents.SupplierListClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
//                                  MenuItem(
//                                    image: AssetImage('assets/images/addproduct.png'),
//                                    title: "Product List",
//                                    color: _prodlistcolor,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor = Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.deepOrangeAccent;
//                                      _unitlistcolor = Colors.white;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context)
//                                          .add(NavigationEvents.ProductListClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
//                                  MenuItem(
//                                    image: AssetImage('assets/images/units.png'),
//                                    title: "Unit List",
//                                    color: _unitlistcolor,
//                                    onTap: () {
//                                      _addDashcolor = Colors.white;
//                                      _addsuppcolor = Colors.white;
//                                      _addprodcolor = Colors.white;
//                                      _sitephocolor = Colors.white;
//                                      _billphocolor = Colors.white;
//                                      _attendcolor = Colors.white;
//                                      _transcolor = Colors.white;
//                                      _stockcolor = Colors.white;
//                                      _expensecolor = Colors.white;
//                                      _supplistcolor = Colors.white;
//                                      _prodlistcolor = Colors.white;
//                                      _unitlistcolor = Colors.deepOrangeAccent;
//                                      onIconPressed();
//                                      BlocProvider.of<NavigationBloc>(context)
//                                          .add(NavigationEvents.UnitClickedEvent);
//                                    },
//                                  ),
//                                  Divider(
//                                    height: 2,
//                                    thickness: 0.5,
//                                    color: Colors.grey.withOpacity(1),
//                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    Align(
                      alignment: Alignment(0, -1.0),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          onIconPressed();
                        },
                        child: ClipPath(
                          clipper: CustomMenuClipper(),
                          child: Container(
                            width: 35,
                            height: 110,
                            color: Color.fromRGBO(59, 128, 198, 1),
                            alignment: Alignment.centerLeft,
                            child: AnimatedIcon(
                              progress: _animationController.view,
                              icon: AnimatedIcons.menu_close,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 12, 10, 20);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
