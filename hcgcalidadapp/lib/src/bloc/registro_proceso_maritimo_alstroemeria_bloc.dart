import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo_alstroemeria.dart';

class RegistroProcesoMaritimoAlstroemeriaBloc {
  static final RegistroProcesoMaritimoAlstroemeriaBloc _singleton =
      new RegistroProcesoMaritimoAlstroemeriaBloc._internal();

  factory RegistroProcesoMaritimoAlstroemeriaBloc() {
    return _singleton;
  }

  RegistroProcesoMaritimoAlstroemeriaBloc._internal() {
    obtenerCountRegistroProcesoMaritimoAlstroemeria();
  }

  final _registroProcesoMaritimoAlstroemeriaController = StreamController<int>.broadcast();
  AnimationController _animationController;

  Stream<int> registroProcesoMaritimoAlstroemeriaStream() {
    obtenerCountRegistroProcesoMaritimoAlstroemeria();
    return _registroProcesoMaritimoAlstroemeriaController.stream;
  }

  dispose() {
    _registroProcesoMaritimoAlstroemeriaController?.close();
  }

  obtenerCountRegistroProcesoMaritimoAlstroemeria() async {
    _registroProcesoMaritimoAlstroemeriaController.sink
        .add(await DatabaseProcesoMaritimoAlstroemeria.getCountProcesoMaritimoAlstroemeria());
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
