import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_destinos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo_alstroemeria.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/bloc/registro_proceso_maritimo_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/destinos.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class ProcesoMaritimoAlstroemeriaPage extends StatefulWidget {
  @override
  _ProcesoMaritimoAlstroemeriaPageState createState() => _ProcesoMaritimoAlstroemeriaPageState();
}

class _ProcesoMaritimoAlstroemeriaPageState extends State<ProcesoMaritimoAlstroemeriaPage> {
  int procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad = -1;
  int procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta = -1;
  int procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion = -1;
  int procesoMaritimoAlstroemeriaClasificacionLongitudTallos = -1;
  int procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal = -1;
  int procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado = -1;
  int procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood = -1;
  int procesoMaritimoAlstroemeriaClasificacionLibreMaltrato = -1;
  int procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso = -1;
  int procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos = -1;
  int procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo = -1;
  int procesoMaritimoAlstroemeriaTratamientoBaldesTinas = -1;
  int procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion = -1;
  int procesoMaritimoAlstroemeriaTratamientoNivelSolucion = -1;
  int procesoMaritimoAlstroemeriaTratamientoCambioSolucion = -1;
  int procesoMaritimoAlstroemeriaTratamientoTiempoSala = -1;
  int procesoMaritimoAlstroemeriaHidratacionNumeroRamos = -1;
  int procesoMaritimoAlstroemeriaHidratacionRamosHidratados = -1;
  int procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio = -1;
  int procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado = -1;
  int procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion = -1;
  int procesoMaritimoAlstroemeriaEmpaqueEdadFlor = -1;
  int procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos = -1;
  int procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos = -1;
  int procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento = -1;
  int procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo = -1;
  int procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad = -1;
  int procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas = -1;
  int procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue = -1;
  int procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR = -1;
  int procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto = -1;
  int procesoMaritimoAlstroemeriaEmpaqueEmpacoHB = -1;
  int procesoMaritimoAlstroemeriaTransporteTemperauraCajas = -1;
  int procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio = -1;
  int procesoMaritimoAlstroemeriaTransporteCamionTransporta = -1;
  int procesoMaritimoAlstroemeriaTransporteTemperaturaCamion = -1;
  int procesoMaritimoAlstroemeriaTransporteBuenaConexion = -1;
  int procesoMaritimoAlstroemeriaTransporteThermoking = -1;
  int procesoMaritimoAlstroemeriaTransporteCajasApiladas = -1;
  int procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado = -1;
  int procesoMaritimoAlstromeriaTransporteTemperaturaFurgon = -1;
  int procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias = -1;
  int procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros = -1;
  int procesoMaritimoAlstroemeriaPalletizadoPalletsAltura = -1;
  int procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido = -1;
  int procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado = -1;
  int procesoMaritimoAlstroemeriaContenedorGenset = -1;
  int procesoMaritimoAlstroemeriaContenedorFechaFabricacion = -1;
  int procesoMaritimoAlstroemeriaContenedorContenedorSeteo = -1;
  int procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado = -1;
  int procesoMaritimoAlstroemeriaContenedorContenedorLavado = -1;
  int procesoMaritimoAlstroemeriaContenedorSachetsEthiblock = -1;
  int procesoMaritimoAlstroemeriaContenedorCierreSellado = -1;
  int procesoMaritimoAlstroemeriaContenedorControlTemperatura = -1;

  final procesoMaritimoNumeroGuiaValue = new TextEditingController();
  final procesoMaritimoRealizadoPorValue = new TextEditingController();
  final procesoMaritimoAcompanamientoValue = new TextEditingController();

  final procesoMaritimoObsevacionesHidratacionValue =
      new TextEditingController();
  final procesoMaritimoObservacionesEmpaqueValue = new TextEditingController();
  final procesoMaritimoObservacionesTransferenciaValue =
      new TextEditingController();
  final procesoMaritimoObservacionesPalletizadoValue =
      new TextEditingController();
  final procesoMaritimoObservacionesLlenadoContenedorValue =
      new TextEditingController();
  final procesoMaritimoObservacionesRequerimientosCriticosValue =
      new TextEditingController();

  final appBar = AppBar();
  final _procesoMaritimoBloc = new RegistroProcesoMaritimoBloc();

  @override
  void initState() {
    cargarCombo();
    cargarComboClientes();
    cargarComboDestinos();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;

  GlobalKey<ListaBusquedaState> _keyClientes = GlobalKey();
  List<AutoComplete> listaClientes = new List<AutoComplete>();
  String clientesNombre = "";
  int clientesId = 0;
  bool clientesEnable = false;

  GlobalKey<ListaBusquedaState> _keyDestinos1 = GlobalKey();
  List<AutoComplete> listaDestinos = new List<AutoComplete>();
  String destinosNombre = "";
  int destinosId = 0;
  bool destinosEnable = false;

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

  cargarComboDestinos() async {
    List<ProcesoMaritimoDestinos> destinos = List();
    destinos = await DatabaseDestino.getAllProcesoMaritimoDestinos();
    destinos.forEach((element) {
      listaDestinos.add(AutoComplete(
          id: element.procesoMaritimoDestinoId,
          nombre: element.procesoMaritimoDestinoNombre));
    });
    setState(() {
      destinosEnable = true;
    });
  }

  Widget _realizadoPor() {
    return Container(
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
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Acompañamiento',
          labelText: 'Acompañamiento',
        ),
        controller: procesoMaritimoAcompanamientoValue,
      ),
    );
  }

  Widget _numeroGuia() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Número guía',
          labelText: 'Número guía',
        ),
        controller: procesoMaritimoNumeroGuiaValue,
      ),
    );
  }

  Widget _postcosecha() {
    return Container(
      child: postcosechaEnable
          ? ListaBusqueda(
              key: _keyPostcosecha,
              lista: listaPostcosecha,
              hintText: "Post Cosecha",
              valorDefecto: postcosechaNombre,
              hintSearchText: "Seleccione el nombre de Postcosecha",
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
              hintText: "Clientes",
              valorDefecto: clientesNombre,
              hintSearchText: "Seleccione el nombre del cliente",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete clientes = listaClientes.firstWhere((item) {
                    return item.nombre == value;
                  });
                  clientesId = clientes.id;
                }
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _destinos() {
    return Container(
      child: destinosEnable
          ? ListaBusqueda(
              key: _keyDestinos1,
              lista: listaDestinos,
              hintText: "Destinos",
              valorDefecto: destinosNombre,
              hintSearchText: "Seleccione el destino",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete destinos = listaDestinos.firstWhere((item) {
                    return item.nombre == value;
                  });
                  destinosId = destinos.id;
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
      appBar: AppBar(title: Text('Proceso Marítimo Alstroemeria Check'), actions: <Widget>[
        StreamBuilder(
            stream: _procesoMaritimoBloc.registroProcesoMaritimoStream(),
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
                            Navigator.pushNamed(context, 'detalleMaritimo');
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
              _destinos(),
              _clientes(),
              _numeroGuia(),
              _realizadoPor(),
              _acompanamiento(),
              Divider(),
              Column(children: [
                Text('HIDRATACIÓN',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Container(padding: const EdgeInsets.only(bottom: 5)),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Expanded(child: 
                    Text(
                      'Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  ),
                  Expanded(child: 
                    Text(
                      'No Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  )
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Los empacadores recibieron capacitación en el requerimiento de empaque de las cajas marítimas. Existen registros de capacitación'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaHidratacionNumeroRamos,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionNumeroRamos = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaHidratacionNumeroRamos,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionNumeroRamos = value;
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
                    child: Text('Los ramos son hidratados por 4 horas a temperatura ambiente en solución STS y luego en cuarto frío mínimo 12 horas en esa misma solución.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaHidratacionRamosHidratados,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionRamosHidratados = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaHidratacionRamosHidratados,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionRamosHidratados = value;
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
                        'La temperatura de cuarto frío de hidratación oscila entre 0.5 ºC y 1.5 ºC y una humedad relativa de 80% a 85%. Se llevan registros.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El cuarto frío de hidratación se encuentra limpio y ordenado. Se lava y desinfecta acorde a lo programado en el cronograma de aseo y desinfección de poscosecha'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado =
                              value;
                        });
                      }),
                ],
              ),
              _procesoMaritimoObsevacionesHidratacion(),
              Divider(),
              Column(children: [
                Text('EMPAQUE', style: Theme.of(context).textTheme.subtitle1)
              ]),
              Container(padding: const EdgeInsets.only(bottom: 5)),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Expanded(child: 
                    Text(
                      'Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  ),
                  Expanded(child: 
                    Text(
                      'No Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  )
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
                        'Los empacadores recibieron capacitación en el requerimiento de empaque de las cajas marítimas. Existen registros de capacitación.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion =
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
                        'La edad de la flor utilizada para el empaque de las cajas marítimas es de acuerdo al cliente.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEdadFlor,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEdadFlor = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEdadFlor,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEdadFlor = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se realiza escurrido a los ramos antes de ser empacados.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se revisó la temperatura de los ramos antes de ser empacados y estos se encontraban en máximo.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las cajas empacadas cumplen con los requerimientos establecidos: uso de cajas especiales para marítimo, uso de láminas de transport care en la base y la parte superior de la caja previamente activadas con agua, distribución de los ramos y zunchado acorde a lo establecido.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se ubicó dentro de 1 de las cajas del despacho marítimo 1 registrador de temperatura que permita ver el comportamiento de la temperatura durante el transporte al centro de acopio. Caja debidamente indentificada?'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las cajas se encuentran sin deformidad, visualmente resistentes, correctamente zunchadas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las etiquetas de cajas se encuentran ubicadas correctamente evitando sean tapadas con esquineros de pallet?'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El producto empacado listo para el cargue se encuentra en estibas que coinciden con el tamaño de las cajas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El cuarto frío de empaque y el de despachos  se encuentra a una temperatura de 0.5 a 2 °C y una HR de 80 a 85%. Se controlan y llevan registros.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se realiza auditoría de producto terminado a mínimo 1 caja del despacho marítimo por parte del jefe de sala, líder de calidad y supervisor de sala.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se empaco 1 HB  con ramos tomados al azar y que hayan seguido todo el  proceso del marítimo y se envió al  Dpto de calidad para evaluacion de viaje simulado y de vida en florero.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEmpacoHB,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEmpacoHB = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaEmpaqueEmpacoHB,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaEmpaqueEmpacoHB = value;
                        });
                      }),
                ],
              ),
              _procesoMaritimoObsevacionesEmpaque(),
              Divider(),
              Column(children: [
                Text('TRANSPORTE AL CENTRO DE ACOPIO',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Container(padding: const EdgeInsets.only(bottom: 5)),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Expanded(child: 
                    Text(
                      'Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  ),
                  Expanded(child: 
                    Text(
                      'No Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se tomaron temperaturas al 20% de las cajas del despacho y se dejó evidencia en el formato de Control de Temperaturas de Despacho. Se llevan registros.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaTransporteTemperauraCajas,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteTemperauraCajas = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaTransporteTemperauraCajas,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteTemperauraCajas = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'La temperatura promedio de las cajas de despacho fue menor a 2 °C. En caso contrario se pasaron las cajas a precooler.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio =
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
                        'El camión que transporta las cajas al centro de acopio fue previamente lavado y desinfectado con Timsen (2 g/lt). Hay registros que lo evidencien.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteCamionTransporta,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteCamionTransporta =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteCamionTransporta,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteCamionTransporta =
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
                        'Se mide y registra la temperatura del camión al abrir la puerta.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteTemperaturaCamion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteTemperaturaCamion =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteTemperaturaCamion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteTemperaturaCamion =
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
                        'El cargue de las cajas se realizó garantizando una buena conexión de la puerta del camión y el cuarto frío.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteBuenaConexion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteBuenaConexion =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteBuenaConexion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteBuenaConexion =
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
                        'Durante el  cargue y descargue el camion que realiza el transporte de la carga se mantuvo encendido el thermoking.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteThermoking,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteThermoking =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteThermoking,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteThermoking =
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
                        'Las cajas en el camión fueron apiladas una sobre otra sin cubrir la salida de aire frío del difusor del furgón y se dejó un espacio libre de 20 a 30 cm entre la línea de salida de aire del difusor y la última caja.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteCajasApiladas,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteCajasApiladas =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteCajasApiladas,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteCajasApiladas =
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
                        'El camión utilizado para el transporte de las cajas al centro de acopio fue preenfriado dos horas antes de iniciar el cargue y lleva un termómetro de máximos y mínimos.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado =
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
                        'La temperatura del furgon en el momento del cargue era de máximo 1.5°C (verificar esta información con el termómetro de aguja o laser) y el thermoking del camión se graduó a una temperatura de 0.5°C a 1.5 °C.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstromeriaTransporteTemperaturaFurgon,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstromeriaTransporteTemperaturaFurgon =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstromeriaTransporteTemperaturaFurgon,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstromeriaTransporteTemperaturaFurgon =
                              value;
                        });
                      }),
                ],
              ),
              _procesoMaritimoObsevacionesTransferencia(),
              Divider(),
              Column(children: [
                Text('PALLETIZADO',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Container(padding: const EdgeInsets.only(bottom: 5)),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Expanded(child: 
                    Text(
                      'Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  ),
                  Expanded(child: 
                    Text(
                      'No Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Las estibas que se usan para palletizar estan debidamente limpias, en buen estado, correctamente armadas y del tamaño adecuado.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias =
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
                        "Los pallet's poseen esquineros con altura que coincide, resistentes y correctamente ajustados con 4 zunchos transversales y 4 verticales."),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros =
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
                        'Los pallets tienen una altura máxima de 2,35 m. y  no sobrepasan la línea roja del contenedor.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaPalletizadoPalletsAltura,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoPalletsAltura = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaPalletizadoPalletsAltura,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoPalletsAltura = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'Se colocan 5 registradores de temperatura distribuidos proporcionalmente en los pallet del contenedor y las cajas se encuentran debidamente identificadas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido =
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
                        'Cada pallet se encuentra identificado con el número de pallet, ciudad de destino y número de piezas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado = value;
                        });
                      }),
                ],
              ),
              _procesoMaritimoObsevacionesPalletizado(),
              Divider(),
              Column(children: [
                Text('LLENADO CONTENEDOR',
                    style: Theme.of(context).textTheme.subtitle1)
              ]),
              Container(padding: const EdgeInsets.only(bottom: 5)),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width * 0.5,
                  ),
                  Expanded(child: 
                    Text(
                      'Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  ),
                  Expanded(child: 
                    Text(
                      'No Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El Genset (generador de energía del contenedor) tiene autonomía para 60 horas.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaContenedorGenset,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorGenset = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaContenedorGenset,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorGenset = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El contenedor tiene una fecha de fabricación no mayor a 5 años.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaContenedorFechaFabricacion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorFechaFabricacion = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaContenedorFechaFabricacion,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorFechaFabricacion = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El contenedor cumple el siguiente seteo: temperatura 0.5ºC, defrost o descongelamiento por demanda, Humedad relativa: OFF, ventilación: 5%, desagües cerrados.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaContenedorContenedorSeteo,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorContenedorSeteo =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaContenedorContenedorSeteo,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorContenedorSeteo =
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
                        'El contenedor preenfriado durante 120 minutos garantizando temperatura de retorno máxima de 1.5ºC / para despachos consolidados el retorno del contenedor debe ser inferior a 2.5ºC.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        'El contenedor se encuentra lavado, desinfectado y libre de malos olores.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaContenedorContenedorLavado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorContenedorLavado =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaContenedorContenedorLavado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorContenedorLavado =
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
                        "60 minutos antes de iniciar el cargue se ubicaron sachet's de Ethilblock previamente humedecidos con agua potable dentro de cada caja de acuerdo al procedmiento."),
                  ),
                  Radio(
                      value: 0,
                      groupValue:
                          procesoMaritimoAlstroemeriaContenedorSachetsEthiblock,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorSachetsEthiblock =
                              value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue:
                          procesoMaritimoAlstroemeriaContenedorSachetsEthiblock,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorSachetsEthiblock =
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
                        'El cierre y sellado de las puertas se realiza a más tardar 3 minutos después de desconectado el contenedor del muelle de carga.'),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaContenedorCierreSellado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorCierreSellado = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaContenedorCierreSellado,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorCierreSellado = value;
                        });
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text(
                        "Antes del cargue de las cajas al contenedor de exportación se le realiza un control de la temperatura interna de las cajas al 20% de las cajas a ser despachadas (3 cajas por pallet). Se deja registro en el formato de distribución de pallet´s."),
                  ),
                  Radio(
                      value: 0,
                      groupValue: procesoMaritimoAlstroemeriaContenedorControlTemperatura,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorControlTemperatura = value;
                        });
                      }),
                  Spacer(),
                  Radio(
                      value: 1,
                      groupValue: procesoMaritimoAlstroemeriaContenedorControlTemperatura,
                      onChanged: (value) {
                        setState(() {
                          procesoMaritimoAlstroemeriaContenedorControlTemperatura = value;
                        });
                      }),
                ],
              ),
              _procesoMaritimoObsevacionesllenadoContenedor(),
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

  Widget _procesoMaritimoObsevacionesHidratacion() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Observación hidratación',
          labelText: 'Observación hidratación',
        ),
        controller: procesoMaritimoObsevacionesHidratacionValue,
      ),
    );
  }

  Widget _procesoMaritimoObsevacionesEmpaque() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Observación empaque',
          labelText: 'Observación empaque',
        ),
        controller: procesoMaritimoObservacionesEmpaqueValue,
      ),
    );
  }

  Widget _procesoMaritimoObsevacionesTransferencia() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Observación transferencia',
          labelText: 'Observación transferencia',
        ),
        controller: procesoMaritimoObservacionesTransferenciaValue,
      ),
    );
  }

  Widget _procesoMaritimoObsevacionesPalletizado() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Observación palletizado',
          labelText: 'Observación palletizado',
        ),
        controller: procesoMaritimoObservacionesPalletizadoValue,
      ),
    );
  }

  Widget _procesoMaritimoObsevacionesllenadoContenedor() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Observación llenado contenedor',
          labelText: 'Observación llenado contenedor',
        ),
        controller: procesoMaritimoObservacionesLlenadoContenedorValue,
      ),
    );
  }

  Widget _procesoMaritimoObsevacionesRequerimientosCriticos() {
    return Container(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Observación requerimiento crítico',
          labelText: 'Observación requerimiento crítico',
        ),
        controller: procesoMaritimoObservacionesRequerimientosCriticosValue,
      ),
    );
  }

  _validarForm() async {
    if (
        destinosId >= 0 &&
        procesoMaritimoNumeroGuiaValue.text != '' &&
        procesoMaritimoRealizadoPorValue.text != '' &&
        procesoMaritimoAcompanamientoValue.text != '' &&
        postcosechaId != 0 &&
        clientesId != 0 ) {
      ProcesoMaritimoAlstroemeria procesoMaritimo = new ProcesoMaritimoAlstroemeria( 
        procesoMaritimoAlstroemeriaUsuarioControlId: 0,
        procesoMaritimoAlstroemeriaNumeroGuia : 0,
        procesoMaritimoAlstroemeriaDestinoId: 1,
        procesoMaritimoAlstroemeriaRealizadoPor: "",
        procesoMaritimoAlstroemeriaAcompanamiento: "",
        procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad : -1,
        procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta : -1,
        procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion : -1,
        procesoMaritimoAlstroemeriaClasificacionLongitudTallos : -1,
        procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal : -1,
        procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado : -1,
        procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood : -1,
        procesoMaritimoAlstroemeriaClasificacionLibreMaltrato : -1,
        procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso : -1,
        procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos : -1,
        procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo : -1,
        procesoMaritimoAlstroemeriaTratamientoBaldesTinas : -1,
        procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion : -1,
        procesoMaritimoAlstroemeriaTratamientoNivelSolucion : -1,
        procesoMaritimoAlstroemeriaTratamientoCambioSolucion : -1,
        procesoMaritimoAlstroemeriaTratamientoTiempoSala : -1,
        procesoMaritimoAlstroemeriaHidratacionNumeroRamos : -1,
        procesoMaritimoAlstroemeriaHidratacionRamosHidratados : -1,
        procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio : -1,
        procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado : -1,
        procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion : -1,
        procesoMaritimoAlstroemeriaEmpaqueEdadFlor : -1,
        procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos : -1,
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos : -1,
        procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento : -1,
        procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo : -1,
        procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad : -1,
        procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas : -1,
        procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue : -1,
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR : -1,
        procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto : -1,
        procesoMaritimoAlstroemeriaEmpaqueEmpacoHB : -1,
        procesoMaritimoAlstroemeriaTransporteTemperauraCajas : -1,
        procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio : -1,
        procesoMaritimoAlstroemeriaTransporteCamionTransporta : -1,
        procesoMaritimoAlstroemeriaTransporteTemperaturaCamion : -1,
        procesoMaritimoAlstroemeriaTransporteBuenaConexion : -1,
        procesoMaritimoAlstroemeriaTransporteThermoking : -1,
        procesoMaritimoAlstroemeriaTransporteCajasApiladas : -1,
        procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado : -1,
        procesoMaritimoAlstromeriaTransporteTemperaturaFurgon : -1,
        procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias : -1,
        procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros : -1,
        procesoMaritimoAlstroemeriaPalletizadoPalletsAltura : -1,
        procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido : -1,
        procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado : -1,
        procesoMaritimoAlstroemeriaContenedorGenset : -1,
        procesoMaritimoAlstroemeriaContenedorFechaFabricacion : -1,
        procesoMaritimoAlstroemeriaContenedorContenedorSeteo : -1,
        procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado : -1,
        procesoMaritimoAlstroemeriaContenedorContenedorLavado : -1,
        procesoMaritimoAlstroemeriaContenedorSachetsEthiblock : -1,
        procesoMaritimoAlstroemeriaContenedorCierreSellado : -1,
        procesoMaritimoAlstroemeriaContenedorControlTemperatura : -1,
        procesoMaritimoAlstroemeriaContenedorObservaciones : "",
        procesoMaritimoAlstroemeriaPalletizadoObservaciones : "",
        procesoMaritimoAlstroemeriaTransporteObservaciones : "",
        procesoMaritimoAlstroemeriaEmpaqueObservaciones : "",
        procesoMaritimoAlstroemeriaHidratacionObservaciones : "",
        procesoMaritimoAlstroemeriaTratamientoObservaciones : "",
        procesoMaritimoAlstroemeriaClasificacionObservaciones : "",
        procesoMaritimoAlstromeriaRecepcionObservaciones : "",
        procesoMaritimoAlstroemeriaFecha: DateTime.now(),
        postcosechaId: postcosechaId,
        clienteId: clientesId,
      );

      int procesoMaritimoId =
          await DatabaseProcesoMaritimoAlstroemeria.addProcesoMaritimoAlstroemeria(procesoMaritimo);
      if (procesoMaritimoId != 0) {
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _limpiarForm();
        _procesoMaritimoBloc.registroProcesoMaritimoStream();
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
    procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad = -1;
    procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta = -1;
    procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion = -1;
    procesoMaritimoAlstroemeriaClasificacionLongitudTallos = -1;
    procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal = -1;
    procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado = -1;
    procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood = -1;
    procesoMaritimoAlstroemeriaClasificacionLibreMaltrato = -1;
    procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso = -1;
    procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos = -1;
    procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo = -1;
    procesoMaritimoAlstroemeriaTratamientoBaldesTinas = -1;
    procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion = -1;
    procesoMaritimoAlstroemeriaTratamientoNivelSolucion = -1;
    procesoMaritimoAlstroemeriaTratamientoCambioSolucion = -1;
    procesoMaritimoAlstroemeriaTratamientoTiempoSala = -1;
    procesoMaritimoAlstroemeriaHidratacionNumeroRamos = -1;
    procesoMaritimoAlstroemeriaHidratacionRamosHidratados = -1;
    procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio = -1;
    procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado = -1;
    procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion = -1;
    procesoMaritimoAlstroemeriaEmpaqueEdadFlor = -1;
    procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos = -1;
    procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos = -1;
    procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento = -1;
    procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo = -1;
    procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad = -1;
    procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas = -1;
    procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue = -1;
    procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR = -1;
    procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto = -1;
    procesoMaritimoAlstroemeriaEmpaqueEmpacoHB = -1;
    procesoMaritimoAlstroemeriaTransporteTemperauraCajas = -1;
    procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio = -1;
    procesoMaritimoAlstroemeriaTransporteCamionTransporta = -1;
    procesoMaritimoAlstroemeriaTransporteTemperaturaCamion = -1;
    procesoMaritimoAlstroemeriaTransporteBuenaConexion = -1;
    procesoMaritimoAlstroemeriaTransporteThermoking = -1;
    procesoMaritimoAlstroemeriaTransporteCajasApiladas = -1;
    procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado = -1;
    procesoMaritimoAlstromeriaTransporteTemperaturaFurgon = -1;
    procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias = -1;
    procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros = -1;
    procesoMaritimoAlstroemeriaPalletizadoPalletsAltura = -1;
    procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido = -1;
    procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado = -1;
    procesoMaritimoAlstroemeriaContenedorGenset = -1;
    procesoMaritimoAlstroemeriaContenedorFechaFabricacion = -1;
    procesoMaritimoAlstroemeriaContenedorContenedorSeteo = -1;
    procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado = -1;
    procesoMaritimoAlstroemeriaContenedorContenedorLavado = -1;
    procesoMaritimoAlstroemeriaContenedorSachetsEthiblock = -1;
    procesoMaritimoAlstroemeriaContenedorCierreSellado = -1;
    procesoMaritimoAlstroemeriaContenedorControlTemperatura = -1;

    procesoMaritimoObsevacionesHidratacionValue.text = '';
    procesoMaritimoObservacionesEmpaqueValue.text = '';
    procesoMaritimoObservacionesTransferenciaValue.text = '';
    procesoMaritimoObservacionesPalletizadoValue.text = '';
    procesoMaritimoObservacionesLlenadoContenedorValue.text = '';
    procesoMaritimoObservacionesRequerimientosCriticosValue.text = '';

    procesoMaritimoNumeroGuiaValue.text = '';
    procesoMaritimoRealizadoPorValue.text = '';
    procesoMaritimoAcompanamientoValue.text = '';
    setState(() {});
  }
}
