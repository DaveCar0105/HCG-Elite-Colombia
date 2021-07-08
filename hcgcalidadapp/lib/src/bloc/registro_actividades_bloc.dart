import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:hcgcalidadapp/src/basedatos/database_actividad.dart';

class RegistroActividadBloc{
  static final RegistroActividadBloc _singleton = new RegistroActividadBloc._internal();

  factory RegistroActividadBloc(){
    return _singleton;
  }

  RegistroActividadBloc._internal(){
    obtenerCountRegistroActividad();
  }

  final _registroActividadController = StreamController<int>.broadcast();
  AnimationController _animationController;

  Stream<int> registroActividadStream(){
    obtenerCountRegistroActividad();
    return _registroActividadController.stream;
  }

  dispose(){
    _registroActividadController?.close();
  }

  obtenerCountRegistroActividad() async{
    _registroActividadController.sink.add(await DatabaseActividad.getCountActividades());
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