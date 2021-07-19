import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/basedatos/database_circulo_calidad.dart';

import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/paginas/lista_ramos_page.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
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
  final totalRamos = TextEditingController();
  //final tallosRamos = TextEditingController();
  final ramosRechazados = TextEditingController();
  final ramosRevisados = TextEditingController();
  final derogacion = TextEditingController();
  final numeroReunionCirculoCalidad = TextEditingController();
  final codigoMesa = TextEditingController();
  final linea = TextEditingController();
  final supervisor1 = TextEditingController();
  final supervisor2 = TextEditingController();
  final comentarios = TextEditingController();
  final ordenModal = TextEditingController();
  circuloCalidad circulo = new circuloCalidad();
  String numeroOrden = '';

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = new List<AutoComplete>();
  String productoNombre = "";
  int productoId = 0;
  bool prodEnable = false;

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

  /*GlobalKey<ListaBusquedaState> _keyTipoCliente = GlobalKey();
  static List<AutoComplete> listaTipoCliente = new List<AutoComplete>();
  String clienteTipo = "";
  int clienteTipoID = 0;
  bool clienteTipoEnable = false;*/

  bool elite = false;
  _circuloCalidadPageState() {
    print("ingreso al circulad de calidad");
    elite = true;
    cargarRamos(1);
  }

  _guardarReporteCirculoCalidad() async {
    /*
    //ramos.ramosNumeroOrden = numeroOrden;
    
    circulo.ramosRevisados = int.parse(totalRamos.text);
    circulo.calidadReunion = 0;
    circulo.problemaId2 = clienteId;
    circulo.problemaId3 = productoId;
    circulo.clienteId2 = int.parse(ramosRevisados.text);
    circulo.clienteId1 = int.parse(ramosRechazados.text);
    //ramos.ramosTallos = int.parse(tallosRamos.text);
    circulo.ramosRechazados =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    circulo.productoId1 = derogacion.text;
    circulo.postcosechaId = postcosechaId;
    //ramos.ramosMarca = marca.text;
    circulo.problemaId4 = 0;
    if (circulo.circuloCalidadId != null) {
      await DatabaseRamos.updateRamos(circulo);
    } else {
      circulo.productoId2 = DateTime.now().millisecondsSinceEpoch;
      circulo.circuloCalidadId await DatabaseRamos.addRamos(circulo);
    }*/
  }

  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(
          'Número de orden debe ser escaneado \nTodos los números deben ser enteros'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  cargarRamos(int ramosId) async {
    print("ingreso a cargar la informacion");
    listaProducto = List<AutoComplete>();
    listaCliente = List<AutoComplete>();
    listaPostcosecha = List<AutoComplete>();
    listaCliente2 = List<AutoComplete>();
    int valor = 0;
    if (elite) {
      valor = 1;
    }
    print("va a cargar");
    List<Producto> productos = List<Producto>();
    productos = await DatabaseProducto.getAllProductos(valor);
    print("cantidad de productos: " + productos.length.toString());
    productos.forEach((element) {
      listaProducto.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
    });

    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(valor);
    clientes.forEach((element) {
      listaCliente.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });
    List<Cliente> clientes2 = List();
    clientes2 = await DatabaseCliente.getAllCliente(valor);
    clientes2.forEach((element) {
      listaCliente2.add(
          AutoComplete(id: element.clienteId, nombre: element.clienteNombre));
    });

    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });
    print("postcosecha cargada: " + listaPostcosecha.length.toString());

    setState(() {
      print("ingreso ");
      prodEnable = true;
      clientEnable = true;
      clientEnable2 = true;
      postcosechaEnable = true;
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
                    // _tipoCliente(),
                    // _numeroOrden(),
                    _postcosecha(),
                    _cliente1(),
                    _cliente2(),
                    _producto1(),
                    //_producto2(),

                    _cantidadRamosRevisados(),
                    _cantidadRamosRechazados(),
                    _numeroDeReunionCirculoCalidad(),
                    // problema1
                    //problema2

                    //_cantidadRamos(), //ramos revisados
                    //_cantidadTallos(),
                    _codigoMesa(),
                    _linea(),
                    _supervisor1(),
                    _supervisor2(),
                    // _derogacion(),
                    _comentarios(),
                    //_botonSiguiente(context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  /* Widget _tipoCliente() {
    return Container(
      width: 250,
      height: 90,
      child: clientEnable
          ? ListaBusqueda(
              key: _keyCliente,
              lista: listaTipoCliente,
              hintText: "Cliente",
              valorDefecto: clienteTipo,
              hintSearchText: "Seleccione el tipo del cliente",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete clienteTipo = listaCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId = clienteTipo.id;
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }*/

  Widget _numeroOrden() {
    return Container(
      height: 100,
      width: 200,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: numeroOrden == ''
                ? RaisedButton(
                    onPressed: () {
                      _bottomSheetOrden(context);
                    },
                    color: Colors.red,
                    child: Text('Ingresar Orden'),
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                  )
                : Container(
                    child: Text(
                      numeroOrden == null ? "" : numeroOrden,
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          numeroOrden == ''
              ? SizedBox()
              : RaisedButton(
                  shape: CircleBorder(),
                  color: Colors.red,
                  child: Icon(
                    Icons.create,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _bottomSheetOrden(context);
                  })
        ],
      ),
    );
  }

  // Widget _cantidadRamos() {
  //   return Container(
  //     width: 200,
  //     height: 90,
  //     child: TextField(
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //           hintText: 'Ramos revisados', labelText: 'Ramos Revisados'),
  //       controller: totalRamos,
  //     ),
  //   );
  // }

  // Widget _cantidadTallos() {
  //   return Container(
  //     width: 200,
  //     height: 90,
  //     child: TextField(
  //       keyboardType: TextInputType.number,
  //       decoration: InputDecoration(
  //           hintText: 'Tallos por ramo', labelText: 'Tallos por ramo'),
  //       controller: tallosRamos,
  //     ),
  //   );
  // }

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

  // Widget _derogacion() {
  //   return Container(
  //     width: 200,
  //     height: 90,
  //     child: TextField(
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         hintText: 'Derogacion',
  //         labelText: 'Derogacion',
  //       ),
  //       controller: derogacion,
  //     ),
  //   );
  // }

  /*Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          if (_validarRamos()) {
            //&&_validarTallos
            final util = Utilidades();
            if (numeroOrden != '' &&
                util.isNumberEntero(totalRamos.text) &&
                //util.isNumberEntero(tallosRamos.text) &&
                derogacion.text != '' &&
                util.isNumberEntero(ramosRechazados.text) &&
                util.isNumberEntero(ramosRevisados.text) &&
                clienteId != 0 &&
                productoId != 0 &&
                numeroReunionCirculoCalidad.text != '' &&
                codigoMesa.text != '' &&
                linea.text != '' &&
                supervisor1.text != '' &&
                supervisor2.text != '' &&
                comentarios.text != '' &&
                postcosechaId != 0) {
              await _guardarReporteCirculoCalidad()();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => circuloCalidadPage()));
            } else {
              _showSnackBar();
            }
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
            children: <Widget>[
              Text('Siguiente'),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
*/
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
              key: _keyProducto,
              lista: listaProducto,
              hintText: "Producto2",
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
                clienteId = cliente2.id;
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

  bool _validarRamos() {
    if (ramosRechazados.text == '' ||
        ramosRevisados == '' ||
        totalRamos.text == '') {
      mostrarSnackbar('Llenar Ramos', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosRechazados.text) < int.parse(ramosRevisados.text)) {
      mostrarSnackbar('Error en Ramos Elaborados', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosRevisados.text) < int.parse(totalRamos.text)) {
      mostrarSnackbar('Error en Ramos a revisar', null, scaffoldKey);
      return false;
    }

    return true;
  }

  // bool _validarTallos() {
  //   if (tallosRamos.text == '') {
  //     mostrarSnackbar('Llenar los tallos por ramo', null, scaffoldKey);
  //     return false;
  //   }
  //   return true;
  // }

  _bottomSheetOrden(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.red,
                  ),
                  title: Text('Codigo QR'),
                  onTap: () async {
                    Navigator.maybePop(context);
                    try {
                      numeroOrden = await scanner.scan();
                    } catch (e) {
                      numeroOrden = "";
                    }

                    setState(() {});
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.font_download,
                    color: Colors.red,
                  ),
                  title: Text('Ingresar Orden'),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                              title: Text("Ingresa el número de orden"),
                              content: TextField(
                                controller: ordenModal,
                                decoration:
                                    InputDecoration(hintText: '# de Orden'),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Guardar'),
                                  onPressed: () {
                                    numeroOrden = ordenModal.text;
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
