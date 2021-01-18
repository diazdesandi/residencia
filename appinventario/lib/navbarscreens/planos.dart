import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Planos extends StatelessWidget {
  //_MyAppState createState() => new _MyAppState();
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plano del area de bahias'),
            backgroundColor: Colors.transparent,
          ),
          body: PhotoView(
            imageProvider: AssetImage("lib/assets/planos.png"),
          )),
    );
  }
}
