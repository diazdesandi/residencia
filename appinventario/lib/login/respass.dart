import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
//flutter_screenuitl >= 1.2

class Recontra extends StatelessWidget {
  Recontra({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(140.0, 500.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: Text(
                'Enviar',
                style: GoogleFonts.poppins(
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Widcorredos(),
          Transform.translate(
            offset: Offset(40, 283.35),
            child: SizedBox(
              width: 280.0,
              height: 80.0,
              child: SingleChildScrollView(
                  child: Text(
                'Introduzca la dirección de correo electrónico que \nutilizó para crear su cuenta y le enviaremos por \ncorreo electrónico un enlace para restablecer su \ncontraseña',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: const Color(0xff515c6f),
                  height: 1.6363636363636365,
                ),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          Transform.translate(
            offset: Offset(33.0, 213.0),
            child: Text(
              'Reestablecer contraseña',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                color: const Color(0xff515c6f),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
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
