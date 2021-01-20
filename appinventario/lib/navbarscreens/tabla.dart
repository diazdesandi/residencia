import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String codigo, usuario;

  getStudentName(codigo) {
    this.codigo = codigo;
  }

  getStudentID(usuario) {
    this.usuario = usuario;
  }

  createData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document();

    // create Map
    Map<String, dynamic> codigos = {
      "codigo": codigo,
      "usuario": usuario,
    };

    // ignore: deprecated_member_use
    documentReference.setData(codigos).whenComplete(() {
      print("$codigo created");
    });
  }

  readData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document();

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
    Map<String, dynamic> students = {
      "codigo": codigo,
      "usuario": usuario,
    };

    // ignore: deprecated_member_use
    documentReference.setData(students).whenComplete(() {
      print("$codigo updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("MyStudents").document();

    documentReference.delete().whenComplete(() {
      print("$codigo deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Registro',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            )
                .padding(top: 60, bottom: 10, horizontal: 20)
                .alignment(Alignment.topLeft),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  getStudentID(id);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Create"),
                  textColor: Colors.white,
                  onPressed: () {
                    createData();
                  },
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Read"),
                  textColor: Colors.white,
                  onPressed: () {
                    readData();
                  },
                ),
                RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Update"),
                  textColor: Colors.white,
                  onPressed: () {
                    updateData();
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Delete"),
                  textColor: Colors.white,
                  onPressed: () {
                    deleteData();
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: Text("Name"),
                  ),
                  Expanded(
                    child: Text("Student ID"),
                  ),
                  Expanded(
                    child: Text("Program ID"),
                  ),
                  Expanded(
                    child: Text("GPA"),
                  )
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
                              child: Text(documentSnapshot["codigo"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["usuario"]),
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
      ),
    );
  }
}
