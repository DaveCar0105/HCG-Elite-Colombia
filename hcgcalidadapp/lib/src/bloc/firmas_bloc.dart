import 'dart:async';

import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';

class FirmasBloc{
  static final FirmasBloc _singleton = new FirmasBloc._internal();

  factory FirmasBloc(){
    return _singleton;
  }

  FirmasBloc._internal(){
    obtenerFirmas();
  }

  final _firmasController = StreamController<List<Firma>>.broadcast();

  Stream<List<Firma>> firmasStream(){
    obtenerFirmas();
    return _firmasController.stream;
  }

  dispose(){
    _firmasController?.close();
  }

  obtenerFirmas() async{
    _firmasController.sink.add(await DatabaseFirma.consultarFirmas());
  }

}