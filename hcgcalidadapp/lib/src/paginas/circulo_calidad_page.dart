import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/basedatos/database_circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class circuloCalidadPage extends StatefulWidget {
  bool valor;
  int ramosId;

  circuloCalidadPage() {
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _circuloCalidadPageState createState() => _circuloCalidadPageState();
}

class _circuloCalidadPageState extends State<circuloCalidadPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var supervisor1Check = ['Regular', 'Bueno', 'Excelente'];
  var supervisor2Check = ['Regular', 'Bueno', 'Excelente'];
  Map<String, bool> supervisorListValues = {};
  Map<String, bool> supervisorListValues2 = {};
  final ramosRechazados = TextEditingController();
  final ramosRevisados = TextEditingController();
  final derogacion = TextEditingController();
  final numeroReunionCirculoCalidad = TextEditingController();
  final codigoMesa = TextEditingController();
  final linea = TextEditingController();
  final supervisor1 = TextEditingController();
  final supervisor2 = TextEditingController();
  final variedad1 = TextEditingController();
  final variedad2 = TextEditingController();
  final comentarios = TextEditingController();
  final ordenModal = TextEditingController();

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = new List<AutoComplete>();
  String productoNombre = "";
  int productoId = 0;
  bool prodEnable = false;

  GlobalKey<ListaBusquedaState> _keyProducto2 = GlobalKey();
  static List<AutoComplete> listaProducto2 = new List<AutoComplete>();
  String productoNombre2 = "";
  int productoId2 = 0;
  bool prodEnable2 = false;

  GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  static List<AutoComplete> listaCliente = new List<AutoComplete>();
  String clienteNombre = "";
  int clienteId = 0;
  bool clientEnable = false;

  GlobalKey<ListaBusquedaState> _keyCliente2 = GlobalKey();
  static List<AutoComplete> listaCliente2 = new List<AutoComplete>();
  String clienteNombre2 = "";
  int clienteId2 = 0;
  bool clientEnable2 = false;

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;
  //PROBLEMAS
  GlobalKey<ListaBusquedaState> _keyProblema1 = GlobalKey();
  static List<AutoComplete> listaProblema1 = new List<AutoComplete>();
  String problema1Nombre = "";
  int problema1Id = 0;
  bool problema1Enable = false;

  GlobalKey<ListaBusquedaState> _keyProblema2 = GlobalKey();
  static List<AutoComplete> listaProblema2 = new List<AutoComplete>();
  String problema2Nombre = "";
  int problema2Id = 0;
  bool problema2Enable = false;

  GlobalKey<ListaBusquedaState> _keyProblema3 = GlobalKey();
  static List<AutoComplete> listaProblema3 = new List<AutoComplete>();
  String problema3Nombre = "";
  int problema3Id = 0;
  bool problema3Enable = false;
  GlobalKey<ListaBusquedaState> _keyProblema4 = GlobalKey();
  static List<AutoComplete> listaProblema4 = new List<AutoComplete>();
  String problema4Nombre = "";
  int problema4Id = 0;
  bool problema4Enable = false;

  GlobalKey<ListaBusquedaState> _keyProblema5 = GlobalKey();
  static List<AutoComplete> listaProblema5 = new List<AutoComplete>();
  String problema5Nombre = "";
  int problema5Id = 0;
  bool problema5Enable = false;

  bool elite = false;
  bool problemas = false;
  _circuloCalidadPageState() {
    elite = true;
    cargarRamos(1);
  }

  _guardarReporteCirculoCalidad() async {
    circuloCalidad circulo = new circuloCalidad();
    circulo.ramosRevisados = int.parse(ramosRevisados.text);
    circulo.ramosRechazados = int.parse(ramosRevisados.text);
    circulo.calidadReunion = int.parse(numeroReunionCirculoCalidad.text);
    circulo.problemaId1 = problema1Id;
    circulo.problemaId2 = problema2Id;
    circulo.problemaId3 = problema3Id;
    circulo.problemaId4 = problema4Id;
    circulo.problemaId5 = problema5Id;
    circulo.clienteId1 = clienteId;
    circulo.clienteId2 = clienteId2;
    circulo.productoId1 = productoId;
    circulo.productoId2 = productoId2;
    circulo.postcosechaId = postcosechaId;
    circulo.codigoMesa = int.parse(codigoMesa.text);
    circulo.linea = int.parse(linea.text);
    circulo.supervisor1 = supervisor1.text;
    circulo.supervisor2 = supervisor2.text;
    circulo.supervisorcheck1 = "Bueno";
    circulo.supervisorcheck2 = "Bueno";
    circulo.comentarios = comentarios.text;
    circulo.variedad1 = variedad1.text;
    circulo.variedad2 = variedad2.text;
    if (circulo.circuloCalidadId != null) {
      await DatabaseCirculoCalidad.updateCirculoCalidad(circulo);
    } else {
      await DatabaseCirculoCalidad.addcirculoCalidad(circulo);
    }
  }

  bool _validarCirculoCalidad() {
    if (ramosRechazados.text == '' ||
        ramosRevisados.text == '' ||
        variedad1.text == '' ||
        variedad2.text == '' ||
        numeroReunionCirculoCalidad.text == '' ||
        codigoMesa.text == '' ||
        linea.text == '' ||
        supervisor1.text == '' ||
        supervisor2.text == '' ||
        comentarios.text == '' ||
        postcosechaId == 0 ||
        clienteId == 0 ||
        clienteId2 == 0 ||
        productoId == 0 ||
        productoId2 == 0 ||
        problema1Id == 0) {
      mostrarSnackbar(
          'Llenar el formulario Circulo Calidad', null, scaffoldKey);
      return false;
    }
    final util = Utilidades();
    if (!util.isNumberEntero(ramosRechazados.text)) {
      mostrarSnackbar(
          'Error: Ramos rechazados no es un numero entero', null, scaffoldKey);
      return false;
    }
    if (!util.isNumberEntero(ramosRevisados.text)) {
      mostrarSnackbar(
          'Error: Ramos revisados no es un numero entero', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosRechazados.text) > int.parse(ramosRevisados.text)) {
      mostrarSnackbar(
          'Error: Informe incorrecto ramos rechazados superior a ramos revisados',
          null,
          scaffoldKey);
      return false;
    }
    return true;
  }

  cargarRamos(int ramosId) async {
    listaProducto = List<AutoComplete>();
    listaProducto2 = List<AutoComplete>();
    listaCliente = List<AutoComplete>();
    listaPostcosecha = List<AutoComplete>();
    listaCliente2 = List<AutoComplete>();
    listaProblema1 = List<AutoComplete>();
    listaProblema2 = List<AutoComplete>();
    listaProblema3 = List<AutoComplete>();
    listaProblema4 = List<AutoComplete>();
    listaProblema5 = List<AutoComplete>();

    int valor = 0;
    if (elite) {
      valor = 1;
    }
    //PROBLEMAS
    List<FalenciaRamos> problema1 = List();
    problema1 = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    problema1.forEach((element) {
      listaProblema1.add(AutoComplete(
          id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
      listaProblema2.add(AutoComplete(
          id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
      listaProblema3.add(AutoComplete(
          id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
      listaProblema4.add(AutoComplete(
          id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
      listaProblema5.add(AutoComplete(
          id: element.falenciaRamosId, nombre: element.falenciaRamosNombre));
    });

    List<Producto> productos = List<Producto>();
    productos = await DatabaseProducto.getAllProductos(valor);
    productos.forEach((element) {
      listaProducto.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
      listaProducto2.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
    });

    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(valor);
    clientes.forEach((element) {
      listaCliente.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
      listaCliente2.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });

    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });

    setState(() {
      prodEnable = true;
      prodEnable2 = true;
      clientEnable = true;
      clientEnable2 = true;
      postcosechaEnable = true;
      problema1Enable = true;
      problema2Enable = true;
      problema3Enable = true;
      problema4Enable = true;
      problema5Enable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('CIRCULO DE CALIDAD'),
      ),
      body: Container(
          width: double.infinity,
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _postcosecha(),
                    _cantidadRamosRevisados(),
                    _cantidadRamosRechazados(),
                    _numeroDeReunionCirculoCalidad(),
                    _problema1(),
                    _problema2(),
                    _problema3(),
                    _problema4(),
                    _problema5(),
                    _cliente1(),
                    _cliente2(),
                    _producto1(),
                    _producto2(),
                    _codigoMesa(),
                    _linea(),
                    _variedad1(),
                    _variedad2(),
                    _supervisor1(),
                    _supervisor2(),
                    Divider(),
                    Column(children: [
                      Text('Evaluacion supervisor#1',
                          style: Theme.of(context).textTheme.subtitle1)
                    ]),
                    Column(children: _superVisor1Check()),
                    Divider(),
                    Column(children: [
                      Text('Evaluacion supervisor#2',
                          style: Theme.of(context).textTheme.subtitle1)
                    ]),
                    Column(children: _superVisor2Check()),
                    _comentarios(),
                    _botonGuardar(context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Column(
                    //_botonGuardar(context),
                    )
              ],
            ),
          )),
    );
  }

  Widget _cantidadRamosRechazados() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos Rechazados',
          labelText: 'Ramos Rechazados',
        ),
        controller: ramosRechazados,
      ),
    );
  }

  Widget _cantidadRamosRevisados() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos Revisados',
          labelText: 'Ramos Revisados',
        ),
        controller: ramosRevisados,
      ),
    );
  }

  _botonGuardar(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          if (_validarCirculoCalidad()) {
            await _guardarReporteCirculoCalidad();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => circuloCalidadPage()));
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.red,
        textColor: Colors.white,
        child: Container(
          height: 60,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('Guardar'), Icon(Icons.save)],
          ),
        ),
      ),
    );
  }

  Widget _problema1() {
    return Container(
      width: 250,
      height: 90,
      child: problema1Enable
          ? ListaBusqueda(
              key: _keyProblema1,
              lista: listaProblema1,
              hintText: "Problema1",
              valorDefecto: problema1Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema1 = listaProblema1.firstWhere((item) {
                  return item.nombre == value;
                });
                problema1Id = problema1.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _problema2() {
    return Container(
      width: 250,
      height: 90,
      child: problema2Enable
          ? ListaBusqueda(
              key: _keyProblema2,
              lista: listaProblema2,
              hintText: "Problema2",
              valorDefecto: problema2Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema2 = listaProblema2.firstWhere((item) {
                  return item.nombre == value;
                });
                problema2Id = problema2.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _problema3() {
    return Container(
      width: 250,
      height: 90,
      child: problema3Enable
          ? ListaBusqueda(
              key: _keyProblema3,
              lista: listaProblema3,
              hintText: "Problema3",
              valorDefecto: problema3Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema3 = listaProblema3.firstWhere((item) {
                  return item.nombre == value;
                });
                problema3Id = problema3.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _problema4() {
    return Container(
      width: 250,
      height: 90,
      child: problema4Enable
          ? ListaBusqueda(
              key: _keyProblema4,
              lista: listaProblema4,
              hintText: "Problema4",
              valorDefecto: problema4Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema4 = listaProblema4.firstWhere((item) {
                  return item.nombre == value;
                });
                problema4Id = problema4.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _problema5() {
    return Container(
      width: 250,
      height: 90,
      child: problema5Enable
          ? ListaBusqueda(
              key: _keyProblema5,
              lista: listaProblema5,
              hintText: "Problema5",
              valorDefecto: problema5Nombre,
              hintSearchText: "Selecione el problema",
              icon: Icon(Icons.report_problem),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete problema5 = listaProblema5.firstWhere((item) {
                  return item.nombre == value;
                });
                problema5Id = problema5.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _producto1() {
    return Container(
      width: 250,
      height: 90,
      child: prodEnable
          ? ListaBusqueda(
              key: _keyProducto,
              lista: listaProducto,
              hintText: "Producto1",
              valorDefecto: productoNombre,
              hintSearchText: "Selecione el nombre del producto",
              icon: Icon(Icons.local_florist),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete producto = listaProducto.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId = producto.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _producto2() {
    return Container(
      width: 250,
      height: 90,
      child: prodEnable
          ? ListaBusqueda(
              key: _keyProducto2,
              lista: listaProducto2,
              hintText: "Producto2",
              valorDefecto: productoNombre2,
              hintSearchText: "Selecione el nombre del producto",
              icon: Icon(Icons.local_florist),
              width: 200.0,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                AutoComplete producto2 = listaProducto.firstWhere((item) {
                  return item.nombre == value;
                });
                productoId2 = producto2.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _cliente1() {
    return Container(
      width: 250,
      height: 90,
      child: clientEnable
          ? ListaBusqueda(
              key: _keyCliente,
              lista: listaCliente,
              hintText: "Cliente1",
              valorDefecto: clienteNombre,
              hintSearchText: "Seleccione el nombre del cliente1",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete cliente = listaCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId = cliente.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _cliente2() {
    return Container(
      width: 250,
      height: 90,
      child: clientEnable2
          ? ListaBusqueda(
              key: _keyCliente2,
              lista: listaCliente2,
              hintText: "Cliente2",
              valorDefecto: clienteNombre2,
              hintSearchText: "Seleccione el nombre del cliente2",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete cliente2 = listaCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId2 = cliente2.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _postcosecha() {
    print("postcosecha: " + postcosechaEnable.toString());
    return Container(
      width: 250,
      height: 90,
      child: postcosechaEnable
          ? ListaBusqueda(
              key: _keyPostcosecha,
              lista: listaPostcosecha,
              hintText: "Post Cosecha",
              valorDefecto: postcosechaNombre,
              hintSearchText: "Escriba el nombre de Postcosecha",
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

  Widget _numeroDeReunionCirculoCalidad() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Numero de reunion',
          labelText: 'Numero de reunion',
        ),
        controller: numeroReunionCirculoCalidad,
      ),
    );
  }

  Widget _codigoMesa() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Codigo de Mesa',
          labelText: 'Codigo de mesa',
        ),
        controller: codigoMesa,
      ),
    );
  }

  Widget _linea() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Linea',
          labelText: 'Linea',
        ),
        controller: linea,
      ),
    );
  }

  Widget _supervisor1() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Supervisor1',
          labelText: 'Supervisor1',
        ),
        controller: supervisor1,
      ),
    );
  }

  Widget _variedad1() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Variedad1',
          labelText: 'Variedad1',
        ),
        controller: variedad1,
      ),
    );
  }

  Widget _variedad2() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Variedad2',
          labelText: 'Variedad2',
        ),
        controller: variedad2,
      ),
    );
  }

  Widget _supervisor2() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Supervisor2',
          labelText: 'Supervispor2',
        ),
        controller: supervisor2,
      ),
    );
  }

  Widget _comentarios() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Comentarios',
          labelText: 'Comentarios',
        ),
        controller: comentarios,
      ),
    );
  }

  List<Widget> _superVisor2Check() {
    return (supervisor2Check
        .map((label) => CheckboxListTile(
            title: Text(label),
            value: supervisorListValues2[label] ?? false,
            onChanged: (newValue) {
              setState(() {
                if (supervisorListValues2[label] == null) {
                  supervisorListValues2[label] = true;
                } else {
                  //supervisor1Check[label]==false;
                }
                supervisorListValues2[label] = !supervisorListValues2[label];
              });
            }))
        .toList());
  }

  List<Widget> _superVisor1Check() {
    return (supervisor1Check
        .map((label) => CheckboxListTile(
            title: Text(label),
            value: supervisorListValues[label] ?? false,
            onChanged: (newValue) {
              setState(() {
                if (supervisorListValues[label] == null) {
                  supervisorListValues[label] = true;
                } else {
                  //supervisor1Check[label]==false;
                }
                supervisorListValues[label] = !supervisorListValues[label];
              });
            }))
        .toList());
  }
}
