import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final AssetImage image;
  final String title;
  final Function onTap;
  final Color color;

  const MenuItem({Key key, this.image, this.title, this.onTap,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          color: color,
          height: 50,
          child: FlatButton(
            splashColor: Colors.blueAccent,
            onPressed: onTap,
            child: Row(
              children: <Widget>[
                Container(
                  height: 30,
                  width: 30,
                  child: Image(
                   image: image,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}