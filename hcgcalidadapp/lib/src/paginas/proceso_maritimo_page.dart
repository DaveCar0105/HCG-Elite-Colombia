import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/bloc/registro_proceso_hidratacion_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class ProcesoMaritimoPage extends StatefulWidget {
  @override
  _ProcesoMaritimoPageState createState() => _ProcesoMaritimoPageState();
}

class _ProcesoMaritimoPageState extends State<ProcesoMaritimoPage> {
  int estadoSolucionesGroupValue = -1;
  int tiemposDeHidratacionGroupValue = -1;
  int cantidadRamosTinasGroupValue = -1;
  //////// variables

  int procesoMaritimoNombreHidratanteValue = -1;
  int procesoMaritimoPhSolucionesvalue = -1;
  int procesoMaritimoNivelSolucionTinasValue = -1;
  int procesoMaritimoSolucionHidratacionSinVegetalValue = -1;
  int procesoMaritimoTemperaturaCuartoFrioValue = -1;
  int procesoMaritimoTemperaturaSolucionesHidratacionValue = -1;
  int procesoMaritimoEmpaqueAmbienteTemperaturaValue = -1;
  int procesoMaritimoFlorEmpacadaValue = -1;
  int procesoMaritimoTransportCareEmpaquevalue = -1;
  int procesoMaritimoCajasVisualDeformesValue = -1;
  int procesoMaritimoEtiquetasCajasUbicadasValue = -1;
  int procesoMaritimoTemperaturaCubiculoCamionValue = -1;
  int procesoMaritimoTemperaturaCajasTransferenciaValue = -1;
  int procesoMaritimoAparenciaCajasTransferenciaValue = -1;
  int procesoMaritimoEstibasDebidamenteSelladasValue = -1;
  int procesoMaritimoPalletsEsquinerosCorrectamenteAjustadosValue = -1;
  int procesoMaritimoPalletsAlturaContenedorValue = -1;
  int procesoMaritimoTemperaturaPalletContenedorValue = -1;
  int procesoMaritimoPalletIdentificadoNumeroValue = -1;
  int procesoMaritimoTomaRegistroTemperaturasValue = -1;
  int procesoMaritimoGensetValue = -1;
  int procesoMaritimoContenedorEdadFabricacionValue = -1;
  int procesoMaritimoContenedorCumplimientoSeteoValue = -1;
  int procesoMaritimoContenedorPreEnfriadoValue = -1;
  int procesoMaritimoContenedorlavadoDesinfectadoValue = -1;
  int procesoMartimoCarguePreviamenteHumedecidosValue = -1;
  int procesoMaritimoLlegandoCierreSelladoValue = -1;
  int procesoMaritimoEstibasSelloICAValue = -1;
  int procesoMaritimoPalletsTensionZunchosvalue = -1;
  int procesoMaritimoPalletIdentificadoEtiquetaValue = -1;
  int procesoMaritimoComponentePalletDestinosEtiquetasValue = -1;
  int procesoMaritimoCamionSelloSeguridadContenedorValue = -1;

  final phSolucionController = new TextEditingController();
  final nivelSolucionController = new TextEditingController();
  final procesoMaritimoNumeroGuiateValue = new TextEditingController();
  final procesoMaritimoRealizadoPorValue = new TextEditingController();
  final procesoMaritimoAcompanamiento = new TextEditingController();

  final appBar = AppBar();
  final _procesoMaritimoBloc = new RegistroProcesoHidratacionBloc();
  @override
  void initState() {
    cargarCombo();
    cargarComboClientes();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;

  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ListaBusquedaState> _keyClientes = GlobalKey();
  List<AutoComplete> listaClientes = new List<AutoComplete>();
  String clientesNombre = "";
  int clientesId = 0;
  bool clientesEnable = false;

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

  cargarComboClientes() async {
    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(1);
    clientes.forEach((element) {
      listaClientes.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    setState(() {
      clientesEnable = true;
    });
  }

  Widget _realizadoPor() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Realizado por',
          labelText: 'Realizado por',
        ),
        controller: procesoMaritimoRealizadoPorValue,
      ),
    );
  }

  Widget _acompanamiento() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Acompañamiento',
          labelText: 'Acompañamiento',
        ),
        controller: procesoMaritimoAcompanamiento,
      ),
    );
  }

  Widget _numeroGuia() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'numero guia',
          labelText: 'numero guia',
        ),
        controller: procesoMaritimoNumeroGuiateValue,
      ),
    );
  }

  Widget _postcosecha() {
    return Container(
      width: 250,
      height: 80,
      child: postcosechaEnable
          ? ListaBusqueda(
              key: _keyPostcosecha,
              lista: listaPostcosecha,
              hintText: "Post Cosecha",
              valorDefecto: postcosechaNombre,
              hintSearchText: "Seleccione el nombre de Postcosecha",
              icon: Icon(Icons.move_to_inbox),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete postcosecha = listaPostcosecha.firstWhere((item) {
                  return item.nombre == value;
                });
                postcosechaId = postcosecha.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _clientes() {
    return Container(
      width: 250,
      height: 80,
      child: clientesEnable
          ? ListaBusqueda(
              key: _keyClientes,
              lista: listaClientes,
              hintText: "Clientes",
              valorDefecto: clientesNombre,
              hintSearchText: "Seleccione el nombre del cliente",
              icon: Icon(Icons.move_to_inbox),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete clientes = listaClientes.firstWhere((item) {
                  return item.nombre == value;
                });
                clientesId = clientes.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  // Widget _itemHidratacion() {
  //   return (Row(
  //     children: <Widget>[
  //       Container(
  //         width: width * 0.5,
  //         child: Text('Estado de Soluciones'),
  //       ),
  //       Radio(
  //           value: 0,
  //           groupValue: estadoSolucionesGroupValue,
  //           onChanged: (value) {
  //             setState(() {
  //               estadoSolucionesGroupValue = value;
  //             });
  //           }),
  //       Spacer(),
  //       Radio(
  //           value: 1,
  //           groupValue: estadoSolucionesGroupValue,
  //           onChanged: (value) {
  //             setState(() {
  //               estadoSolucionesGroupValue = value;
  //             });
  //           }),
  //     ],
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Proceso Maritimo Check'), actions: <Widget>[
        StreamBuilder(
            stream: _procesoMaritimoBloc.registroProcesoHidratacionStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return data == 0
                    ? Container()
                    : Bounce(
                        controller: (controller) =>
                            _procesoMaritimoBloc.bounceController = controller,
                        from: 20,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'detalleHidratacion');
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
          padding: EdgeInsets.symmetric(
              vertical: height * 0.01, horizontal: width * 0.05),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.05,
              ),
              _postcosecha(),
              _clientes(),
              _numeroGuia(),
              _realizadoPor(),
              _acompanamiento(),
              Divider(),
              Column(children: [
                Text('HIDRATACION',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  // Spacer(),
                  // Text(
                  //   'No Cumple:',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  // ),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              // _itemHidratacion(),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Nombre de Hidratante, dosis y fecha de elaboración'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoNombreHidratanteValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoNombreHidratanteValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoNombreHidratanteValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoNombreHidratanteValue = value;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text('pH soluciones 3.5 a 4.5'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoPhSolucionesvalue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPhSolucionesvalue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoPhSolucionesvalue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPhSolucionesvalue = value;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El nivel de solución en las tinas de hidratación es de 10 cm todas las especies exepto Alstroemeria'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoNivelSolucionTinasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoNivelSolucionTinasValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoNivelSolucionTinasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoNivelSolucionTinasValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las soluciones de hidratación están limpias y libres de material vegetal'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoSolucionHidratacionSinVegetalValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoSolucionHidratacionSinVegetalValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoSolucionHidratacionSinVegetalValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoSolucionHidratacionSinVegetalValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'La temperatura del cuarto frio donde se hidrata la flor esta entre 1 a 3°C'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoTemperaturaCuartoFrioValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaCuartoFrioValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoTemperaturaCuartoFrioValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaCuartoFrioValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'La temperatura de las soluciones de hidratación es menor a los 6°C'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoTemperaturaSolucionesHidratacionValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaSolucionesHidratacionValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoTemperaturaSolucionesHidratacionValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaSolucionesHidratacionValue =
                              value;
                        });
                      }),
                ],
              ),
              Divider(),
              Column(children: [
                Text('EMPAQUE', style: Theme.of(context).textTheme.subtitle1)
              ]),

              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  // Spacer(),
                  // Text(
                  //   'No Cumple:',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  // ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El empaque es realizado en un ambiente con una temperatura que oscile entre 1º y 3ºC'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoEmpaqueAmbienteTemperaturaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEmpaqueAmbienteTemperaturaValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoEmpaqueAmbienteTemperaturaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEmpaqueAmbienteTemperaturaValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'La flor a ser empacada tiene una rotación máxima de 4 dias'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoFlorEmpacadaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoFlorEmpacadaValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoFlorEmpacadaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoFlorEmpacadaValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se coloca en todas las cajas TransportCare en el empaque, verificando su posición y cantidad de láminas por caja.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoTransportCareEmpaquevalue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTransportCareEmpaquevalue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoTransportCareEmpaquevalue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTransportCareEmpaquevalue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las cajas visualmente no están deformes, tienen una adecuada resistencia y están correctamente zunchadas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoCajasVisualDeformesValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoCajasVisualDeformesValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoCajasVisualDeformesValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoCajasVisualDeformesValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' Etiquetas de cajas ubicadas correctamente evitando sean tapadas con  esquineros de pallet'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoEtiquetasCajasUbicadasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEtiquetasCajasUbicadasValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoEtiquetasCajasUbicadasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEtiquetasCajasUbicadasValue = value;
                        });
                      }),
                ],
              ),
              Divider(),
              Column(children: [
                Text('TRANSFERENCIAS',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  // Spacer(),
                  // Text(
                  //   'No Cumple:',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  // ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'La temperatura cubículo camión transferencia entre 1ºC'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoTemperaturaCubiculoCamionValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaCubiculoCamionValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoTemperaturaCubiculoCamionValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaCubiculoCamionValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' La temperatura de  cajas de transferencia están entre 1° a 3 C'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoTemperaturaCajasTransferenciaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaCajasTransferenciaValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoTemperaturaCajasTransferenciaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaCajasTransferenciaValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'La apariencia de las cajas de transferencia estan en buen estado, no mojadas, correctamente marcadas, no deformes'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAparenciaCajasTransferenciaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAparenciaCajasTransferenciaValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAparenciaCajasTransferenciaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAparenciaCajasTransferenciaValue =
                              value;
                        });
                      }),
                ],
              ),
              Divider(),
              Column(children: [
                Text('PALLETIZADO',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  // Spacer(),
                  // Text(
                  //   'No Cumple:',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  // ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las estibas de madera están debidamente selladas, limpias, en buen estado,  correctamente armadas y del tamaño adecuado.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoEstibasDebidamenteSelladasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEstibasDebidamenteSelladasValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoEstibasDebidamenteSelladasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEstibasDebidamenteSelladasValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' Pallets con esquineros con altura que coincide, resistentes y  correctamente ajustados con 4 zunchos transversales y 4 zunchos  verticales'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoPalletsEsquinerosCorrectamenteAjustadosValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletsEsquinerosCorrectamenteAjustadosValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoPalletsEsquinerosCorrectamenteAjustadosValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletsEsquinerosCorrectamenteAjustadosValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Pallets con altura no mayor a 2.35m? Los pallets no deben sobrepasar  la línea roja del contenedor'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoPalletsAlturaContenedorValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletsAlturaContenedorValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoPalletsAlturaContenedorValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletsAlturaContenedorValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' 4 registradores de temperatura distribuidos proporcionalmente en los  pallet del contenedor? Cajas debidamente identificadas'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoTemperaturaPalletContenedorValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaPalletContenedorValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoTemperaturaPalletContenedorValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTemperaturaPalletContenedorValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Cada pallet identificado con el número de pallet, ciudad de destino y  número de piezas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoPalletIdentificadoNumeroValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletIdentificadoNumeroValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoPalletIdentificadoNumeroValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletIdentificadoNumeroValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' Toma y registro de temperaturas tomadas en mínimo 2 cajas de cada  pallet'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoTomaRegistroTemperaturasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTomaRegistroTemperaturasValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoTomaRegistroTemperaturasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoTomaRegistroTemperaturasValue = value;
                        });
                      }),
                ],
              ),
              Divider(),
              Column(children: [
                Text('LLENADO CONTENEDOR',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  // Spacer(),
                  // Text(
                  //   'No Cumple:',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  // ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Genset (generador de energía del contenedor) con autonomía para 60  horas?.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoGensetValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoGensetValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoGensetValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoGensetValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' Contenedor con edad de fabricación no mayor a 5 años (empaquetadura  y cierres de puerta en buen estado y libre de cualquier objeto extraño al  interior.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoContenedorEdadFabricacionValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorEdadFabricacionValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoContenedorEdadFabricacionValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorEdadFabricacionValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Contenedor cumpliendo el siguiente seteo: temperatura 0.5ºC, Defrost  o descongelamiento por demanda, Humedad relativa: OFF, Ventilación:  5%, desagues cerrados.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoContenedorCumplimientoSeteoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorCumplimientoSeteoValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoContenedorCumplimientoSeteoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorCumplimientoSeteoValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' Contenedor preenfriado durante 120 minutos garantizando temperatura  de retorno máxima de 1.5ºC.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoContenedorPreEnfriadoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorPreEnfriadoValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoContenedorPreEnfriadoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorPreEnfriadoValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Contenedor lavado y desinfectado libre de malos olores.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoContenedorlavadoDesinfectadoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorlavadoDesinfectadoValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoContenedorlavadoDesinfectadoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoContenedorlavadoDesinfectadoValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        ' 60 minutos antes de iniciar el cargue sachets de Ethilblock previamente  humedecidos con agua potable ubicados dentro de cada caja.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMartimoCarguePreviamenteHumedecidosValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMartimoCarguePreviamenteHumedecidosValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMartimoCarguePreviamenteHumedecidosValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMartimoCarguePreviamenteHumedecidosValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Realizado el llegando el cierre y sellado de las puertas se realiza a más  tardar 3 minutos después de desconectado el contenedor del muelle de  carga.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoLlegandoCierreSelladoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoLlegandoCierreSelladoValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoLlegandoCierreSelladoValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoLlegandoCierreSelladoValue = value;
                        });
                      }),
                ],
              ),
              Column(children: [
                Text('REQUERIMIENTOS CRITICOS',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  ),
                  // Spacer(),
                  // Text(
                  //   'No Cumple:',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold, fontSize: height * 0.019),
                  // ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las estibas presenta sello del ICA  de manera visible .'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoEstibasSelloICAValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEstibasSelloICAValue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoEstibasSelloICAValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoEstibasSelloICAValue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'los pallets se enuentran con una adecuada tensión de zunchos .'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoPalletsTensionZunchosvalue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletsTensionZunchosvalue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoPalletsTensionZunchosvalue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletsTensionZunchosvalue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Pallet debidamente identificado con etiqueta numeración pallet.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoPalletIdentificadoEtiquetaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletIdentificadoEtiquetaValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoPalletIdentificadoEtiquetaValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoPalletIdentificadoEtiquetaValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Componente de pallet se encuentra sin mezcla de destinos y etiquetas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoComponentePalletDestinosEtiquetasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoComponentePalletDestinosEtiquetasValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoComponentePalletDestinosEtiquetasValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoComponentePalletDestinosEtiquetasValue =
                              value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El camión se encuentra con sello de seguridad de contenedor.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoCamionSelloSeguridadContenedorValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoCamionSelloSeguridadContenedorValue =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoCamionSelloSeguridadContenedorValue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoCamionSelloSeguridadContenedorValue =
                              value;
                        });
                      }),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     // CheckboxListTile(value: false, onChanged: (newValue){

              //     // }),
              //     Container(
              //       width: width * 0.5,
              //       child: Text('Ph Solución'),
              //     ),
              //     Expanded(
              //         child: TextField(
              //       controller: phSolucionController,
              //       keyboardType: TextInputType.number,
              //       textAlign: TextAlign.center,
              //     ))
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // Row(
              //   children: <Widget>[
              //     Container(
              //       width: width * 0.5,
              //       child: Text('Nivel Solución'),
              //     ),
              //     Expanded(
              //         child: TextField(
              //       controller: nivelSolucionController,
              //       keyboardType: TextInputType.number,
              //       textAlign: TextAlign.center,
              //     ))
              //   ],
              // ),
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: _validarForm,
                      color: Colors.red,
                      textColor: Colors.white,
                      icon: Icon(Icons.save),
                      label: Text('Guardar'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validarForm() async {
    if (estadoSolucionesGroupValue >= 0 &&
        tiemposDeHidratacionGroupValue >= 0 &&
        cantidadRamosTinasGroupValue >= 0 &&
        phSolucionController.text != '' &&
        nivelSolucionController.text != '' &&
        postcosechaId != 0) {
      ProcesoHidratacion procesoHidratacion = new ProcesoHidratacion(
          procesoHidratacionUsuarioControlId: 1,
          procesoHidratacionEstadoSoluciones: estadoSolucionesGroupValue,
          procesoHidratacionTiemposHidratacion: tiemposDeHidratacionGroupValue,
          procesoHidratacionCantidadRamos: cantidadRamosTinasGroupValue,
          procesoHidratacionPhSolucion: double.parse(phSolucionController.text),
          procesoHidratacionNivelSolucion:
              double.parse(nivelSolucionController.text),
          procesoHidratacionFecha: DateTime.now(),
          postcosechaId: postcosechaId);
      int procesoHidratacionId =
          await DatabaseProcesoHidratacion.addProcesosHidratacion(
              procesoHidratacion);
      if (procesoHidratacionId != 0) {
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _limpiarForm();
        _procesoMaritimoBloc.registroProcesoHidratacionStream();
        _procesoMaritimoBloc.itemAgregado();
      } else {
        mostrarSnackbar('No se pudo ingresar en la base de datos', Colors.red,
            _scaffoldKey);
      }
    } else {
      mostrarSnackbar(
          'No se llenaron todos los campos', Colors.red, _scaffoldKey);
    }
  }

  _limpiarForm() {
    estadoSolucionesGroupValue = -1;
    tiemposDeHidratacionGroupValue = -1;
    cantidadRamosTinasGroupValue = -1;
    phSolucionController.text = '';
    nivelSolucionController.text = '';
    setState(() {});
  }
}
