import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_boncheo.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/paginas/problemas_boncheo_page.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';
// ignore: must_be_immutable
class BoncheoPage extends StatefulWidget {
  bool valor;
  int ramosId;
  BoncheoPage(bool valor,int ramosId){
    this.valor = valor;
    this.ramosId = ramosId;
  }
  @override
  _BoncheoPageState createState() => _BoncheoPageState(this.valor,this.ramosId);
}

class _BoncheoPageState extends State<BoncheoPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final totalRamos = TextEditingController();
  final mesaBonchadoraCont = TextEditingController();
  final derogacion = TextEditingController();
  final marca = TextEditingController();
  final ordenModal = TextEditingController();
  ControlRamos ramos = new ControlRamos();
  String numeroOrden = '';

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = [];
  String productoNombre = "";
  int productoId=0;
  bool prodEnable =false;

  GlobalKey<ListaBusquedaState> _keyCliente = GlobalKey();
  static List<AutoComplete> listaCliente = [];
  String clienteNombre = "";
  int clienteId=0;
  bool clientEnable = false;

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  static List<AutoComplete> listaPostcosecha = [];
  String postcosechaNombre = "";
  int postcosechaId=0;
  bool postcosechaEnable = false;

  bool elite =false;
  _BoncheoPageState(bool valor,int ramosId){
    elite = valor;
    derogacion.text = 'NO APLICA';
    cargarRamos(ramosId);
  }

  _guardarReporteRamos() async {
    ramos.ramosTotal = int.parse(totalRamos.text);
    ramos.ramosElaborados = int.parse(mesaBonchadoraCont.text);
    ramos.ramosAprobado = 0;
    ramos.clienteId = clienteId;
    ramos.productoId = productoId;
    ramos.ramosFecha = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    ramos.postcosechaId = postcosechaId;
    ramos.usuarioId = 0;
    if(ramos.controlRamosId != null){
      await DatabaseBoncheo.updateBandas(ramos);
    }
    else{
      ramos.controlRamosId = await DatabaseBoncheo.addBandas(ramos);
    }
  }

  _showSnackBar(){
    final snackBar = SnackBar(
      content: Text('Número de orden debe ser escaneado \nTodos los números deben ser enteros'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
        },
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
  cargarRamos(int ramosId) async{
    listaProducto = [];
    listaCliente = [];
    listaPostcosecha = [];
    int valor = 0;
    if(elite){
      valor = 1;
    }
    List<Producto> productos = [];
    productos = await DatabaseProducto.getAllProductos(valor);
    productos.forEach((element) {
      listaProducto.add(AutoComplete(id:element.productoId,nombre: element.productoNombre));
    });

    List<Cliente> clientes = [];
    clientes = await DatabaseCliente.getAllCliente(valor);
    clientes.forEach((element) {
      listaCliente.add(AutoComplete(id:element.clienteId,nombre: element.clienteNombre));
    });

    List<PostCosecha> postcosechas = [];
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
        title: Text('Boncheo'),
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
                    SizedBox(
                      height: 20,
                    ),
                    _cliente(),
                    _producto(),
                    _postcosecha(),
                    _mesaBonchadora(),
                    _cantidadRamos(),
                    _botonSiguiente(context),
                    SizedBox(height: 20,)
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget _mesaBonchadora() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: '#Mesa/Bonchadora',
            labelText: '#Mesa/Bonchadora'
        ),
        controller: mesaBonchadoraCont,
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
            hintText: 'Ramos a revisar',
            labelText: 'Ramos a revisar'
        ),
        controller: totalRamos,
      ),
    );
  }
  Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async{
          final util = Utilidades();
          if(util.isNumberEntero(totalRamos.text) &&
              util.isNumberEntero(mesaBonchadoraCont.text) &&
              clienteId!=0 &&
              productoId!=0  &&
              postcosechaId != 0
          ){
            await _guardarReporteRamos();
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProblemasBoncheoPage(ramos)));
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
                    try{
                      numeroOrden = await scanner.scan();
                    }catch(e){
                      numeroOrden = "";
                    }



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
                          title: Text("Ingresa el número de orden"),
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
