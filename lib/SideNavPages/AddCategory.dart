import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class AddCategory extends StatefulWidget {
  final id;

  AddCategory(this.id);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _categoryName;

  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  bool _isLoading;

  String _parentcategoryinitial;
  String _parentCategoryfinal;

  List parentCategoryList = List();

  Future<String> getParentCategory() async {
    String dataURL =
        "https://www.admin.halfwaiter.com/api/request/parentCategory";
    http.Response res =
    await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});

    var resBody = json.decode(res.body);

    setState(() {
      parentCategoryList = resBody;
    });

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getParentCategory();
  }
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: true,
    );
    pr.style(
      message:
      'Adding Category ',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),

    );
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return new Container(
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: formUI(formattedDate),
      ),
    );
  }

  Widget formUI(String currentDate) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Wrap(
        children: <Widget>[
          SingleChildScrollView(
            child: new Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Parent Category",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  DropdownButtonFormField(
                    hint: Text("Select Parent Category"),
                    items: parentCategoryList.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    validator: validateparentCategory,
                    onSaved: (value) {
                      setState(() {
                        _parentcategoryinitial = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _parentcategoryinitial = value;
                      });
                    },
                    value: _parentcategoryinitial,
                  ),
                  SizedBox(height: 15,),
                  Text("Category Name",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Category Name",
                        hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 12.0)),
                    keyboardType: TextInputType.text,
                    maxLength: 30,
                    validator: validateCategory,
                    onSaved: (String val) {
                      _categoryName = val;
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(35),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(235),
                        height: ScreenUtil.getInstance().setHeight(80),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(.3),
                                  offset: Offset(5.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
//
                              setState(() {
                                _isLoading = true;
                              });
                              _validateInputs();
                            },
                            child: Center(
                              child: Text("Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 16,
                                      letterSpacing: 1.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String validateCategory(String value) {
    if (value.length == null || value.trim() == '')
      return 'Enter Category Name';
    return null;
  }

  String validateparentCategory(String value) {
    if (value == null) return 'Please Select Parent Category';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        _parentCategoryfinal = _parentcategoryinitial;
//      _parentCategoryfinal = '1';
      });


      showDialogAlert();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData( String name,String parentId,String uId) async {
    Map data = {
      'name': name,
      'pId':parentId,
      'user_id':uId,

    };
    var jsonResponse;
    var response = await http.post(
        "https://www.admin.halfwaiter.com/api/request/addCategory",
        headers: {"x-api-key": r"Eprim@Res!"},
        body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        if(pr.isShowing()){
          pr.hide().then((isHidden){

            Fluttertoast.showToast(
                msg: "Category Added Successfully.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.blueAccent,
                timeInSecForIos: 1);

            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop(false);
            setState(() {
              _isLoading = false;
            });
          });
        }
      } else {
        if(pr.isShowing()){

          pr.hide().then((isHidden) {
            Fluttertoast.showToast(
                msg: "Failed to add Category",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.blueAccent,
                timeInSecForIos: 1);
          });
        }

      }
    } else {
      setState(() {
        _isLoading = false;
      });
//      print(response.body);
    }
  }

  showDialogAlert() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to Submit'),
        actions: <Widget>[
          FlatButton(
            splashColor: Colors.teal,
            child: InkWell(
              child: Container(
                width: ScreenUtil.getInstance().setWidth(120),
                height: ScreenUtil.getInstance().setHeight(50),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.of(context).pop(false);
                    },
                    child: Center(
                      child: Text("No",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 12,
                              letterSpacing: 1.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            splashColor: Colors.teal,
            child: InkWell(
              child: Container(
                width: ScreenUtil.getInstance().setWidth(120),
                height: ScreenUtil.getInstance().setHeight(50),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.black, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
//                      FocusScope.of(context).requestFocus(FocusNode());
                      pr.show();
                      postData(_categoryName,_parentCategoryfinal,widget.id);
//                      Navigator.of(context).pop(false);
                    },
                    child: Center(
                      child: Text("Yes",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 12,
                              letterSpacing: 1.0)),
                    ),
                  ),
                ),
              ),
            ),
            /*Navigator.of(context).pop(true)*/
          ),
        ],
      ),
    ) ??
        false;
  }

}


