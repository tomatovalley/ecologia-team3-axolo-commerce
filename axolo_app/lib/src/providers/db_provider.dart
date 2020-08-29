import 'dart:io';

import 'package:axolo_app/src/models/scan_model.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

export 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'coleccion.db');
    return await openDatabase(
      path,
      version: 3,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Coleccion('
            'uuid TEXT PRIMARY KEY,'
            'fecha DATE'
            'producto TEXT,'
            'descripcion TEXT,'
            'imagen TEXT'
            ')');
      },
    );
  }

  // Crear registros base de datos
  nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatedDate = formatter.format(now);
    final res = await db.rawInsert(
        "INSERT INTO Coleccion(uuid, fecha, producto, descripcion, imagen) "
        "VALUES ('${nuevoScan.uuid}', '${formatedDate}', '${nuevoScan.producto}', '${nuevoScan.descripcion}', '${nuevoScan.imagen}')");
    return res;
  }

  /*nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Coleccion', nuevoScan.toJson());
    return res;
  }*/

  // SELECT - Obtener información
  Future<ScanModel> getScanUUID(String uuid) async {
    final db = await database;
    final res =
        await db.query('Coleccion', where: 'uuid = ?', whereArgs: [uuid]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final res = await db.query('Coleccion');
    List<ScanModel> list = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
    return list;
  }

  // Actualizar registros
  updateScan(ScanModel model) async {
    final db = await database;
    final res = await db.update('Coleccion', model.toJson(),
        where: 'uuid = ?', whereArgs: [model.uuid]);
    return res;
  }

  // Borrar registros
  Future<int> deleteScan(String uuid) async {
    final db = await database;
    final res =
        await db.delete('Coleccion', where: 'uuid = ?', whereArgs: [uuid]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Coleccion');
    return res;
  }
}
