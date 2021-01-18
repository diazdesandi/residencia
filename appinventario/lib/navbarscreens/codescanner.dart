import 'dart:async';
/*import 'package:appinventario/database/dbarticulo.dart';
import 'package:appinventario/database/dbhelper.dart';
*/
import 'package:appinventario/login/auth.dart';
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
// final UserModel user;

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
                      Row(children: [
                        if (user.displayName != null) ...[
                          Text(user.displayName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.white))
                              .padding(top: 10, bottom: 10),
                        ]
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
                FlatButton(
                    child: const Text('Mostrar plano'),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Planos()),
                        )),
                FlatButton(
                  child: const Text('Cerrar sesion'),
                  onPressed: () => {
                    context.read<AuthenticationService>().signOut(),
                  },
                ),
                const SizedBox(height: 30),
                FlatButton(
                  onPressed: () => scanBarcodeNormal(),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Escanear codigo de barras',
                        style: TextStyle(fontSize: 24)),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Resultado : $_scanBarcode\n',
                        style: TextStyle(fontSize: 22))),
              ]));
    })));
  }

  final User user = auth.currentUser;
  void createRecord() async {
    DocumentReference ref = await databaseReference.collection("codigos").add({
      'codigo': _scanBarcode,
      'usuario': user.email,
      'nombre': user.displayName
    });
    // ignore: deprecated_member_use
    print(ref.documentID);
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
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
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
