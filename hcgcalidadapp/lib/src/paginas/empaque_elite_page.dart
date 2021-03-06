import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/empaque.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/paginas/lista_empaques_page.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';
// ignore: must_be_immutable
class EmpaqueElitePage extends StatefulWidget {
  bool valor;
  int empaqueId;
  EmpaqueElitePage(this.valor,this.empaqueId);
  @override
  _EmpaqueElitePageState createState() => _EmpaqueElitePageState(this.valor,this.empaqueId);
}

class _EmpaqueElitePageState extends State<EmpaqueElitePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final ramosCaja = TextEditingController();
  final tallosRamo = TextEditingController();
  final cajasADespachar = TextEditingController();
  final totalCajas = TextEditingController();
  final derogacion = TextEditingController();
  final marca = TextEditingController();
  final ramosRevisarCaja = TextEditingController();
  final ordenModal = TextEditingController();
  ControlEmpaque empaque = new ControlEmpaque();
  String numeroOrden = '';

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = new List<AutoComplete>();
  String productoNombre = "";
  int productoId=0;
  bool prodEnable =false;

  GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  static List<AutoComplete> listaCliente = new List<AutoComplete>();
  String clienteNombre = "";
  int clienteId=0;
  bool clientEnable = false;

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId=0;
  bool postcosechaEnable = false;
  bool elite = false;
  int empaqueId;
  _EmpaqueElitePageState(this.elite,this.empaqueId){
    derogacion.text = 'NO APLICA';
    cargarEmpaque(empaqueId);
  }

  _guardarReporteEmpaque() async {
    empaque.empaqueNumeroOrden = numeroOrden;
    empaque.empaqueTotal = int.parse(totalCajas.text);
    empaque.empaqueAprobado = 0;
    empaque.clienteId = clienteId;
    empaque.productoId = productoId;
    empaque.empaqueDespachar = int.parse(cajasADespachar.text);
    empaque.empaqueRamos = int.parse(ramosCaja.text);
    empaque.empaqueTallos = int.parse(tallosRamo.text);
    empaque.empaqueFecha = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    empaque.empaqueDerogado = derogacion.text;
    empaque.ramosRevisar = int.parse(ramosRevisarCaja.text);
    empaque.postcosechaId = postcosechaId;
    empaque.empaqueMarca = marca.text;
    empaque.elite = 1;
    if(empaque.controlEmpaqueId != null){
      await DatabaseEmpaque.updateEmpaques(empaque);
    }
    else{
      empaque.empaqueDesde = DateTime.now().millisecondsSinceEpoch;
      empaque.controlEmpaqueId = await DatabaseEmpaque.addEmpaques(empaque);
    }
  }



  _showSnackBar(){
    final snackBar = SnackBar(
      content: Text('Numero de orden debe ser escaneado \nTodos los numeros deben ser enteros'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
        },
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
  cargarEmpaque(int empaqueId) async{
    listaProducto = List<AutoComplete>();
    listaPostcosecha = List<AutoComplete>();
    listaCliente = List<AutoComplete>();

    int valor =0;
    if(elite){
      valor = 1;
    }

    List<Producto> productos = List();
    productos = await DatabaseProducto.getAllProductos(valor);
    productos.forEach((element) {
      listaProducto.add(AutoComplete(id:element.productoId,nombre: element.productoNombre));
    });

    List<Cliente> clientes = List();
    clientes = await DatabaseCliente.getAllCliente(valor);
    clientes.forEach((element) {
      listaCliente.add(AutoComplete(id:element.clienteId,nombre: element.clienteNombre));
    });

    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(valor);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(id:element.postCosechaId,nombre: element.postCosechaNombre));
    });
    setState(() {
      prodEnable = true;
      clientEnable = true;
      postcosechaEnable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Empaque'),
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
                    _numeroOrden(),
                    _cliente(),
                    _producto(),
                    _postcosecha(),
                    _marca(),
                    _cantidadCajasDespachar(),
                    _cantidadCajas(),
                    _cantidadRamos(),
                    _cantidadRamosRevisar(),
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
          )
      ),
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
              onPressed: (){
                _bottomSheetOrden(context);
              },
              color: Colors.red,
              child: Text('Ingresar Orden'),
              textColor: Colors.white,
              shape: StadiumBorder(),
            )
                : Container(
              child: Text(
                numeroOrden,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          numeroOrden == '' ? SizedBox() :RaisedButton(
              shape: CircleBorder(),
              color: Colors.red,
              child: Icon(Icons.create, color: Colors.white,),
              onPressed: (){
                _bottomSheetOrden(context);
              }
          )
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
            hintText: 'Ramos por caja',
            labelText: 'Ramos por caja'
        ),
        controller: ramosCaja,
      ),
    );
  }
  Widget _cantidadRamosRevisar() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Ramos por revisar',
            labelText: 'Ramos por revisar'
        ),
        controller: ramosRevisarCaja,
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
            hintText: 'Tallos por ramo',
            labelText: 'Tallos por ramo'
        ),
        controller: tallosRamo,
      ),
    );
  }
  Widget _cantidadCajasDespachar() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Cajas a despachar',
          labelText: 'Cajas a despachar',

        ),
        controller: cajasADespachar,
      ),
    );
  }
  Widget _cantidadCajas() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Cajas a revisar',
          labelText: 'Cajas a revisar',

        ),
        controller: totalCajas,
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
        onPressed: () async{
          final util = Utilidades();
          if( numeroOrden != ''
              && util.isNumberEntero(totalCajas.text)
              && util.isNumberEntero(ramosCaja.text)
              && derogacion.text != ''
              && util.isNumberEntero(cajasADespachar.text)
              && util.isNumberEntero(tallosRamo.text)
              && clienteId!=0 && productoId!=0
              && util.isNumberEntero(ramosRevisarCaja.text)
              && marca.text != ''
              && postcosechaId != 0
          ){

            await _guardarReporteEmpaque();
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ListaEmpaquePage(empaque)));
          }else{
            _showSnackBar();
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
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
  Widget _producto(){
    return Container(
      width: 250,
      height: 90,
      child: prodEnable?ListaBusqueda(
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
        parentAction: (value){
          AutoComplete producto = listaProducto.firstWhere((item){
            return item.nombre == value;
          });
          productoId = producto.id;
        },
      ):Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Widget _cliente(){
    return Container(
      width: 250,
      height: 90,
      child: clientEnable?ListaBusqueda(
        key: _keyCliente,
        lista: listaCliente,
        hintText: "Cliente",
        valorDefecto: clienteNombre,
        hintSearchText: "Escriba el nombre del cliente",
        icon: Icon(Icons.supervised_user_circle),
        width: 200.0,
        style: TextStyle(
            fontSize: 15
        ),
        parentAction: (value){
          AutoComplete cliente = listaCliente.firstWhere((item){
            return item.nombre == value;
          });
          clienteId = cliente.id;
        },
      ):Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Widget _postcosecha() {
    return Container(
      width: 250,
      height: 90,
      child: postcosechaEnable?ListaBusqueda(
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
        parentAction: (value){
          AutoComplete postcosecha= listaPostcosecha.firstWhere((item){
            return item.nombre == value;
          });
          postcosechaId = postcosecha.id;
        },
      ):Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Widget _marca() {
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
  _bottomSheetOrden(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.red,),
                  title: Text('Codigo QR'),
                  onTap: () async{
                    Navigator.maybePop(context);
                    numeroOrden = await scanner.scan();
                    setState(() {});
                  },
                ),
                ListTile(
                  leading: Icon(Icons.font_download, color: Colors.red,),
                  title: Text('Ingresar Orden'),
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                          title: Text("Ingresa el n??mero de orden"),
                          content: TextField(
                            controller: ordenModal,
                            decoration: InputDecoration(
                                hintText: '# de Orden'
                            ),
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
                        )
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}