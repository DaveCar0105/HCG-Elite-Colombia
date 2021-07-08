import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_empaque.dart';

class RegistroProcesoEmpaqueBloc{
  static final RegistroProcesoEmpaqueBloc _singleton = new RegistroProcesoEmpaqueBloc._internal();

  factory RegistroProcesoEmpaqueBloc(){
    return _singleton;
  }

  RegistroProcesoEmpaqueBloc._internal(){
    obtenerCountRegistroProcesoEmpaque();
  }

  final _registroProcesoEmpaqueController = StreamController<int>.broadcast();
  AnimationController _animationController;

  Stream<int> registroProcesoEmpaqueStream(){
    obtenerCountRegistroProcesoEmpaque();
    return _registroProcesoEmpaqueController.stream;
  }

  dispose(){
    _registroProcesoEmpaqueController?.close();
  }

  obtenerCountRegistroProcesoEmpaque() async{
    _registroProcesoEmpaqueController.sink.add(await DatabaseProcesoEmpaque.getCountProcesosEmpaque());
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