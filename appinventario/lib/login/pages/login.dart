import 'package:appinventario/login/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import 'registrar.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 180, 50, 0),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Iniciar sesion",
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
                      height: 15,
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
                      height: 15,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      FlatButton(
                          child: Text('Presiona aqui para registrarte',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.6)),
                          textColor: Colors.black,
                          color: Colors.transparent,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registrar())))
                    ])
                  ]),
            ),
          )
        ])),
      ]),
    );
  }
}
