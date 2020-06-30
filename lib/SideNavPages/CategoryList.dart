import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/Model_Classes/CategoryListModel.dart';
import 'package:http/http.dart' as http;
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';

import '../MainSideNav.dart';
import 'AddCategory.dart';

class CategoryList extends StatefulWidget with NavigationStates {
  final String id,name,onStatus;

  CategoryList(this.id, this.name,this.onStatus);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Datum> categoryName = [];
  int _selectedIndex ;


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

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> getscroolView() async{

    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));


    setState(() {
      getCard(context);
    });

    return null;

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
            child: RefreshIndicator(child: getCard(context),onRefresh: getscroolView,)
          ),

        ],
      ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: Color.fromRGBO(59, 128, 198, 1),
            onPressed: (){
              _showDialogCategory(widget.id);
            }
        ),
    );

  }

  Widget _showDialogCategory(uid) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: AlertDialog(
            title: Center(
              child: Text(
                "Add Category",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            content: AddCategory(uid),
          ),
        );
      },
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
                        child: Center(child: Text('Category List',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
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
                return  Container(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 6),
                        itemCount: categoryName.length,
                        itemBuilder: (BuildContext context, int position) {
                          return getRow(position);
                        }));
              }
            })
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
      child: ListTile(
        contentPadding: EdgeInsets.only(left : 10.0,top: 0,bottom: 0,right: 10.0),
        title: Text("${index+1}. "+ categoryName[index].categoryname),
        subtitle: Text("     "+categoryName[index].parentCat),
        onTap: () {

//          _onSelected(index);
        },
      ),
    );
  }

  _fetchListItem(userId) async {
    String dataURL = "https://www.admin.halfwaiter.com/api/request/menuCategory?user_id=$userId";
    http.Response response = await http.get(dataURL,headers: {"x-api-key": r"Eprim@Res!"});
    categoryName.clear();
    for (Datum  datum  in categoryListModelFromJson(response.body).data) {

      categoryName.add(datum);
    }
    return categoryName;
  }

  Widget getElementList() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: getFirstView()
    );
  }
}

