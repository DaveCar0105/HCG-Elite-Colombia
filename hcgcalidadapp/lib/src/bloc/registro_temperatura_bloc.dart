import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:hcgcalidadapp/src/basedatos/database_temperatura.dart';

class RegistroTemperaturaBloc{
  static final RegistroTemperaturaBloc _singleton = new RegistroTemperaturaBloc._internal();

  factory RegistroTemperaturaBloc(){
    return _singleton;
  }

  RegistroTemperaturaBloc._internal(){
    obtenerCountRegistroTemperatura();
  }

  final _registroTemperaturaController = StreamController<int>.broadcast();
  AnimationController _animationController;

  Stream<int> registroTemperaturaStream(){
    obtenerCountRegistroTemperatura();
    return _registroTemperaturaController.stream;
  }

  dispose(){
    _registroTemperaturaController?.close();
  }

  obtenerCountRegistroTemperatura() async{
    _registroTemperaturaController.sink.add(await DatabaseTemperatura.getCountTemperaturas());
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