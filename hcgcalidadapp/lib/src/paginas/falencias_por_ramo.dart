import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
// ignore: must_be_immutable
class FalenciasPorRamo extends StatefulWidget {
  int ramoId;
  int controlRamoId;
  final ValueChanged<String> actualizarLista;
  FalenciasPorRamo(this.ramoId,this.controlRamoId,this.actualizarLista);
  @override
  _FalenciasPorRamoState createState() => _FalenciasPorRamoState(this.ramoId,this.controlRamoId);
}

class _FalenciasPorRamoState extends State<FalenciasPorRamo> {
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = new List<AutoComplete>();
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;
  List<FalenciaReporteRamos> listaFalenciasReporte = List();
  int ramoId;
  int controlRamoId;

  _FalenciasPorRamoState(this.ramoId,this.controlRamoId){
    cargarLista(this.ramoId);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Falencias por ramo"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: listaFalenciasReporte.length,
            itemBuilder: (context, index)=>_itemFalencia(listaFalenciasReporte[index],size)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          listaFalencias = [];
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
                    width: w -160,
                    style: TextStyle(
                        fontSize: 14
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
                    onPressed: () async {
                      await agregarFalencia();
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
        child: Icon(Icons.add),
      ),

      persistentFooterButtons: <Widget>[
        Container(
          height: 35,
          width: w-10,
          child: RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.red,
            child: Text('Aceptar'),
          ),
        ),
      ],
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
                      fontSize: 17
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width*0.4-40,
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async{
                await DatabaseFalenciaReporteRamos.deleteFalenciaReporteRamos(falencia.falenciaRamosId,ramoId);
                cargarLista(ramoId);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.red,
              textColor: Colors.white,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.delete)
              ),
            ),
          )
        ],
      ),
    );
  }
  agregarFalencia() async{

    if(falenciaId > 0){
      final falenciaReporteRamos = FalenciaReporteRamos();
      falenciaReporteRamos.falenciaRamosId = falenciaId;
      falenciaReporteRamos.falenciaRamosNombre = falenciaNombre;
      falenciaReporteRamos.falenciasReporteRamosCantidad = 1;
      if(this.ramoId == 0){
        this.ramoId = await DatabaseRamos.addRamo(this.controlRamoId);
      }
      falenciaReporteRamos.ramosId = this.ramoId;
      await DatabaseFalenciaReporteRamos.addFalenciaReporteRamos(falenciaReporteRamos);

    }else{

    }
    await cargarLista(this.ramoId);
  }
  cargarLista(int ramoId) async{
    List<FalenciaReporteRamos> falencias = List();
    falencias = await DatabaseFalenciaReporteRamos.getAllFalenciasXRamosId(ramoId);
    widget.actualizarLista('');
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }
}
