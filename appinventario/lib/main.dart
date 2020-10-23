import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login/logincard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navbarscreens/navbarmaster.dart';

// Parte inicial de la aplicacion, se inicializa el login
void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

// Estado del widget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
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
// Widget principal para construir la interfaz, donde se pone el titulo de "Iniciar sesion"
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
              FormCard(),
              SizedBox(height: ScreenUtil.getInstance().setHeight(60)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 12.0,
                      ),
                      GestureDetector(
                        onTap: _radio,
                        child: radioButton(_isSelected),
                      ),
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
                          color: Colors.redAccent,
                          child: Text('Iniciar sesión'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()));
                          }),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
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
