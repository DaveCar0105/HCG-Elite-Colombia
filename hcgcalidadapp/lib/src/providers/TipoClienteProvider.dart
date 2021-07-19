import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/tipoCliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';

class TipoClienteProvide with ChangeNotifier {
  List<AutoComplete> _listaClientes = new List<AutoComplete>();
  List<Cliente> _clientes = new List<Cliente>();

  TipoClienteProvide() {
    _listaClientes = List<AutoComplete>();
    _clientes = List<Cliente>();
    cargar();
  }

  cargar() async {
    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(1);
    clientes.forEach((element) {
      _clientes.add(element);
      _listaClientes.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
  }

  get listaClientes {
    return _listaClientes;
  }

  set listaClientes(int valor) {
    print("Cantidad: " + jsonEncode(_clientes[0]));
    print("CantidadB: " + this._listaClientes.length.toString());
    this._listaClientes.clear();
    print("Cantidad: " + this._listaClientes.length.toString());
    List<Cliente> clientes = this
        ._clientes
        .where((element) => element.tipoClienteId == valor)
        .toList();
    clientes.forEach((element) {
      _listaClientes.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    print("Cantidad2: " + this._listaClientes.length.toString());
    notifyListeners();
  }
}
