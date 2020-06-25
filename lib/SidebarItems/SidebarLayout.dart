import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_bloc.dart';
import 'sidebar.dart';

class SideBarLayout extends StatefulWidget {
  final id,name,onStatus;

  SideBarLayout(this.id, this.name,this.onStatus);

  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(widget.id,widget.name,widget.onStatus),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(widget.id,widget.name,widget.onStatus),
          ],
        ),
      ),
    );
  }
}


