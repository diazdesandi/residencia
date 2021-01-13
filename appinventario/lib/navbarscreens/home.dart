import 'package:appinventario/login/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserPage(),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Cerrar sesion"),
            ),
          ],
        ),
      ),
    ));
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Padding para el contenedor de la informacion
    final page = ({Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: 50)
        .scrollable();

    return <Widget>[
      Text(
        'Menú',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ).alignment(Alignment.topLeft).padding(top: 20, bottom: 20),
      UserCard(),
    ].toColumn().parent(page);
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

class UserCard extends StatelessWidget {
  final User user = auth.currentUser;
  Widget _buildUserRow() {
    return <Widget>[
      // Icono que reemplaza la imagen de perfil, para establecer dicha imagen seria necesario
      // establecer el backend en Firebase
      Icon(Icons.account_circle)
          .decorated(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          )
          .constrained(height: 50, width: 50)
          .padding(right: 10),
      <Widget>[
        // Nombre del usuario que inicio sesion
        Text(
          user.email,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 5),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  // Widget donde se establece el color y la forma de los bordes donde se muestra la informacion de usuario
  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 10, vertical: 10)
        .decorated(
            color: Colors.indigo, borderRadius: BorderRadius.circular(10))
        .elevation(
          1,
          shadowColor: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        )
        .height(80)
        .alignment(Alignment.center);
  }
}
