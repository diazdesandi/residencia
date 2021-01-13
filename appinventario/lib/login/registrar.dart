import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Registrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        height: 300,
        padding: EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Registro",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(45),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff515c6f),
                              letterSpacing: .6))),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Text("Contraseña",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent))),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(35),
                  ),
                ])));
  }
}
