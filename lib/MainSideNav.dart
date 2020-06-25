import 'package:flutter/material.dart';

import 'SidebarItems/SidebarLayout.dart';

class SideMain extends StatefulWidget {

  final id,name,onStatus;

  SideMain(this.id, this.name,this.onStatus);

  @override
  _SideMainState createState() => _SideMainState();
}

class _SideMainState extends State<SideMain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white
      ),
      home: SideBarLayout(widget.id,widget.name,widget.onStatus),
    );
  }
}
