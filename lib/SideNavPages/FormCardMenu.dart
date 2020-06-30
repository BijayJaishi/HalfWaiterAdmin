import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:halfwaiteradminapp/MainSideNav.dart';
import 'package:halfwaiteradminapp/SidebarItems/navigation_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class FormCardMenu extends StatefulWidget {
  final String id,name,onStatus ;

  FormCardMenu(this.id,this.name,this.onStatus);

  @override
  _FormCardMenuState createState() => _FormCardMenuState();
}

class _FormCardMenuState extends State<FormCardMenu> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String mName;
  String mPhotoName;
  String mCatIdInitial;
  String mCatIdFinal;
  String mPrice;
  String mDiscountPrice;
  String mDesc;
  DateTime _dateTime = DateTime.now();
  DateTime now = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');


  bool _isLoading;

  String fileName;
  var imageFile;

  // ignore: non_constant_identifier_names
  List CategoryList = List();

  Future<String> getCategory(userId) async {
    String dataURL =
        "https://www.admin.halfwaiter.com/api/request/dropMenuCategory?user_id=$userId";
    http.Response res =
    await http.get(dataURL, headers: {"x-api-key": r"Eprim@Res!"});

    var resBody = json.decode(res.body);

    setState(() {
      CategoryList = resBody;
    });

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCategory(widget.id);
  }

  Future<void> pickImage(ImageSource imageSource) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: imageSource,imageQuality: 70);
//    compressFormatName(ImageCompressFormat.jpg);
    setState(() {
      imageFile = selected;
    });
  }

  void _clear() {
    setState(() => imageFile = null);
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
      'Adding Menu ',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),

    );

    return new Container(
      child: new Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: formUI(),
      ),
    );
  }

  Widget formUI() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: new Container(
          width: double.infinity,
//          height: MediaQuery.of(context).size.height,
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
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text("Add New Menu",
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(45),
                          fontFamily: "Poppins-Bold",
                          letterSpacing: .6)),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(15),
                ),
                Text("Menu Name",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,width: 2.3),
                      ),
                      hintText: "Menu Name",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  validator: validateMenuName,
                  onSaved: (String val) {
                    mName = val;
                  },
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),

//                Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Icon(Icons.date_range),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 4.0),
//                      child: Text("Bill Date",
//                          style: TextStyle(
//                              fontFamily: "Poppins-Medium",
//                              fontSize: ScreenUtil.getInstance().setSp(26))),
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: ScreenUtil.getInstance().setHeight(10),
//                ),
//                Card(
//                  color: Colors.white70,
//                  child: FlatButton(
//                    onPressed: () {
//                      showDatePicker(
//                          context: context,
//                          initialDate:
//                          _dateTime == null ? DateTime.now() : _dateTime,
//                          firstDate: DateTime(2001),
//                          lastDate: DateTime(2021))
//                          .then((date) {
//                        setState(() {
//                          _dateTime = date;
//                        });
//                      });
//                    },
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text(_dateTime == null
//                            ? myFormat.format(now)
//                            : myFormat.format(_dateTime)),
//                        Icon(Icons.arrow_drop_down),
//                      ],
//                    ),
//                  ),
//                ),
                Text("Category",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                DropdownButtonFormField(
                  hint: Text("Select Category"),
                  items: CategoryList.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item['categoryname']),
                      value: item['mcate_id'].toString(),
                    );
                  }).toList(),
                  validator: validateCategory,
                  onSaved: (value) {
                    setState(() {
                      mCatIdInitial = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      mCatIdInitial = value;
                    });
                  },
                  value: mCatIdInitial,
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                Text("Price",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,width: 2.3),
                      ),
                      hintText: "Price",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  keyboardType: TextInputType.number,
                  maxLength: 30,
                  validator: validatePrice,
                  onSaved: (String val) {
                    mPrice = val;
                  },
                ),

                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),

                Text("Discount",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,width: 2.3),
                      ),
                      hintText: "Discount",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  keyboardType: TextInputType.number,
                  maxLength: 30,
                  validator: validateDiscount,
                  onSaved: (String val) {
                    mDiscountPrice = val;
                  },
                ),

                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),

                Text("Description",
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26))),
                TextFormField(
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,width: 2.3),
                      ),
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  validator: validateDescription,
                  onSaved: (String val) {
                    mDesc = val;
                  },
                ),

                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(20),
                ),
                Center(
                  child: Text("Upload Photo",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: ScreenUtil.getInstance().setSp(26))),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(15),
                ),
                Center(child: getPhotolist()),
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

//                        Navigator.pop(context,
//                            true); // It worked for me instead of above line
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => Dashboardd()),
//                        );
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
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateMenuName(String value) {
    if (value.trim().length < 1) return 'Enter Menu Name';
    return null;
  }
  String validatePrice(String value) {
    if (value.trim().length < 1) return 'Enter Price';
    return null;
  }
  String validateDiscount(String value) {
    if (value.trim().length < 1) return 'Enter Discount';
    return null;
  }
  String validateDescription(String value) {
    if (value.trim().length < 1) return 'Enter Description';
    return null;
  }

  String validateCategory(String value) {
    if (value == null) return 'Please Select Category';
    return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();

      setState(() {
        mCatIdFinal = mCatIdInitial;
      });

      showDialogAlert(context);
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void postData(String menuName, String userId,String catId, File image, String price,String dPrice,String desc
      ) async {
    if (image != null) {
      String fileName = image.path.split('/').last;
      Dio dio = new Dio();
      FormData formData = new FormData(); // just like JS
      formData.add("mpic", new UploadFileInfo(image, fileName));
      formData.add("user_id", userId);
      formData.add("menuname", menuName);
      formData.add("catId", catId);
      formData.add("price", price);
      formData.add("dprice", dPrice);
      formData.add("desc", desc);
      dio
          .post("https://www.admin.halfwaiter.com/api/request/addMenu",
          data: formData,
          options: Options(
              method: 'POST',
              headers: {
                "x-api-key": r"Eprim@Res!",
                "Content-Type": "multipart/form-data"
              },
              responseType: ResponseType.json // or ResponseType.JSON
          ))
          .then((r) {
        setState(() {
          var data = r.data;
//          print('responseResult : $data');
          if (data != null) {
            if(pr.isShowing()){
              pr.hide().then((isHidden){

                Fluttertoast.showToast(
                    msg: "Menu Added Successfully.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.blueAccent,
                    timeInSecForIos: 1);

                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context).pop(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SideMain(
                          widget.id,widget.name,widget.onStatus)),
                );
              });
            }

          } else {
            if(pr.isShowing()){
              pr.hide().then((isHidden) {
                Fluttertoast.showToast(
                    msg: "Failed to add Menu",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.blueAccent,
                    timeInSecForIos: 1);
              });
            }
          }
        });
      });
    }
  }

  Widget getPhotolist() {
    return Container(
      height: 250,
      child: imageFile == null
          ? Center(
        child: Card(
            child: Container(
              width: double.infinity,
              child: Center(
                child: GestureDetector(
                  onTap: () => _showDialog(),
                  child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 50,
                      child: Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.black,
                      )),
                ),
              ),
            )),
      )
          : Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
//                              border: Border.all(width : 10.0,color: Colors.transparent),
            borderRadius: BorderRadius.circular(0.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(80, 0, 0, 0),
                  blurRadius: 5.0,
                  offset: Offset(5.0, 5.0))
            ],
            image: DecorationImage(
                fit: BoxFit.cover, image: FileImage(imageFile))),
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.only(top: 5.0, right: 5),
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => _clear(),
            child: CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.clear,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Visibility(
          child: AlertDialog(
            title: new Text("Choose Image Source"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.teal,
                  child: InkWell(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(150),
                      height: ScreenUtil.getInstance().setHeight(70),
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
                            pickImage(ImageSource.camera);
                            Navigator.of(context).pop(false);
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Center(
                              child: Text("Camera",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 12,
                                  )),
                            ),
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
                      width: ScreenUtil.getInstance().setWidth(150),
                      height: ScreenUtil.getInstance().setHeight(70),
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
                            pickImage(ImageSource.gallery);
                            Navigator.of(context).pop(false);
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Center(
                              child: Text("Gallery",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 12,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*Navigator.of(context).pop(true)*/
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  showDialogAlert(context) {
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
                    onTap: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      pr.show();
                      postData(mName,widget.id,mCatIdFinal,imageFile,mPrice,mDiscountPrice,mDesc);
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
