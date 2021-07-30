import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/modelos/tipoCliente.dart';
import 'package:hcgcalidadapp/src/paginas/lista_ramos_page.dart';
import 'package:hcgcalidadapp/src/providers/TipoClienteProvider.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class RamosElitePage extends StatefulWidget {
  bool valor;
  int ramosId;
  RamosElitePage(bool valor, int ramosId) {
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _RamosElitePageState createState() =>
      _RamosElitePageState(this.valor, this.ramosId);
}

class _RamosElitePageState extends State<RamosElitePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final totalRamos = TextEditingController();
  final tallosRamos = TextEditingController();
  final ramosADespachar = TextEditingController();
  final ramosElaborados = TextEditingController();
  final derogacion = TextEditingController();
  final marca = TextEditingController();
  final ordenModal = TextEditingController();
  ControlRamos ramos = new ControlRamos();
  String numeroOrden = '';

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = new List<AutoComplete>();
  String productoNombre = "";
  int productoId = 0;
  bool prodEnable = false;

  GlobalKey<ListaBusquedaState> _keyTipoCliente = GlobalKey();
  static List<AutoComplete> listaTipoCliente = new List<AutoComplete>();
  String tipoClienteNombre = "";
  int tipoClienteId = 0;
  bool clientTipoEnable = false;

  GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  int clienteId = 0;

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;

  bool elite = false;
  _RamosElitePageState(bool valor, int ramosId) {
    elite = valor;
    derogacion.text = 'NO APLICA';
    cargarRamos(ramosId);
  }

  _guardarReporteRamos() async {
    ramos.ramosNumeroOrden = numeroOrden;
    ramos.ramosTotal = int.parse(totalRamos.text);
    ramos.ramosAprobado = 0;
    ramos.clienteId = clienteId;
    ramos.productoId = productoId;
    ramos.ramosElaborados = int.parse(ramosElaborados.text);
    ramos.ramosDespachar = int.parse(ramosADespachar.text);
    ramos.ramosTallos = int.parse(tallosRamos.text);
    ramos.ramosFecha =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    ramos.ramosDerogado = derogacion.text;
    ramos.postcosechaId = postcosechaId;
    ramos.ramosMarca = marca.text;
    ramos.usuarioId = 0;
    if (ramos.controlRamosId != null) {
      await DatabaseRamos.updateRamos(ramos);
    } else {
      ramos.ramosDesde = DateTime.now().millisecondsSinceEpoch;
      ramos.controlRamosId = await DatabaseRamos.addRamos(ramos);
    }
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
    listaProducto = List<AutoComplete>();
    listaPostcosecha = List<AutoComplete>();
    listaTipoCliente = List<AutoComplete>();

    int valor = 0;
    if (elite) {
      valor = 1;
    }
    List<Producto> productos = List();
    productos = await DatabaseProducto.getAllProductos(valor);
    productos.forEach((element) {
      listaProducto.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
    });

    List<TipoCliente> tipoClientes = List();
    tipoClientes = await DatabaseEcuador.getAllTipoCliente();
    print("tiupo cliente: " + tipoClientes.length.toString());
    tipoClientes.forEach((element) {
      listaTipoCliente.add(AutoComplete(
          id: element.tipoClienteId, nombre: element.tipoClienteNombre));
    });

    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });

    setState(() {
      prodEnable = true;
      postcosechaEnable = true;
      clientTipoEnable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String value2= "";
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Ramos Elite'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Nombre"),
                      onSaved: (value){
                        value2 =  value;
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return "Llene este campo";
                        }
                      },
                    ),
                    _numeroOrden(),
                    _tipoCliente(),
                    _cliente(),
                    _producto(),
                    _postcosecha(),
                    _marca(),
                    _cantidadRamosDespachar(),
                    _cantidadRamosElaborados(),
                    _cantidadRamos(),
                    _cantidadTallos(),
                    _derogacion(),
                    _botonSiguiente(context),
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

  Widget _cantidadRamos() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Ramos a revisar', labelText: 'Ramos a revisar'),
        controller: totalRamos,
      ),
    );
  }

  Widget _cantidadTallos() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Tallos por ramo', labelText: 'Tallos por ramo'),
        controller: tallosRamos,
      ),
    );
  }

  Widget _cantidadRamosDespachar() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos a despachar',
          labelText: 'Ramos a despachar',
        ),
        controller: ramosADespachar,
      ),
    );
  }

  Widget _cantidadRamosElaborados() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos elaborados',
          labelText: 'Ramos elaborados',
        ),
        controller: ramosElaborados,
      ),
    );
  }

  Widget _derogacion() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Derogacion',
          labelText: 'Derogacion',
        ),
        controller: derogacion,
      ),
    );
  }

  Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          if (_validarRamos() && _validarTallos()) {
            final util = Utilidades();
            if (numeroOrden != '' &&
                util.isNumberEntero(totalRamos.text) &&
                util.isNumberEntero(tallosRamos.text) &&
                derogacion.text != '' &&
                util.isNumberEntero(ramosADespachar.text) &&
                util.isNumberEntero(ramosElaborados.text) &&
                clienteId != 0 &&
                productoId != 0 &&
                marca.text != '' &&
                postcosechaId != 0) {
              await _guardarReporteRamos();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListaRamosPage(ramos)));
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

  Widget _producto() {
    return Container(
      width: 250,
      height: 90,
      child: prodEnable
          ? ListaBusqueda(
              key: _keyProducto,
              lista: listaProducto,
              hintText: "Producto",
              valorDefecto: productoNombre,
              hintSearchText: "Escriba el nombre del producto",
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

  Widget _tipoCliente() {
    final listaClienteProvider = Provider.of<TipoClienteProvide>(context);
    return Container(
      width: 250,
      height: 90,
      child: clientTipoEnable
          ? ListaBusqueda(
              key: _keyTipoCliente,
              lista: listaTipoCliente,
              hintText: "Tipo Cliente",
              valorDefecto: tipoClienteNombre,
              hintSearchText: "Seleccione el tipo de cliente",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete tipoCliente = listaTipoCliente.firstWhere((item) {
                  return item.nombre == value;
                });
                listaClienteProvider.listaClientes = tipoCliente.id;
                listaClienteProvider.clienteNombre = tipoCliente.nombre;
              })
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _cliente() {
    final listaClienteProvider = Provider.of<TipoClienteProvide>(context);
    return Container(
      width: 250,
      height: 90,
      child: _listBus(listaClienteProvider)
    );
  }

  Widget _listBus(listaClienteProvider) {
    return ListaBusqueda(
              key: _keyCliente,
              lista: listaClienteProvider.listaClientess,
              hintText: listaClienteProvider.nombreCliente,
              valorDefecto: listaClienteProvider.clienteNombre,
              hintSearchText: "Escriba el nombre del cliente",
              icon: Icon(Icons.supervised_user_circle),
              width: 200.0,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                AutoComplete cliente =
                    listaClienteProvider.listaClientess.firstWhere((item) {
                  return item.nombre == value;
                });
                clienteId = cliente.id;
              },
            );
  }

  Widget _postcosecha() {
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

  Widget _marca() {
    final listaClienteProvider = Provider.of<TipoClienteProvide>(context);
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Marca',
          labelText: 'Marca',
        ),
        controller: marca,
      ),
    );
  }

  bool _validarRamos() {
    if (ramosADespachar.text == '' ||
        ramosElaborados.text == '' ||
        totalRamos.text == '') {
      mostrarSnackbar('Llenar Ramos', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosADespachar.text) < int.parse(ramosElaborados.text)) {
      mostrarSnackbar('Error en Ramos Elaborados', null, scaffoldKey);
      return false;
    }
    if (int.parse(ramosElaborados.text) < int.parse(totalRamos.text)) {
      mostrarSnackbar('Error en Ramos a revisar', null, scaffoldKey);
      return false;
    }

    return true;
  }

  bool _validarTallos() {
    if (tallosRamos.text == '') {
      mostrarSnackbar('Llenar los tallos por ramo', null, scaffoldKey);
      return false;
    }
    return true;
  }

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
