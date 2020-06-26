import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/Model_Classes/MenuListModel.dart';
import 'package:halfwaiteradminapp/SideNavPages/AddMenu.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:http/http.dart' as http;

import '../MainSideNav.dart';

class MenuList extends StatefulWidget with NavigationStates {
  final String id, name,onStatus;

  MenuList(this.id, this.name,this.onStatus);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  List<Datum> menuName = [];
  int _selectedIndex;
  String activeStatus;
  bool _isLoading;

  String url = 'https://www.admin.halfwaiter.com/assets/uploads/menus/';

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => SideMain(
              widget.id,widget.name,widget.onStatus)),
    );
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
          )
        ],
      ),
//      floatingActionButton: new FloatingActionButton(
//          elevation: 0.0,
//          child: new Icon(Icons.add),
//          backgroundColor: new Color(0xFFE57373),
//          onPressed: (){
//            Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => AddMenu(
//                      widget.id,widget.name,widget.onStatus)),
//            );
////            AddMenu(widget.id,widget.name,widget.onStatus);
//          }
//      ),
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
                            child: Text('Menu List',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.deepOrangeAccent,
                              child: IconButton(
                                splashColor: Colors.blue,
                                icon: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                tooltip: "Add Menu",
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddMenu(
                                            widget.id,widget.name,widget.onStatus)),
                                  );
                                },
                              )),
                        ),
                         InkWell(
                          splashColor: Colors.blue,
                          onTap: (){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SideMain(
                                      widget.id,widget.name,widget.onStatus)),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.deepOrangeAccent,
//                        child: IconButton(
//                          splashColor: Colors.blue,
//                          icon: Icon(
//                            Icons.dashboard,
//                            size: 28,
//                            color: Colors.black,
//                          ),
//                          tooltip: "DashBoard",
//                          onPressed: () {
//                            Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => SideMain(
//                                      widget.id,widget.name,widget.onStatus)),
//                            );
//                          },
//                        )
                            child: Image.asset('assets/images/dashboard.png'),
                          ),
                        ),
                      ],
                    ),
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
                        itemCount: menuName.length,
                        itemBuilder: (BuildContext context, int position) {
                          return getRow(position);
                        }));
              }
            }));
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
      child: ListTile(
        contentPadding:
            EdgeInsets.only(left: 10.0, top: 0, bottom: 0, right: 10.0),
        leading: Container(
            width: 65,
            height: 85,
            child: Image.network(url + menuName[index].photo)),
        title: Text(menuName[index].fullname),
        subtitle: Text(menuName[index].price),
        trailing: menuName[index].status== '1'? CircleAvatar(
            radius: 15,
            backgroundColor: Colors.green,
            child: IconButton(
              splashColor: Colors.blue,
              icon: Icon(
                Icons.check,
                size: 15,
                color: Colors.white ,
              ),
              tooltip: "Active",
              onPressed: () {
                setState(() {
                  activeStatus ='0';
                  postData(menuName[index].menuId,activeStatus);
                });
              },
            )):CircleAvatar(
            radius: 15,
            backgroundColor: Colors.red,
            child: IconButton(
              splashColor: Colors.blue,
              icon: Icon(
                Icons.clear,
                size: 15,
                color: Colors.white,
              ),
              tooltip: "Inactive",
              onPressed: () {
                setState(() {
                  activeStatus ='1';
                  postData(menuName[index].menuId,activeStatus);
                });
              },
            )),
        onTap: () {
//          _onSelected(index);
        },
      ),
    );
  }

  _fetchListItem(userId) async {
//    print("id:"+site);
    String dataURL =
        "https://www.admin.halfwaiter.com/demo/api/request/menuAdmin?id=$userId";
    http.Response response =
        await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});
    menuName.clear();
    for (Datum datum in menuListModelFromJson(response.body).data) {
      menuName.add(datum);
    }
    return menuName;
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0), child: getFirstView());
  }

  void postData( String menuId,String status) async {
    print(menuId);
    print(status);
    Map data = {
      'menu_id': menuId,
      'activeStatus':status,
    };
    var jsonResponse;
    var response = await http.post(
        "https://www.admin.halfwaiter.com/demo/api/request/menuStatus",
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
  }}
