import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

class FalenciasRamosPage extends StatefulWidget {
  @override
  _FalenciasRamosPageState createState() => _FalenciasRamosPageState();
}

class _FalenciasRamosPageState extends State<FalenciasRamosPage> {
  bool iniciado = false;

  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = [];
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;

  List<FalenciaReporteRamos> listaFalenciasReporte = [];

  iniciarCarga(int ramoId) async{
    if(!iniciado){
      List<FalenciaReporteRamos> falencias = [];
      falencias = await DatabaseFalenciaReporteRamos.getAllFalenciasXRamosId(ramoId);
      setState(() {
        listaFalenciasReporte = falencias;
      });
      iniciado = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    final ControlRamos arguments = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    iniciarCarga(arguments.controlRamosId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Falencias'),
        actions: <Widget>[
          RaisedButton(
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
              final ramos = ControlRamos(
                ramosHasta: DateTime.now().millisecondsSinceEpoch,
                controlRamosId: arguments.controlRamosId,
                ramosAprobado: 1
              );
              await DatabaseRamos.finRamos(ramos);
              Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
            },
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
              height: 200,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
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
                  Expanded(child: Container()),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: (){
                      agregarFalencia(arguments.controlRamosId);
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
            ),
          ));
        },
        child: Icon(Icons.add_circle_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemFalencia(FalenciaReporteRamos falencia,Size size) {

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
                  falencia.falenciaRamosNombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19
                  ),
                ),
                Text(
                  "Cantidad: ${falencia.falenciasReporteRamosCantidad}",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                Text(
                  "Porcentaje: ${falencia.falenciasReporteRamosPorcentaje}",
                  style: TextStyle(
                      fontSize: 15
                  ),)
              ],
            ),
          ),
          Container(
            height: 80,
            width: size.width*0.4-40,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            
            child: RaisedButton(
              onPressed: (){
                aumentarFalencia(falencia);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.red,
              textColor: Colors.white,
              child: Container(
                height: 50,
                width: 50,
                child: Icon(Icons.add)
              ),
            ),
          )
        ],
      ),
    );
  }

  agregarFalencia(int ramosId) async{
    final falenciaReporteRamos = FalenciaReporteRamos();
    falenciaReporteRamos.falenciaRamosId = falenciaId;
    falenciaReporteRamos.ramosId = ramosId;
    falenciaReporteRamos.falenciaRamosNombre = falenciaNombre;
    falenciaReporteRamos.falenciasReporteRamosCantidad = 1;
    int id = 0;
    try{
      id = listaFalenciasReporte.firstWhere((element) => element.falenciaRamosId==falenciaReporteRamos.falenciaRamosId).falenciasReporteRamosId;
    }catch(e){
      id = 0;
    }

    if(id > 0 ){
      return 0;
    }

    await DatabaseFalenciaReporteRamos.addFalenciaReporteRamos(falenciaReporteRamos);

    await cargarLista(ramosId);
  }
  cargarLista(int ramoId) async{
    List<FalenciaReporteRamos> falencias = List();
    falencias = await DatabaseFalenciaReporteRamos.getAllFalenciasXRamosId(ramoId);
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }

  aumentarFalencia(FalenciaReporteRamos falenciaReporteRamos)async {


    if(falenciaReporteRamos.falenciasReporteRamosCantidad < falenciaReporteRamos.total){
      falenciaReporteRamos.falenciasReporteRamosCantidad++;
      await DatabaseFalenciaReporteRamos.updateCantidadFalenciaReporteRamos(falenciaReporteRamos);

    }

    cargarLista(falenciaReporteRamos.ramosId);
  }
}
