import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';
import 'codescanner.dart';

final User user = auth.currentUser;

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String codigo;
  final TextEditingController codigoController = TextEditingController();

  getCodigo(codigo) {
    this.codigo = codigo;
  }

  createData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document();

    // create Map
    Map<String, dynamic> codigos = {
      "codigo": codigo,
      "usuario": user.email,
    };

    // ignore: deprecated_member_use
    documentReference.setData(codigos).whenComplete(() {
      print("$codigo created");
    });
  }

  readData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document(codigo);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data()["codigo"]);
      print(datasnapshot.data()["usuario"]);
    });
  }

  updateData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document();

    // create Map
    Map<String, dynamic> codigos = {
      "codigo": codigo,
      "usuario": user.email,
    };

    // ignore: deprecated_member_use
    documentReference.setData(codigos).whenComplete(() {
      print("$codigo updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document(codigo);

    documentReference.delete().whenComplete(() {
      print("$codigo deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            'Registro',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          )
              .padding(top: 60, bottom: 10, horizontal: 20)
              .alignment(Alignment.topLeft),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text("Código",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo)))
                .padding(top: 10, bottom: 5, horizontal: 20)
                .alignment(Alignment.topLeft),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19),
            child: TextField(
              controller: codigoController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
              onChanged: (String codigo) {
                getCodigo(codigo);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                color: Colors.white,
                child: Text("Agregar"),
                textColor: Colors.black,
                onPressed: () {
                  createData();
                },
              ),
              FlatButton(
                color: Colors.white,
                child: Text("Leer"),
                textColor: Colors.black,
                onPressed: () {
                  readData();
                },
              ),
              FlatButton(
                color: Colors.white,
                child: Text("Actualizar"),
                textColor: Colors.black,
                onPressed: () {
                  updateData();
                },
              ),
              FlatButton(
                color: Colors.white,
                child: Text("Eliminar"),
                textColor: Colors.black,
                onPressed: () {
                  deleteData();
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Código",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Usuario",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            // ignore: deprecated_member_use
            stream: Firestore.instance.collection("codigos").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[index];
                      return Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 0, 5),
                            child: Text(documentSnapshot["codigo"]),
                          )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 30, 5),
                              child: Text(documentSnapshot["usuario"]),
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
