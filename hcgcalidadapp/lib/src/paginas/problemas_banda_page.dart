import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/control_banda.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos_banda.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

class ProblemasBandaPage extends StatefulWidget {
  ControlRamos ramos;
  ProblemasBandaPage(this.ramos);
  @override
  _ProblemasBandaPageState createState() => _ProblemasBandaPageState(this.ramos);
}

class _ProblemasBandaPageState extends State<ProblemasBandaPage> {
  bool iniciado = false;
  ControlRamos ramos;
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = [];
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;
  GlobalKey<ListaBusquedaState> _keyTipo = GlobalKey();
  static List<AutoComplete> listaTipos = [];
  String tipoNombre = "";
  int tipoId=0;
  bool tipoEnable =false;

  List<FalenciaReporteRamosBanda> listaFalenciasReporte = [];
  iniciarCarga(int ramoId) async{
    if(!iniciado){
      List<FalenciaReporteRamosBanda> falencias = [];
      falencias = await DatabaseBanda.getAllFalenciasXBandaId(ramoId);
      setState(() {
        listaFalenciasReporte = falencias;
      });
      iniciado = true;


    }
  }
  _ProblemasBandaPageState(this.ramos);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    iniciarCarga(ramos.controlRamosId);
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
              final ramos1 = ControlBanda(
                  ramosHasta: DateTime.now().millisecondsSinceEpoch,
                  controlRamosId: ramos.controlRamosId,
                  ramosAprobado: 1
              );
              await DatabaseBanda.finBandas(ramos1);
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
            ),
          ));
        },
        child: Icon(Icons.add_circle_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemFalencia(FalenciaReporteRamosBanda falencia,Size size) {

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
          ),
          Container(
            height: 80,
            width: size.width*0.15,
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: (){
                disminuirFalencia(falencia);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.black,
              textColor: Colors.white,
              child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(Icons.remove)
              ),
            ),
          ),

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
      id = listaFalenciasReporte.firstWhere((element) => element.falenciaBandaId==falenciaReporteRamos.falenciaRamosId).falenciasReporteRamosId;
    }catch(e){
      id = 0;
    }

    if(id > 0 ){
      return 0;
    }

    await DatabaseBanda.addFalenciaReporteBanda(falenciaReporteRamos);

    await cargarLista(ramosId);
  }
  cargarLista(int ramoId) async{
    List<FalenciaReporteRamosBanda> falencias = [];
    falencias = await DatabaseBanda.getAllFalenciasXBandaId(ramoId);
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }

  aumentarFalencia(FalenciaReporteRamosBanda falenciaReporteRamos)async {

    falenciaReporteRamos.falenciasReporteRamosCantidad++;
    await DatabaseBanda.updateCantidadFalenciaReporteBanda(falenciaReporteRamos);

    await cargarLista(falenciaReporteRamos.ramosId);
  }
  disminuirFalencia(FalenciaReporteRamosBanda falenciaReporteRamos)async {

    falenciaReporteRamos.falenciasReporteRamosCantidad--;
    await DatabaseBanda.updateCantidadFalenciaReporteBanda(falenciaReporteRamos);

    await cargarLista(falenciaReporteRamos.ramosId);
  }
}
