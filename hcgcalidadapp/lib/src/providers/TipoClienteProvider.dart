import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';

class TipoClienteProvide extends ChangeNotifier {
  List<AutoComplete> _listaClientes = [];
  List<Cliente> _clientes = new List<Cliente>();
  String _nombreCliente = "";
  String _clienteNombre = "";

  TipoClienteProvide() {
    _listaClientes = List<AutoComplete>();
    _clientes = List<Cliente>();
    cargar();
  }

  cargar() async {
    _clientes = await DatabaseCliente.getAllCliente(1);
    _clientes.forEach((element) {
      _listaClientes.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    _nombreCliente= "Cliente";
    _clienteNombre = "";
  }

  List<AutoComplete>  get listaClientess {
    return _listaClientes;
  }

  get nombreCliente  {
    return _nombreCliente ;
  }

  get clienteNombre  {
    return _clienteNombre;
  }

  set clienteNombre(String valor){
    _clienteNombre = "";
    _nombreCliente = "Cliente " + valor;
    notifyListeners();
  }

  set listaClientes(int valor) {
    this._listaClientes.clear();
    List<Cliente> clientes = this
        ._clientes
        .where((element) => element.tipoClienteId == valor)
        .toList();
    clientes.forEach((element) {
      _listaClientes.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    notifyListeners();
  }
}
