import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/control_banda.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/modelos/tipoCliente.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
import 'package:hcgcalidadapp/src/paginas/lista_banda_ramos_page.dart';
import 'package:hcgcalidadapp/src/paginas/problemas_banda_page.dart';
import 'package:hcgcalidadapp/src/providers/TipoClienteProvider.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class BandaPage extends StatefulWidget {
  bool valor;
  int ramosId;
  BandaPage(bool valor, int ramosId) {
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _BandaPageState createState() => _BandaPageState(this.valor, this.ramosId);
}

class _BandaPageState extends State<BandaPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final totalRamos = TextEditingController();
  final tallosRamos = TextEditingController();
  final ramosADespachar = TextEditingController();
  final ramosElaborados = TextEditingController();
  final derogacion = TextEditingController();
  final marca = TextEditingController();
  final ordenModal = TextEditingController();
  ControlBanda ramosBanda = new ControlBanda();
  String numeroOrden = '';

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = [];
  String productoNombre = "";
  int productoId = 0;
  bool prodEnable = false;

  GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  int clienteId = 0;

  GlobalKey<ListaBusquedaState> _keyTipoCliente = GlobalKey();
  static List<AutoComplete> listaTipoCliente = new List<AutoComplete>();
  String tipoClienteNombre = "";
  int tipoClienteId = 0;
  bool clientTipoEnable = false;

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = [];
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool postcosechaEnable = false;

  GlobalKey<ListaBusquedaState> _keyTipo = GlobalKey();
  static List<AutoComplete> listaTipos = [];
  String tipoNombre = "";
  int tipoId = 0;
  bool tipoEnable = false;

  bool elite = false;
  _BandaPageState(bool valor, int ramosId) {
    elite = valor;
    derogacion.text = 'NO APLICA';
    cargarRamos(ramosId);
  }

  _guardarReporteRamos() async {
    ramosBanda.ramosNumeroOrden = numeroOrden;
    ramosBanda.ramosTotal = int.parse(totalRamos.text);
    ramosBanda.ramosAprobado = 0;
    ramosBanda.clienteId = clienteId;
    ramosBanda.productoId = productoId;
    ramosBanda.ramosElaborados = int.parse(ramosElaborados.text);
    ramosBanda.ramosDespachar = int.parse(ramosADespachar.text);
    ramosBanda.ramosTallos = int.parse(tallosRamos.text);
    ramosBanda.ramosFecha =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    ramosBanda.ramosDerogado = derogacion.text;
    ramosBanda.postcosechaId = postcosechaId;
    ramosBanda.ramosMarca = marca.text;
    ramosBanda.usuarioId = 0;
    ramosBanda.tipoId = tipoId;
    if (ramosBanda.controlRamosId != null) {
      await DatabaseBanda.updateBandas(ramosBanda);
    } else {
      ramosBanda.ramosDesde = DateTime.now().millisecondsSinceEpoch;
      ramosBanda.controlRamosId = await DatabaseBanda.addBandas(ramosBanda);
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
    listaProducto = [];
    listaPostcosecha = [];
    listaTipos = [];
    listaTipoCliente = [];
    int valor = 0;
    if (elite) {
      valor = 1;
    }
    List<Producto> productos = [];
    productos = await DatabaseProducto.getAllProductos(valor);
    productos.forEach((element) {
      listaProducto.add(
          AutoComplete(id: element.productoId, nombre: element.productoNombre));
    });

    List<TipoCliente> tipoClientes = List();
    tipoClientes = await DatabaseEcuador.getAllTipoCliente();
    tipoClientes.forEach((element) {
      listaTipoCliente.add(AutoComplete(
          id: element.tipoClienteId, nombre: element.tipoClienteNombre));
    });

    List<PostCosecha> postcosechas = [];
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });
    List<TipoControl> tipoControl = List();
    tipoControl = await DatabaseEcuador.getAllTipoControl(1);
    tipoControl.forEach((element) {
      listaTipos.add(AutoComplete(
          id: element.tipoControlId, nombre: element.tipoControlNombre));
    });

    setState(() {
      prodEnable = true;
      postcosechaEnable = true;
      tipoEnable = true;
      clientTipoEnable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Final banda - pesca'),
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
                    SizedBox(
                      height: 10,
                    ),
                    _numeroOrden(),
                    _tipoDeControl(),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
      width: MediaQuery.of(context).size.width * 0.85,
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
      width: MediaQuery.of(context).size.width * 0.85,
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
      width: MediaQuery.of(context).size.width * 0.85,
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

  Widget _tipoDeControl() {
    return Container(
        child: tipoEnable
            ? ListaBusqueda(
                key: _keyTipo,
                lista: listaTipos,
                hintText: "Tipos",
                valorDefecto: tipoNombre,
                hintSearchText: "Escriba el nombre del tipo de control",
                icon: Icon(Icons.report_outlined),
                width: MediaQuery.of(context).size.width * 0.75,
                style: TextStyle(fontSize: 15),
                parentAction: (value) {
                  if (value != null && value != "") {
                    AutoComplete tip = listaTipos.firstWhere((item) {
                      return item.nombre == value;
                    });
                    tipoId = tip.id;
                  }
                },
              )
            : Container(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _cantidadRamosElaborados() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
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
      width: MediaQuery.of(context).size.width * 0.85,
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
      padding: const EdgeInsets.only(top: 10),
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
                postcosechaId != 0 &&
                tipoId != 0) {
              await _guardarReporteRamos();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListaBandasRamosPage(ramosBanda)));
            } else {
              _showSnackBar();
            }
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.red,
        textColor: Colors.white,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Siguiente '),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

  Widget _producto() {
    return Container(
      child: prodEnable
          ? ListaBusqueda(
              key: _keyProducto,
              lista: listaProducto,
              hintText: "Producto",
              valorDefecto: productoNombre,
              hintSearchText: "Escriba el nombre del producto",
              icon: Icon(Icons.local_florist),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete producto = listaProducto.firstWhere((item) {
                    return item.nombre == value;
                  });
                  productoId = producto.id;
                }
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _cliente() {
    final listaClienteProvider = Provider.of<TipoClienteProvide>(context);
    return Container(child: _listBus(listaClienteProvider));
  }

  Widget _listBus(listaClienteProvider) {
    return ListaBusqueda(
      key: _keyCliente,
      lista: listaClienteProvider.listaClientess,
      hintText: listaClienteProvider.nombreCliente,
      valorDefecto: listaClienteProvider.clienteNombre,
      hintSearchText: "Escriba el nombre del cliente",
      icon: Icon(Icons.supervised_user_circle),
      width: MediaQuery.of(context).size.width * 0.75,
      style: TextStyle(fontSize: 15),
      parentAction: (value) {
        if (value != null && value != "") {
          AutoComplete cliente =
              listaClienteProvider.listaClientess.firstWhere((item) {
            return item.nombre == value;
          });
          clienteId = cliente.id;
        }
      },
    );
  }

  Widget _tipoCliente() {
    final listaClienteProvider = Provider.of<TipoClienteProvide>(context);
    return Container(
      child: clientTipoEnable
          ? ListaBusqueda(
              key: _keyTipoCliente,
              lista: listaTipoCliente,
              hintText: "Tipo Cliente",
              valorDefecto: tipoClienteNombre,
              hintSearchText: "Seleccione el tipo de cliente",
              icon: Icon(Icons.supervised_user_circle),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(fontSize: 15),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete tipoCliente =
                      listaTipoCliente.firstWhere((item) {
                    return item.nombre == value;
                  });
                  listaClienteProvider.listaClientes = tipoCliente.id;
                  listaClienteProvider.clienteNombre = tipoCliente.nombre;
                }
              },
            )
          : Container(
              child: CircularProgressIndicator(),
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
              hintSearchText: "Escriba el nombre de Postcosecha",
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

  Widget _marca() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
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
