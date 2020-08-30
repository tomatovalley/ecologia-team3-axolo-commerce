import 'dart:async';

import 'package:axolo_app/src/models/scan_model.dart';
import 'package:axolo_app/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener los Scans de la base de datos
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();
  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBProvider.db.getScans());
  }

  agregarScan(ScanModel scanModel) async {
    DBProvider.db.nuevoScan(scanModel);
    obtenerScans();
  }

  borrarScan(String uuid) async {
    await DBProvider.db.deleteScan(uuid);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    _scansController.sink.add([]);
    // o también
    // obtenerScans();
  }
}
