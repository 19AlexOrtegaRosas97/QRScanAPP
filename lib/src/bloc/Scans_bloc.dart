import 'dart:async';

import 'package:qrapp/src/bloc/validator.dart';
import 'package:qrapp/src/models/scan_model.dart';
import 'package:qrapp/src/providers/db_provider.dart';

class ScansBloc with Validators{

  //Patron Singleton una sola instancia
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //Obtener Scans de la BD
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  //Cerrar instancias STREAM
  dispose(){
    _scansController?.close();
  }

  obtenerScans()async{
    _scansController.sink.add( await DBProvider.db.getTodosScans());
  }

  borrarScan(int id)async{
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTodos()async{
    await DBProvider.db.deleteAllScan();
    obtenerScans();
  }

  agregarScan(ScanModel scan)async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }
  
}