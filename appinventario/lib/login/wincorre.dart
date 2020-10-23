import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Widcorre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 1),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Correo electrónico",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(28),
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent))),
              TextField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              )
            ]));
  }
}

class Widcorredos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 300,
        padding: EdgeInsets.only(left: 55.0, right: 0.0, top: 370.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Correo electrónico",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(26),
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent))),
              TextField(
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              )
            ]));
  }
}
