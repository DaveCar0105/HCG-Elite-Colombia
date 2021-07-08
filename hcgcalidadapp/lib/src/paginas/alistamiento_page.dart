import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_alistamiento.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
import 'package:hcgcalidadapp/src/paginas/problema_alistamiento_page.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

class AlistamientoPage extends StatefulWidget {
  @override
  _AlistamientoPageState createState() => _AlistamientoPageState();
}

class _AlistamientoPageState extends State<AlistamientoPage> {
  ControlRamos ramos = new ControlRamos();

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


  GlobalKey<ListaBusquedaState> _keyTipo = GlobalKey();
  static List<AutoComplete> listaTipos = [];
  String tipoNombre = "";
  int tipoId=0;
  bool tipoEnable =false;
  cargarRamos() async{
    listaCliente = [];
    listaPostcosecha = [];
    listaTipos = [];
    int valor = 1;

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
    List<TipoControl> tipoControl = List();
    tipoControl = await DatabaseEcuador.getAllTipoControl(2);
    tipoControl.forEach((element) {
      listaTipos.add(AutoComplete(id:element.tipoControlId,nombre: element.tipoControlNombre));
    });

    setState(() {
      clientEnable = true;
      postcosechaEnable = true;
      tipoEnable = true;
    });
  }
  @override
  void initState() {
    cargarRamos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alistamiento - Clasificación'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _tipoDeControl(),
            _cliente(),
            _postcosecha(),
            _botonSiguiente()
          ],
        ),
      ),
    );
  }
  Widget _cliente(){
    return Container(
      width: 250,
      height: 70,
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
      height: 70,
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
  Widget _botonSiguiente(){
    return Container(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () async{
          ramos.postcosechaId = postcosechaId;
          ramos.clienteId = clienteId;
          ramos.ramosFecha = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
          ramos.controlRamosId = await DatabaseAlistamiento.addAlistamiento(ramos);
          ramos.tipoId = tipoId;
          if(ramos.controlRamosId>0 && ramos.clienteId > 0 && ramos.postcosechaId>0){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProblemasAlistamientoPage(ramos)));
          }

        },
        child: Text("Siguiente",
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
    );
  }

  Widget _tipoDeControl() {
    return Container(
      width: 250,
      height: 70,
      child: tipoEnable?ListaBusqueda(
        key: _keyTipo,
        lista: listaTipos,
        hintText: "Tipos",
        valorDefecto: tipoNombre,
        hintSearchText: "Escriba el nombre del tipo de control",
        icon: Icon(Icons.report_outlined),
        width: 200,
        style: TextStyle(
            fontSize: 15
        ),
        parentAction: (value){
          AutoComplete tip = listaTipos.firstWhere((item){
            return item.nombre == value;
          });
          tipoId = tip.id;
        },
      ):Container(
        child: CircularProgressIndicator(),
      )
    );
  }
}
