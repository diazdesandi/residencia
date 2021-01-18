import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'package:styled_widget/styled_widget.dart';

class Registrar extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 190, 50, 0),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text("Registro",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ))).padding(horizontal: 0, vertical: 20),
                  Text("Correo electrónico",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo))),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 13.0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Contraseña",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo))),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 13.0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                      child: FlatButton(
                        textColor: Colors.white,
                        color: Colors.indigo,
                        child: Text('Registrar'),
                        onPressed: () {
                          context.read<AuthenticationService>().signUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                      ))
                ])),
          ),
        ])),
      ]),
    );
  }
}
