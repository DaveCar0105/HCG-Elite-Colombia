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
class calculoMuestraPage extends StatefulWidget {
  bool valor;
  int ramosId;
  calculoMuestraPage(bool valor, int ramosId) {
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _calculoMuestraPageState createState() =>
      _calculoMuestraPageState(this.valor, this.ramosId);
}

class _calculoMuestraPageState extends State<calculoMuestraPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final totalRamos = TextEditingController();
  final margenDeError = TextEditingController();
  final nivelDeConfianza = TextEditingController();
  final ramosElaborados = TextEditingController();
  final derogacion = TextEditingController();
  final marca = TextEditingController();
  final ordenModal = TextEditingController();
  ControlRamos ramos = new ControlRamos();
  String numeroOrden = '';

  // GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  // static List<AutoComplete> listaProducto = new List<AutoComplete>();
  // String productoNombre = "";
  // int productoId = 0;
  // bool prodEnable = false;

  // GlobalKey<ListaBusquedaState> _keyTipoCliente = GlobalKey();
  // static List<AutoComplete> listaTipoCliente = new List<AutoComplete>();
  // String tipoClienteNombre = "";
  // int tipoClienteId = 0;
  // bool clientTipoEnable = false;

  // GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  // int clienteId = 0;

  // GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  // static List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  // String postcosechaNombre = "";
  // int postcosechaId = 0;
  // bool postcosechaEnable = false;

  bool elite = false;
  _calculoMuestraPageState(bool valor, int ramosId) {
    elite = valor;
    derogacion.text = 'NO APLICA';
    cargarRamos(ramosId);
  }

  _guardarReporteRamos() async {
    ramos.ramosNumeroOrden = numeroOrden;
    ramos.ramosTotal = int.parse(totalRamos.text);
    ramos.ramosAprobado = 0;
    //ramos.clienteId = clienteId;
    //ramos.productoId = productoId;
    ramos.ramosElaborados = int.parse(ramosElaborados.text);
    //ramos.ramosDespachar = int.parse(ramosADespachar.text);
    //ramos.ramosTallos = int.parse(tallosRamos.text);
    ramos.ramosFecha =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    ramos.ramosDerogado = derogacion.text;
    //ramos.postcosechaId = postcosechaId;
    ramos.ramosMarca = marca.text;
    ramos.usuarioId = 0;
    if (ramos.controlRamosId != null) {
      await DatabaseRamos.updateRamos(ramos);
    } else {
      ramos.ramosDesde = DateTime.now().millisecondsSinceEpoch;
      ramos.controlRamosId = await DatabaseRamos.addRamos(ramos);
    }
  }

  cargarRamos(int ramosId) async {
    // listaProducto = List<AutoComplete>();
    // listaPostcosecha = List<AutoComplete>();
    // listaTipoCliente = List<AutoComplete>();

    int valor = 0;
    if (elite) {
      valor = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    String value2 = "";
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('CALCULO DE MUESTRA'),
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
                    /*TextFormField(
                      decoration: InputDecoration(labelText: "Nombre"),
                      onSaved: (value){
                        value2 =  value;
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return "Llene este campo";
                        }
                      },
                    ),*/
                    _cantidadRamosTotales(),
                    _NivelDeConfianza(),
                    _margenDeError(),
                    _botonSiguiente(context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Text(
                      "RESULTADO DE MUESTRA",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _NivelDeConfianza() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Nivel de confianza en %',
          labelText: 'Nivel de confianza en %',
        ),
        controller: nivelDeConfianza,
      ),
    );
  }

  Widget _margenDeError() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Margen de Error en %',
          labelText: 'Margen de Error en %',
        ),
        controller: margenDeError,
      ),
    );
  }

  Widget _cantidadRamosTotales() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos Totales',
          labelText: 'RamosTotales',
        ),
        controller: ramosElaborados,
      ),
    );
  }

  Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          if (_validarRamos()) {
            final util = Utilidades();
            if (numeroOrden != '' &&
                    util.isNumberEntero(totalRamos.text) &&
                    //util.isNumberEntero(tallosRamos.text) &&
                    derogacion.text != '' &&
                    //util.isNumberEntero(ramosADespachar.text) &&
                    util.isNumberEntero(ramosElaborados.text) &&
                    //clienteId != 0 &&
                    //productoId != 0 &&
                    marca.text != ''
                //postcosechaId != 0
                ) {
              await _guardarReporteRamos();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListaRamosPage(ramos)));
            } else {
              //_showSnackBar();
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
            children: <Widget>[Text('Calcular'), Icon(Icons.exposure)],
          ),
        ),
      ),
    );
  }

  bool _validarRamos() {
    if (nivelDeConfianza.text == '' ||
        ramosElaborados.text == '' ||
        margenDeError.text == '') {
      mostrarSnackbar('Llenar Datos', null, scaffoldKey);
      return false;
    }

    if (int.parse(ramosElaborados.text) < int.parse(totalRamos.text)) {
      mostrarSnackbar('Error en Ramos a revisar', null, scaffoldKey);
      return false;
    }

    return true;
  }
}
