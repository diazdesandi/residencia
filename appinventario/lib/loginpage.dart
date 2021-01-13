import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login/auth.dart';
import 'login/respass.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 50.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(230),
              ),
              Container(
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
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Inicio de sesión",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(45),
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff515c6f),
                                        letterSpacing: .6))),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Correo electrónico",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(28),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo))),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text("Contraseña",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(28),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo))),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                      textColor: const Color(0xff515c6f),
                                      color: Colors.transparent,
                                      child: Text('¿Olvidaste tu contraseña?'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Recontra()),
                                        );
                                      })
                                ])
                          ]))),
              SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 12.0,
                      ),
                      /* GestureDetector(
                        onTap: _radio,
                        child: radioButton(_isSelected),
                      ),*/
                      SizedBox(
                        width: 8.0,
                      ),
                      Text("Recordar datos",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                  fontWeight: FontWeight.bold)))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        textColor: Colors.white,
                        color: Colors.indigo,
                        child: Text('Iniciar sesión'),
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                ],
              ),
            ]),
          ))
        ],
      ),
    );
  }
}

// Boton de opcion con cierto tamaño (width y height) y cierto margen (padding)
Widget radioButton(bool isSelected) => Container(
      width: 16.0,
      height: 16.0,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black)),
      child: isSelected
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            )
          : Container(),
    );

Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(120),
        height: 1.0,
        color: Colors.black26.withOpacity(.2),
      ),
    );
