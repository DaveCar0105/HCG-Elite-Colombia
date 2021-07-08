import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';

class RegistroProcesoHidratacionBloc{
  static final RegistroProcesoHidratacionBloc _singleton = new RegistroProcesoHidratacionBloc._internal();

  factory RegistroProcesoHidratacionBloc(){
    return _singleton;
  }

  RegistroProcesoHidratacionBloc._internal(){
    obtenerCountRegistroProcesoHidratacion();
  }

  final _registroProcesoHidratacionController = StreamController<int>.broadcast();
  AnimationController _animationController;

  Stream<int> registroProcesoHidratacionStream(){
    obtenerCountRegistroProcesoHidratacion();
    return _registroProcesoHidratacionController.stream;
  }

  dispose(){
    _registroProcesoHidratacionController?.close();
  }

  obtenerCountRegistroProcesoHidratacion() async{
    _registroProcesoHidratacionController.sink.add(await DatabaseProcesoHidratacion.getCountProcesosHidratacion());
  }

  itemAgregado(){
    try{
      _animationController.forward(from:0.0);
    }catch(e){

    }
  }

  set bounceController(AnimationController controller){
    this._animationController = controller;
  }
}