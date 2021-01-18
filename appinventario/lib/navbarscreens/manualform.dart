import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appinventario/database/dbhelper.dart';
import 'package:appinventario/database/dbarticulo.dart';
import 'codescanner.dart';
import 'package:styled_widget/styled_widget.dart';

class DBTestPage extends StatefulWidget {
  final String title;

  DBTestPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DBTestPageState();
  }
}

class _DBTestPageState extends State<DBTestPage> {
  Future<List<Articulo>> articulos;
  TextEditingController controller = TextEditingController();
  String codigo;
  int curUserId;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    databaseReference
        .collection("codigos")
        // ignore: deprecated_member_use
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      // ignore: deprecated_member_use
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
    /*setState(() {
      articulos = dbHelper.getArticulos();
    });*/
  }

  clearName() {
    controller.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Articulo e = Articulo(curUserId, codigo);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        Articulo e = Articulo(null, codigo);
        dbHelper.save(e);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Codigo'),
              validator: (val) => val.length == 0 ? 'Ingresar codigo' : null,
              onSaved: (val) => codigo = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'Actualizar' : 'Agregar'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('Cancelar'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<Articulo> articulos) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('CODIGO'),
          ),
          DataColumn(
            label: Text('ELIMINAR'),
          )
        ],
        rows: articulos
            .map(
              (articulo) => DataRow(cells: [
                DataCell(
                  Text(articulo.codigo),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curUserId = articulo.id;
                    });
                    controller.text = articulo.codigo;
                  },
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    dbHelper.delete(articulo.id);
                    refreshList();
                  },
                )),
              ]),
            )
            .toList(),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: articulos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No hay datos");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Text(
              'Registro',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            )
                .padding(top: 60, bottom: 10, horizontal: 20)
                .alignment(Alignment.topLeft),
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
