import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/Dashboard/Dashboard.dart';
import 'package:halfwaiteradminapp/MainSideNav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Formcard.dart';



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {


  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: WillPopScope(
        child: getmainContent(),onWillPop: onWillPop,
      ),
    );
  }
  Widget getmainContent(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
//        FadeAnimation(
//          3.0,
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.end,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(bottom: 2.0),
//                child: ClipPath(
//                  clipper: ClippingClass(),
//                  child: Container(
//                    width: MediaQuery.of(context).size.width,
//                    height: 320.0,
//                    color: Colors.deepOrangeAccent,
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25),
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/e.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 25.0),
                child: FormCard(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      exit(0);
      return Future.value(false);
    }
    return Future.value(true);

  }
}

//class ClippingClass extends CustomClipper<Path> {
//  @override
//  Path getClip(Size size) {
//    var path = Path();
//    path.lineTo(0.0, size.height - 40);
//    path.quadraticBezierTo(
//        size.width / 4, size.height, size.width / 2, size.height);
//    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
//        size.width, size.height - 40);
//    path.lineTo(size.width, 0.0);
//    path.close();
//    return path;
//  }
//
//  @override
//  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
//}
