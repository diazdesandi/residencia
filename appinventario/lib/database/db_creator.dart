import 'dart:async';
import 'dart:io' as io;
import 'package:appinventario/database/dbhelper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dbhelper.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String CODIGO = 'codigo';
  static const String TABLE = 'Articulos';
  static const String DB_NAME = 'dbart1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $CODIGO TEXT)");
  }

  Future<Articulo> save(Articulo articulo) async {
    var dbClient = await db;
    articulo.id = await dbClient.insert(TABLE, articulo.toMap());
    return articulo;
  }

  Future<List<Articulo>> getArticulos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, CODIGO]);
    List<Articulo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Articulo.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Articulo employee) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, employee.toMap(),
        where: '$ID = ?', whereArgs: [employee.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
