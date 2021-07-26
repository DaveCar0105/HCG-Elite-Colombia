import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
//import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';

class RegistroProcesoMaritimoBloc {
  static final RegistroProcesoMaritimoBloc _singleton =
      new RegistroProcesoMaritimoBloc._internal();

  factory RegistroProcesoMaritimoBloc() {
    return _singleton;
  }

  RegistroProcesoMaritimoBloc._internal() {
    obtenerCountRegistroProcesoMaritimo();
  }

  final _registroProcesoMaritimoController = StreamController<int>.broadcast();
  AnimationController _animationController;

  Stream<int> registroProcesoMaritimoStream() {
    obtenerCountRegistroProcesoMaritimo();
    return _registroProcesoMaritimoController.stream;
  }

  dispose() {
    _registroProcesoMaritimoController?.close();
  }

  obtenerCountRegistroProcesoMaritimo() async {
    _registroProcesoMaritimoController.sink
        .add(await DatabaseProcesoMaritimo.getCountProcesoMaritimo());
  }

  itemAgregado() {
    try {
      _animationController.forward(from: 0.0);
    } catch (e) {}
  }

  set bounceController(AnimationController controller) {
    this._animationController = controller;
  }
}
