import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';

import '../MainSideNav.dart';
import 'FormCardMenu.dart';



class AddMenu extends StatefulWidget {
  final String id,name,onStatus;

  AddMenu(this.id,this.name,this.onStatus);

  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
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
      Fluttertoast.showToast(
        msg: "Press Dashboard Button At Top Right",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueAccent,
        timeInSecForIos: 1,
        textColor: Colors.white,
      ); // Do some stuff.
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
            child: getBody(),
          )
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
                            child: Text('Add Menu',
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
                          splashColor: Colors.red,
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
  Widget getBody() {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: <Widget>[
            FormCardMenu(widget.id,widget.name,widget.onStatus),
          ],
        ),
      ),
    );
  }
}
