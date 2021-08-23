import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_temperatura.dart';
import 'package:hcgcalidadapp/src/bloc/registro_temperatura_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/temperatura.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class RegistroTemperaturaPage extends StatefulWidget {
  @override
  _RegistroTemperaturaPageState createState() =>
      _RegistroTemperaturaPageState();
}

class _RegistroTemperaturaPageState extends State<RegistroTemperaturaPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _temperaturaBloc = new RegistroTemperaturaBloc();

  final appBar = AppBar();

  final temperaturaExterna = TextEditingController();

  final temperaturaInterna1 = TextEditingController();
  final temperaturaInterna2 = TextEditingController();
  final temperaturaInterna3 = TextEditingController();

  final prefs = new Preferences();

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;

  GlobalKey<ListaBusquedaState> _keyClientes = GlobalKey();
  List<AutoComplete> listaClientes = new List<AutoComplete>();
  String clienteNombre = "";
  int clienteId = 0;
  bool clientesEnable = false;

  _RegistroTemperaturaPageState() {
    cargarCombo();
  }
  cargarCombo() async {
    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(1);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });
    setState(() {
      postcosechaEnable = true;
    });

    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(1);
    clientes.forEach((element) {
      listaClientes.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    setState(() {
      postcosechaEnable = true;
      clientesEnable = true;
    });
  }

  Widget _postcosecha() {
    return Container(
      child: postcosechaEnable
          ? ListaBusqueda(
              key: _keyPostcosecha,
              lista: listaPostcosecha,
              hintText: "Post Cosecha",
              valorDefecto: postcosechaNombre,
              hintSearchText: "Elegir el nombre de Postcosecha",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete postcosecha =
                      listaPostcosecha.firstWhere((item) {
                    return item.nombre == value;
                  });
                  postcosechaId = postcosecha.id;
                }
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _clientes() {
    return Container(
      child: clientesEnable
          ? ListaBusqueda(
              key: _keyClientes,
              lista: listaClientes,
              hintText: "Cliente",
              valorDefecto: postcosechaNombre,
              hintSearchText: "Elegir un cliente",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete cliente = listaClientes.firstWhere((item) {
                    return item.nombre == value;
                  });
                  clienteId = cliente.id;
                }
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('REGISTRO DE TEMPERATURA'),
        actions: <Widget>[
          StreamBuilder(
              stream: _temperaturaBloc.registroTemperaturaStream(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  return data == 0
                      ? Container()
                      : Bounce(
                          controller: (controller) =>
                              _temperaturaBloc.bounceController = controller,
                          from: 20,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, 'detalleTemperatura');
                            },
                            child: Container(
                              width: width * 0.1,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.brightness_1,
                                          color: Colors.white)),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data.toString(),
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                }
                return Container();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _postcosecha(),
                    _InputTemperatura(
                        title: 'Temperatura Cuarto Frío',
                        controller: temperaturaExterna),
                    Divider(),
                    _clientes(),
                    _InputTemperatura(
                        title: 'Temperatura Caja #1',
                        margin: EdgeInsets.only(top: height * 0.03),
                        controller: temperaturaInterna1),
                    _InputTemperatura(
                        title: 'Temperatura Caja #2',
                        margin: EdgeInsets.only(top: height * 0.03),
                        controller: temperaturaInterna2),
                    _InputTemperatura(
                        title: 'Temperatura Caja #3',
                        margin: EdgeInsets.only(top: height * 0.03),
                        controller: temperaturaInterna3),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: _validarForm,
                        color: Colors.red,
                        textColor: Colors.white,
                        icon: Icon(Icons.save),
                        label: Text('Guardar'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }

  //validacion de ingreso de temperatura
  _validarForm() async {
    if (temperaturaExterna.text == '' &&
        temperaturaInterna1.text == '' &&
        temperaturaInterna2.text == '' &&
        temperaturaInterna3.text == '') {
      mostrarSnackbar(
          'No se ha ingresado ninguna temperatura', Colors.red, _scaffoldKey);
    } else if (postcosechaId == 0) {
      mostrarSnackbar(
          'No se ha seleccionado una postcosecha', Colors.red, _scaffoldKey);
    } else {
      Temperatura temperatura = new Temperatura(
          temperaturaUsuarioControlId: 1, //prefs.userId,
          temperaturaInterna1: temperaturaInterna1.text == ''
              ? null
              : double.parse(temperaturaInterna1.text),
          temperaturaInterna2: temperaturaInterna2.text == ''
              ? null
              : double.parse(temperaturaInterna2.text),
          temperaturaInterna3: temperaturaInterna3.text == ''
              ? null
              : double.parse(temperaturaInterna3.text),
          temperaturaExterna: temperaturaExterna.text == ''
              ? null
              : double.parse(temperaturaExterna.text),
          temperaturaFecha: DateTime.now(),
          postcosechaId: postcosechaId,
          clienteId: clienteId);
      print(jsonEncode(temperatura));
      final temperaturaId =
          await DatabaseTemperatura.addTemperatura(temperatura);
      if (temperaturaId != 0) {
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _temperaturaBloc.registroTemperaturaStream();
        _temperaturaBloc.itemAgregado();
        temperaturaExterna.text = '';
        temperaturaInterna1.text = '';
        temperaturaInterna2.text = '';
        temperaturaInterna3.text = '';
      } else {
        mostrarSnackbar(
            'No se pudo ingresar a la base de datos', Colors.red, _scaffoldKey);
      }
    }
  }
}

class _InputTemperatura extends StatelessWidget {
  const _InputTemperatura({
    Key key,
    @required this.fontSize,
    @required this.controller,
    @required this.title,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: MediaQuery.of(context).size.width * 0.85,
      margin: margin,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "ejm: 9.5",
              ),
              textAlign: TextAlign.right),
        ],
      ),
    );
  }
}
