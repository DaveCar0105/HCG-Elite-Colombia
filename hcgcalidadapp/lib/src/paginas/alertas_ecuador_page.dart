import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/alerta.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

// ignore: must_be_immutable
class AlertasEcuadorPage extends StatefulWidget {
  ControlRamos ramos;
  AlertasEcuadorPage(this.ramos);
  @override
  _AlertasEcuadorPageState createState() => _AlertasEcuadorPageState(this.ramos);
}

class _AlertasEcuadorPageState extends State<AlertasEcuadorPage> {
  bool iniciado = false;
  ControlRamos ramos;
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = [];
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;
  GlobalKey<ListaBusquedaState> _keyProductos = GlobalKey();
  static List<AutoComplete> listaProductos = [];
  String productoNombre = "";
  int productoId=0;
  bool productoEnable =false;
  List<AlertaEcuador> listaFalenciasReporte = [];
  TextEditingController _variedad = new TextEditingController();
  TextEditingController _tallosMuestra = new TextEditingController();
  TextEditingController _tallosAfectados = new TextEditingController();

  iniciarCarga(int ramoId) async{
    if(!iniciado){
      List<AlertaEcuador> falencias = [];
      falencias = await DatabaseEcuador.getAllAlertas(ramoId);
      setState(() {
        listaFalenciasReporte = falencias;
      });
      iniciado = true;
    }
  }
  _AlertasEcuadorPageState(this.ramos);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    iniciarCarga(ramos.controlRamosId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Alertas de calidad'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
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
                  Text('Finalizar',style: TextStyle(
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
                await DatabaseEcuador.finEcuador(ramos1);
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
          _variedad.text = '';
          _tallosMuestra.text = '';
          _tallosAfectados.text = '';
          List<FalenciaRamos> falenciaRamos = List();
          falenciaRamos = await DatabaseFalenciaRamos.getAllFalenciaRamos();
          falenciaRamos.forEach((element) {
            listaFalencias.add(AutoComplete(id:element.falenciaRamosId,nombre: element.falenciaRamosNombre));
          });
          List<Producto> productos = List();
          productos = await DatabaseProducto.getAllProductos(1);
          productos.forEach((element) {
            listaProductos.add(AutoComplete(id:element.productoId,nombre: element.productoNombre));
          });
          setState(() {
            falenciaEnable = true;
            productoEnable = true;
          });
          showDialog(context: context,builder: (BuildContext context)=>Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              width: double.infinity,
              height: size.height*0.6,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListView(
                children: [
                  Column(
                    children: <Widget>[
                      Text(
                        'Nueva Alerta',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      productoEnable?ListaBusqueda(
                        key: _keyProductos,
                        lista: listaProductos,
                        hintText: "Productos",
                        valorDefecto: productoNombre,
                        hintSearchText: "Escriba el nombre del producto",
                        icon: Icon(Icons.local_florist_sharp),
                        width: 200,
                        style: TextStyle(
                            fontSize: 20
                        ),
                        parentAction: (value){
                          AutoComplete producto = listaProductos.firstWhere((item){
                            return item.nombre == value;
                          });
                          productoId = producto.id;
                        },
                      ):Container(
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(
                        height: 20,
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
                            fontSize: 20
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
                      _campoVariedad(),
                      _tallosMuestreados(),
                      _tallosAfectado(),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: (){
                          agregarFalencia(ramos.controlRamosId);
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 150,
                          child: Text('Agregar'),
                        ),
                      )
                    ],
                  ),
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

  Widget _itemFalencia(AlertaEcuador falencia,Size size) {

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
            width: size.width*0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  falencia.falenciaRamoNombre.toString()+'\n'+
                  falencia.productoNombre.toString()+'\n' +
                  falencia.variedadNombre.toString()+'\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19
                  ),
                ),
                Text(
                  "Tallos muestrados: ${falencia.tallosMuestra} \n "
                  "Tallos afectados: ${falencia.tallosAfectados}",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width*0.2,
            height: size.width*0.2,
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: Icon(Icons.delete_forever,size: 20,),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context)=>
                    AlertDialog(
                      title: Text('Confirmar eliminar'),
                      actions: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async{
                            await DatabaseEcuador.deleteAlertaReporteEcuador(falencia);
                            await cargarLista(falencia.controlEcuadorId);
                            Navigator.pop(context);
                          },
                          child: Text('Aceptar'),
                        ),

                      ],
                    )
                );
              },
            )
          )
        ],
      ),
    );
  }
  Widget _campoVariedad(){
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Variedad',
            labelText: 'Variedad'
        ),
        controller: _variedad,
      ),
    );
  }

  Widget _tallosMuestreados(){
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Tallos muestrados',
            labelText: 'Tallos muestrados'
        ),
        controller: _tallosMuestra,
      ),
    );
  }

  Widget _tallosAfectado(){
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Tallos afectados',
            labelText: 'Tallos afectados'
        ),
        controller: _tallosAfectados,
      ),
    );
  }

  agregarFalencia(int ramosId) async{
    final falenciaReporteRamos = AlertaEcuador();
    falenciaReporteRamos.falenciaRamoId = falenciaId;
    falenciaReporteRamos.controlEcuadorId = ramosId;
    falenciaReporteRamos.falenciaRamoNombre = falenciaNombre;
    falenciaReporteRamos.productoId = productoId;
    falenciaReporteRamos.variedadNombre = _variedad.text;
    falenciaReporteRamos.tallosMuestra = int.parse(_tallosMuestra.text);
    falenciaReporteRamos.tallosAfectados = int.parse(_tallosAfectados.text);
    int id = 0;
    try{
      id = listaFalenciasReporte.firstWhere((element) => element.falenciaRamoId==falenciaReporteRamos.falenciaRamoId).alertaEcuadorId;
    }catch(e){
      id = 0;
    }

    if(id > 0 ){
      return 0;
    }

    await DatabaseEcuador.addAlertaReporteEcuador(falenciaReporteRamos);

    await cargarLista(ramosId);
  }
  cargarLista(int ramoId) async{
    List<AlertaEcuador> falencias = [];
    falencias = await DatabaseEcuador.getAllAlertas(ramoId);
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }


}
