import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_actividad.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/bloc/registro_actividades_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/actividad.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/tipoActividad.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class ActividadesPage extends StatefulWidget {
  const ActividadesPage({Key key}) : super(key: key);

  @override
  _ActividadesPageState createState() => _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {
  final _actividadesBloc = new RegistroActividadBloc();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final appBar = AppBar();
  TimeOfDay _timeInicio = TimeOfDay.now();
  String horaInicio = '';

  Future<Null> selectTimeInicio(BuildContext context) async {
    try {
      _timeInicio = await showTimePicker(
        context: context,
        initialTime: _timeInicio,
      );
      horaInicio =
          '${_timeInicio.hour.toString().padLeft(2, '0')}:${_timeInicio.minute.toString().padLeft(2, '0')}';
      horaFin = '';
    } catch (e) {
      _timeInicio = TimeOfDay.now();
    }
  }

  TimeOfDay _timeFin = TimeOfDay.now();
  String horaFin = '';

  Future<Null> selectTimeFin(BuildContext context) async {
    try {
      _timeFin = await showTimePicker(
        context: context,
        initialTime: _timeFin,
      );
      if (_timeFin.hour - _timeInicio.hour > 0) {
        horaFin =
            '${_timeFin.hour.toString().padLeft(2, '0')}:${_timeFin.minute.toString().padLeft(2, '0')}';
      } else if ((_timeFin.hour - _timeInicio.hour == 0) &&
          (_timeFin.minute - _timeInicio.minute > 0)) {
        horaFin =
            '${_timeFin.hour.toString().padLeft(2, '0')}:${_timeFin.minute.toString().padLeft(2, '0')}';
      } else {
        mostrarSnackbar('No puede escoger una hora menor a la de inicio',
            Colors.red, _scaffoldKey);
      }
    } catch (e) {
      _timeFin = TimeOfDay.now();
    }
  }

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;

  GlobalKey<ListaBusquedaState> _keyListaActividades = GlobalKey();
  List<AutoComplete> listaActividades = new List<AutoComplete>();
  String listaActividadesNombre = "";
  int listaActiviadesId = 0;
  bool listaActividadesEnable = false;

  _ActividadesPageState() {
    cargarCombo();
    cargarComboActiviades();
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
  }

  cargarComboActiviades() async {
    List<TipoActividad> activiades = List();
    activiades = await DatabaseEcuador.getAllTipoActividad();
    print("ACTIVIDADES");
    print(jsonEncode(activiades));
    activiades.forEach((element) {
      listaActividades.add(AutoComplete(
          id: element.tipoActividadId,
          nombre: element.tipoActividadDescripcion));
    });
    setState(() {
      listaActividadesEnable = true;
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
              hintSearchText: "Escriba el nombre de Postcosecha",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if(value!= null && value!=""){
                  AutoComplete postcosecha = listaPostcosecha.firstWhere((item) {
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

  Widget _listaActividades() {
    return Container(
      child: listaActividadesEnable
          ? ListaBusqueda(
              key: _keyListaActividades,
              lista: listaActividades,
              hintText: "Lista de actividades",
              valorDefecto: listaActividadesNombre,
              hintSearchText: "Seleccione la actividad",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if(value!= null && value!=""){
                  AutoComplete actividades = listaActividades.firstWhere((item) {
                    return item.nombre == value;
                  });
                  listaActiviadesId = actividades.id;
                  listaActividadesNombre = actividades.nombre;
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
      appBar: AppBar(title: Text('REGISTRO DE ACTIVIADES'), actions: <Widget>[
        StreamBuilder(
            stream: _actividadesBloc.registroActividadStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return data == 0
                    ? Container()
                    : Bounce(
                        controller: (controller) =>
                            _actividadesBloc.bounceController = controller,
                        from: 20,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'detalleActividades');
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
                                    style: TextStyle(color: Colors.black),
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
      ]),
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            child: Column(
              children: <Widget>[
                Container(
                  height: height * 0.6,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      _postcosecha(),
                      Text(
                        'ACTIVIDADES',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            ),
                      ),
                      _listaActividades(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton.icon(
                                color: horaInicio == ''
                                    ? Colors.red
                                    : Colors.green,
                                textColor: Colors.white,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  selectTimeInicio(context);
                                },
                                icon: Icon(horaInicio == ''
                                    ? Icons.timer
                                    : Icons.check),
                                label: Text(
                                  horaInicio == '' ? 'Hora Inicio' : horaInicio,
                                  style: TextStyle(fontSize: 10),
                                )),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            child: RaisedButton.icon(
                                color:
                                    horaFin == '' ? Colors.red : Colors.green,
                                textColor: Colors.white,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  selectTimeFin(context);
                                },
                                icon: Icon(horaFin == ''
                                    ? Icons.timer_off
                                    : Icons.check),
                                label: Text(
                                  horaFin == ''
                                      ? 'Hora Fin'
                                      : horaFin.toString(),
                                  style: TextStyle(fontSize: 10),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: height * 0.36,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onPressed: _validarForm,
                          color: Colors.red,
                          textColor: Colors.white,
                          icon: Icon(Icons.save),
                          label: Text(' Guardar'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  _validarForm() async {
    if (postcosechaId != 0 && horaInicio != '' && horaFin != '') {
      Actividad actividad = new Actividad(
          actividadUsuarioControlId: 1,
          actividadHoraInicio: horaInicio,
          actividadHoraFin: horaFin,
          actividadFecha: DateTime.now(),
          tipoActividadDescripcion: listaActividadesNombre,
          tipoActividadId: listaActiviadesId,
          postcosechaId: postcosechaId);
      int actividadId = await DatabaseActividad.addActividad(actividad);
      if (actividadId != 0) {
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _actividadesBloc.registroActividadStream();
        _actividadesBloc.itemAgregado();
        _limpiarFormulario();
      } else {
        mostrarSnackbar(
            'No se pudo ingresar a la base de datos', Colors.red, _scaffoldKey);
      }
    } else {
      mostrarSnackbar(
          'No se han llenado todos los campos', Colors.red, _scaffoldKey);
    }
  }

  _limpiarFormulario() {
    horaFin = '';
    horaInicio = '';
    setState(() {});
  }
}
