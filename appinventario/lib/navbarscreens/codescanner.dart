import 'dart:async';
/*import 'package:appinventario/database/dbarticulo.dart';
import 'package:appinventario/database/dbhelper.dart';
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
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
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Lector de codigo',
              ),
              backgroundColor: Colors.indigo,
            ),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        RaisedButton(
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
                        RaisedButton(onPressed: () {
                          createRecord();
                        }),
                        Text('Resultado : $_scanBarcode\n',
                            style: TextStyle(fontSize: 22)),
                      ]));
            })));
  }

  final User user = auth.currentUser;
  void createRecord() async {
    DocumentReference ref = await databaseReference.collection("codigos").add({
      'codigo': _scanBarcode,
      'usuario': user.email,
    });
    // ignore: deprecated_member_use
    print(ref.documentID);
  }
}
