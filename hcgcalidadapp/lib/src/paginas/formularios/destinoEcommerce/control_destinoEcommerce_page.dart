import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_destinoecommerce.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/basedatos/database_variedad.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/control_destinoecommerce.dto.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/variedad.dto.dart';
import 'package:hcgcalidadapp/src/paginas/formularios/destinoEcommerce/lista_destino_ecommerce_page.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class ControlDestinoEcommercePage extends StatefulWidget {
  bool valor;
  int ramosId;
  ControlDestinoEcommercePage(bool valor, int ramosId) {
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _ControlDestinoEcommerceState createState() =>
      _ControlDestinoEcommerceState(this.valor, this.ramosId);
}

class _ControlDestinoEcommerceState extends State<ControlDestinoEcommercePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final totalRamosRevisadosTextEditing = TextEditingController();
  final tallosRamosTextEditing = TextEditingController();
  final ramosADespacharTextEditing = TextEditingController();
  final puntoCorte1TextEditing = TextEditingController();
  final puntoCorte2TextEditing = TextEditingController();
  final puntoCorte3TextEditing = TextEditingController();
  int clienteIdDefaultAlstroemeria = 83;
  ControlDestinoEcommerceDto controlDestinoEcommerceDto =
      new ControlDestinoEcommerceDto();

  GlobalKey<ListaBusquedaState> _globalKeyListProducto = GlobalKey();
  static List<AutoComplete> listaProducto = new List<AutoComplete>();
  String productoNombre = "";
  int productoId = 0;
  bool banderaProductoEnable = false;

  GlobalKey<ListaBusquedaState> _globalKeyListPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId = 0;
  bool banderaPostcosechaEnable = false;

  GlobalKey<ListaBusquedaState> _globalKeyListVariedad = GlobalKey();
  static List<AutoComplete> listavariedad = new List<AutoComplete>();
  String variedadNombre = "";
  int variedadId = 0;
  bool banderaVariedadEnable = false;

  bool elite = false;
  _ControlDestinoEcommerceState(bool valor, int ramosId) {
    elite = valor;
    cargarRamos(ramosId);
  }

  _guardarReporteRamos() async {
    controlDestinoEcommerceDto.productoId = productoId;
    controlDestinoEcommerceDto.usuarioId = 0;
    controlDestinoEcommerceDto.controlDestinoEcommerceFecha = DateTime.now();
    controlDestinoEcommerceDto.controlDestinoEcommerceRevisar =
        int.parse(totalRamosRevisadosTextEditing.text);
    controlDestinoEcommerceDto.controlDestinoEcommerceAprobado = 0;
    controlDestinoEcommerceDto.controlDestinoEcommerceTallos =
        int.parse(tallosRamosTextEditing.text);
    controlDestinoEcommerceDto.controlDestinoEcommerceDespachar =
        int.parse(ramosADespacharTextEditing.text);
    controlDestinoEcommerceDto.controlDestinoEcommerceCorte1 =
        double.parse(puntoCorte1TextEditing.text);
    controlDestinoEcommerceDto.controlDestinoEcommerceCorte2 =
        double.parse(puntoCorte2TextEditing.text);
    controlDestinoEcommerceDto.controlDestinoEcommerceCorte3 =
        double.parse(puntoCorte3TextEditing.text);
    controlDestinoEcommerceDto.postcosechaId = postcosechaId;
    controlDestinoEcommerceDto.variedadId = variedadId;
    controlDestinoEcommerceDto.clienteId = clienteIdDefaultAlstroemeria;
    if (controlDestinoEcommerceDto.controlDestinoEcommerceId != null) {
      await DatabaseControlDestinoEcommerce.updateControlDestinoEcommerce(
          controlDestinoEcommerceDto);
    } else {
      controlDestinoEcommerceDto.controlDestinoEcommerceDesde =
          DateTime.now().millisecondsSinceEpoch;
      controlDestinoEcommerceDto.controlDestinoEcommerceId =
          await DatabaseControlDestinoEcommerce.addControlDestinoEcommerce(
              controlDestinoEcommerceDto);
    }
  }

  cargarRamos(int ramosId) async {
    listaProducto = List<AutoComplete>();
    listaPostcosecha = List<AutoComplete>();
    listavariedad = List<AutoComplete>();

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

    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(
          id: element.postCosechaId, nombre: element.postCosechaNombre));
    });

    List<VariedadDto> variedades = List();
    variedades = await DatabaseVariedad.getAllVariedades();
    variedades.forEach((element) {
      listavariedad.add(
          AutoComplete(id: element.variedadId, nombre: element.variedadNombre));
    });

    setState(() {
      banderaProductoEnable = true;
      banderaPostcosechaEnable = true;
      banderaVariedadEnable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Control E-commerce'),
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
                    _listProductoWidget(),
                    _listPostcosechaWidget(),
                    _listVariedadWidget(),
                    _cantidadRamosDespacharWidget(),
                    _ramosRevisarWidget(),
                    _cantidadTallosWidget(),
                    _puntoCorte1Widget(),
                    _puntoCorte2Widget(),
                    _puntoCorte3Widget(),
                    _botonSiguienteWidget(context),
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

  Widget _ramosRevisarWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Ramos revisados', labelText: 'Ramos revisados'),
        controller: totalRamosRevisadosTextEditing,
      ),
    );
  }

  Widget _cantidadTallosWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Tallos por ramo', labelText: 'Tallos por ramo'),
        controller: tallosRamosTextEditing,
      ),
    );
  }

  Widget _puntoCorte1Widget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Punto de corte 1', labelText: 'Medida punto de corte 1'),
        controller: puntoCorte1TextEditing,
      ),
    );
  }

  Widget _puntoCorte2Widget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Punto de corte 2', labelText: 'Medida punto de corte 2'),
        controller: puntoCorte2TextEditing,
      ),
    );
  }

  Widget _puntoCorte3Widget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Punto de corte 3', labelText: 'Medida punto de corte 3'),
        controller: puntoCorte3TextEditing,
      ),
    );
  }

  Widget _cantidadRamosDespacharWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos a despachar',
          labelText: 'Ramos a despachar',
        ),
        controller: ramosADespacharTextEditing,
      ),
    );
  }

  Widget _botonSiguienteWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: RaisedButton(
        onPressed: () async {
          if (_validarFormulario()) {
            await _guardarReporteRamos();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ListaDestinoEcommercePage(controlDestinoEcommerceDto)));
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
              Text('Siguiente'),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

  Widget _listProductoWidget() {
    return Container(
      child: banderaProductoEnable
          ? ListaBusqueda(
              key: _globalKeyListProducto,
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

  Widget _listPostcosechaWidget() {
    return Container(
      child: banderaPostcosechaEnable
          ? ListaBusqueda(
              key: _globalKeyListPostcosecha,
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

  Widget _listVariedadWidget() {
    return Container(
      child: banderaVariedadEnable
          ? ListaBusqueda(
              key: _globalKeyListVariedad,
              lista: listavariedad,
              hintText: "Variedad",
              valorDefecto: variedadNombre,
              hintSearchText: "Escriba el nombre de la variedad",
              icon: Icon(Icons.move_to_inbox),
              width: MediaQuery.of(context).size.width * 0.75,
              style: TextStyle(
                fontSize: 15,
              ),
              parentAction: (value) {
                if (value != null && value != "") {
                  AutoComplete variedadSelec = listavariedad.firstWhere((item) {
                    return item.nombre == value;
                  });
                  variedadId = variedadSelec.id;
                }
              },
            )
          : Container(
              child: CircularProgressIndicator(),
            ),
    );
  }

  bool _validarFormulario() {
    final util = Utilidades();
    if (ramosADespacharTextEditing.text == '' ||
        tallosRamosTextEditing.text == '' ||
        totalRamosRevisadosTextEditing.text == '' ||
        puntoCorte1TextEditing.text == '' ||
        puntoCorte2TextEditing.text == '' ||
        puntoCorte3TextEditing.text == '' ||
        productoId <= 0 ||
        postcosechaId <= 0 ||
        variedadId <= 0) {
      mostrarSnackbar('Llene todo el formulario', Colors.red, scaffoldKey);
      return false;
    }
    if (productoId <= 0) {
      mostrarSnackbar('Seleccione el producto', Colors.red, scaffoldKey);
      return false;
    }
    if (postcosechaId <= 0) {
      mostrarSnackbar('Seleccione la postcosecha', Colors.red, scaffoldKey);
      return false;
    }
    if (variedadId <= 0) {
      mostrarSnackbar('Seleccione la variedad', Colors.red, scaffoldKey);
      return false;
    }
    if (!util.isNumberEntero(ramosADespacharTextEditing.text)) {
      mostrarSnackbar(
          'Ramos a despachar no es número', Colors.red, scaffoldKey);
      return false;
    }
    if (!util.isNumberEntero(totalRamosRevisadosTextEditing.text)) {
      mostrarSnackbar('Ramos revisador no es número', Colors.red, scaffoldKey);
      return false;
    }
    if (int.parse(ramosADespacharTextEditing.text) <
        int.parse(totalRamosRevisadosTextEditing.text)) {
      mostrarSnackbar('Error en ramos revisados', Colors.red, scaffoldKey);
      return false;
    }
    if (!util.isNumberEntero(tallosRamosTextEditing.text)) {
      mostrarSnackbar('Tallos ramos no es número', Colors.red, scaffoldKey);
      return false;
    }
    if (!util.isNumberDecimal(puntoCorte1TextEditing.text)) {
      mostrarSnackbar('Punto de corte 1 no es número', Colors.red, scaffoldKey);
      return false;
    }
    if (!util.isNumberDecimal(puntoCorte2TextEditing.text)) {
      mostrarSnackbar('Punto de corte 2 no es número', Colors.red, scaffoldKey);
      return false;
    }
    if (!util.isNumberDecimal(puntoCorte3TextEditing.text)) {
      mostrarSnackbar('Punto de corte 3 no es número', Colors.red, scaffoldKey);
      return false;
    }
    return true;
  }
}
