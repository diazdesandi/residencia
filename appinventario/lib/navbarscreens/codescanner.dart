import 'dart:async';
/*import 'package:appinventario/database/dbarticulo.dart';
import 'package:appinventario/database/dbhelper.dart';
*/
import 'package:appinventario/login/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'planos.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

final databaseReference = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class MyScanner extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyScanner> {
  String _scanBarcode = 'Desconocido';

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancelar", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Fallo para obtener la version';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      createRecord();
      /*Articulo e = Articulo(null, barcodeScanRes);
      DBHelper().save(e);*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TopContainer(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                      Row(children: [
                        Text(
                          'Lector de código',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.white),
                        )
                            .alignment(Alignment.topLeft)
                            .padding(top: 60, bottom: 10),
                      ]),
                      Row(
                        children: [
                          Text(
                            user.email,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ).padding(bottom: 30),
                        ],
                      )
                    ])),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      title: Text('Planos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      tileColor: Colors.indigo,
                      subtitle: Column(
                        children: <Widget>[
                          Text('Imagen de los planos de la planta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300)),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: FlatButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Planos()),
                              ),
                              textColor: Colors.indigoAccent,
                              padding: const EdgeInsets.all(5.0),
                              color: Colors.white,
                              /*child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(10.0),*/
                              child: /*const*/ Text('Ver',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      title: Text('Escaner',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      tileColor: Colors.indigo,
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                              'Utiliza la cámara de tu dispositivo para escanear codigo de barras de cada bloque de poliestireno',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300)),
                          FlatButton(
                              textColor: Colors.indigoAccent,
                              padding: const EdgeInsets.all(5.0),
                              color: Colors.white,
                              child: Text('Escanear código',
                                  style: TextStyle(fontSize: 14)),
                              onPressed: () => scanBarcodeNormal())
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      tileColor: Colors.indigo,
                      title: Text('Resultado:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      subtitle: Column(
                        children: <Widget>[
                          Text('$_scanBarcode\n',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ListTile(
                      tileColor: Colors.indigo,
                      title: Text('Cerrar sesión',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                              'Finaliza la sesión de usuario asi como la captura de información',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300)),
                          FlatButton(
                              textColor: Colors.indigoAccent,
                              color: Colors.white,
                              child: Text('Cerrar sesión',
                                  style: TextStyle(fontSize: 14)),
                              onPressed: () => {
                                    context
                                        .read<AuthenticationService>()
                                        .signOut()
                                  })
                        ],
                      ),
                    ),
                  ),
                )
              ]));
    })));
  }

  String codigo;

  getCodigo(codigo) {
    this.codigo = codigo;
  }

  final User user = auth.currentUser;
  void createRecord() async {
    // ignore: unused_local_variable
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection("codigos").document(_scanBarcode);

    // create Map
    Map<String, dynamic> codigos = {
      "codigo": _scanBarcode,
      "usuario": user.email,
    };

    // ignore: deprecated_member_use
    documentReference.setData(codigos).whenComplete(() {
      print("$codigo created");
    });
  }
}

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer({this.height, this.width, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          /*gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),*/
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
