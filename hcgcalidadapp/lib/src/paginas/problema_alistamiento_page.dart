import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_alistamiento.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_control_alistamiento.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

// ignore: must_be_immutable
class ProblemasAlistamientoPage extends StatefulWidget {
  ControlRamos ramos;
  ProblemasAlistamientoPage(this.ramos);
  @override
  _ProblemasAlistamientoPageState createState() => _ProblemasAlistamientoPageState(this.ramos);
}

class _ProblemasAlistamientoPageState extends State<ProblemasAlistamientoPage> {
  final tallosMuestra = TextEditingController();
  final tallosAfectados = TextEditingController();
  final variedadController = TextEditingController();
  bool iniciado = false;
  ControlRamos ramos;
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = [];
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;

  List<FalenciaControlAlistamiento> listaFalenciasReporte = [];

  GlobalKey<ListaBusquedaState> _keyProducto = GlobalKey();
  static List<AutoComplete> listaProducto = [];
  String productoNombre = "";
  int productoId=0;
  bool prodEnable =false;

  iniciarCarga(int ramoId) async{
    if(!iniciado){
      List<FalenciaControlAlistamiento> falencias = [];
      falencias = await DatabaseAlistamiento.getAllFalenciasXBandaId(ramoId);

      iniciado = true;
      List<Producto> productos = [];
      int valor = 1;
      productos = await DatabaseProducto.getAllProductos(valor);
      productos.forEach((element) {
        listaProducto.add(AutoComplete(id:element.productoId,nombre: element.productoNombre));
      });
      setState(() {
        prodEnable = true;
        listaFalenciasReporte = falencias;
      });
    }
  }
  _ProblemasAlistamientoPageState(this.ramos);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    iniciarCarga(ramos.controlRamosId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Falencias'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(7),
            child: RaisedButton(
              color: Colors.white,
              textColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              elevation: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Siguiente',style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              onPressed: () async{
                final ramos1 = ControlRamos(
                    ramosHasta: DateTime.now().millisecondsSinceEpoch,
                    controlRamosId: ramos.controlRamosId,
                    ramosAprobado: 1
                );
                await DatabaseAlistamiento.finAlistamiento(ramos1);
                Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: listaFalenciasReporte.length,
            itemBuilder: (context, index)=>_itemFalencia(listaFalenciasReporte[index],size)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          List<FalenciaRamos> falenciaRamos = List();
          falenciaRamos = await DatabaseFalenciaRamos.getAllFalenciaRamos();
          falenciaRamos.forEach((element) {
            listaFalencias.add(AutoComplete(id:element.falenciaRamosId,nombre: element.falenciaRamosNombre));
          });
          setState(() {
            falenciaEnable = true;
          });
          showDialog(context: context,builder: (BuildContext context)=>Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              width: double.infinity,
              height: 500,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Nueva Falencia',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      falenciaEnable?ListaBusqueda(
                        key: _keyFalencias,
                        lista: listaFalencias,
                        hintText: "Falencias",
                        valorDefecto: falenciaNombre,
                        hintSearchText: "Escriba el nombre de la falencia",
                        icon: Icon(Icons.bug_report),
                        width: 200,
                        style: TextStyle(
                            fontSize: 15
                        ),
                        parentAction: (value){
                          AutoComplete falencia = listaFalencias.firstWhere((item){
                            return item.nombre == value;
                          });
                          falenciaId = falencia.id;
                        },
                      ):Container(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _producto(),
                      _variedadNombre(),
                      _cantidadTallosMuestra(),
                      _cantidadTallosAfectados(),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: (){
                          agregarFalencia(ramos.controlRamosId);
                          //Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 150,
                          child: Text('Agregar'),
                        ),
                      )
                    ],
                  )
                ],
              )
            ),
          ));
        },
        child: Icon(Icons.add_circle_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Widget _producto(){
    return Container(
      width: double.infinity,
      height: 70,
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
  Widget _cantidadTallosMuestra() {
    return Container(
      width: 200,
      height: 80,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Tallos muestrados',
            labelText: 'Tallos muestrados'
        ),
        controller: tallosMuestra,
      ),
    );
  }
  Widget _cantidadTallosAfectados() {
    return Container(
      width: 200,
      height: 80,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Tallos afectados',
            labelText: 'Tallos afectados'
        ),
        controller: tallosAfectados,
      ),
    );
  }
  Widget _variedadNombre() {
    return Container(
      width: 200,
      height: 80,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Variedad',
            labelText: 'Variedad'
        ),
        controller: variedadController,
      ),
    );
  }
  Widget _itemFalencia(FalenciaControlAlistamiento falencia,Size size) {

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 5
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width*0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  falencia.falenciasReporteNombre,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
                Text(
                  "Cantidad Tallos Muestra: ${falencia.falenciasReporteTallosMuestra}",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                Text(
                  "Cantidad Tallos Afectados: ${falencia.falenciasReporteTallosAfectados}",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                Text(
                  "Variedad: ${falencia.falenciasReporteVariedad}",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            width: size.width*0.2,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,

            child: RaisedButton(
              onPressed: (){
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.red,
              textColor: Colors.white,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.delete_forever_outlined)
              ),
            ),
          ),
        ],
      ),
    );
  }

  agregarFalencia(int ramosId) async{
    final falenciaReporteRamos = FalenciaControlAlistamiento();
    falenciaReporteRamos.falenciaRamosId = falenciaId;
    falenciaReporteRamos.controlAlistamientoId = ramosId;
    falenciaReporteRamos.productoId = productoId;
    falenciaReporteRamos.falenciasReporteVariedad = variedadController.text;
    falenciaReporteRamos.falenciasReporteTallosMuestra = int.parse(tallosMuestra.text);
    falenciaReporteRamos.falenciasReporteTallosAfectados = int.parse(tallosAfectados.text);
    int id = 0;

    variedadController.text = '';
    tallosMuestra.text = '';
    tallosAfectados.text = '';
    try{
      id = listaFalenciasReporte.firstWhere((element) => element.falenciaRamosId==falenciaReporteRamos.falenciaRamosId).falenciasReporteRamosId;
    }catch(e){
      id = 0;
    }

    if(id > 0 ){
      return 0;
    }

    await DatabaseAlistamiento.addFalenciaReporteBanda(falenciaReporteRamos);

    await cargarLista(ramosId);
  }
  cargarLista(int ramoId) async{
    List<FalenciaControlAlistamiento> falencias = [];
    falencias = await DatabaseAlistamiento.getAllFalenciasXBandaId(ramoId);
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }

}
