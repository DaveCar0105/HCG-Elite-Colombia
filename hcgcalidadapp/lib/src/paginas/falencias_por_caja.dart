import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_empaque.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
// ignore: must_be_immutable
class FalenciasPorCaja extends StatefulWidget {
  int empaqueId;
  int controlEmpaqueId;
  int tipo;
  final ValueChanged<String> actualizarLista;
  FalenciasPorCaja(this.empaqueId,this.controlEmpaqueId,this.tipo,this.actualizarLista);
  @override
  _FalenciasPorCajaState createState() => _FalenciasPorCajaState(this.empaqueId,this.controlEmpaqueId,this.tipo);
}

class _FalenciasPorCajaState extends State<FalenciasPorCaja> {
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = new List<AutoComplete>();
  String falenciaNombre = "";
  int falenciaId=0;
  bool falenciaEnable =false;
  List<FalenciaReporteEmpaque> listaFalenciasReporte = List();
  int empaqueId;
  int controlEmpaqueId;
  int tipo;
  _FalenciasPorCajaState(this.empaqueId,this.controlEmpaqueId,this.tipo){
    cargarLista(this.empaqueId);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Falencias por empaque"),
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
          List<FalenciaEmpaque> falenciaEmpaques = List();
          String valor = 'C';
          if(this.tipo==0){
            valor = 'R';
          }
          falenciaEmpaques = await DatabaseFalenciaEmpaque.getAllFalenciaEmpaque(valor);
          falenciaEmpaques.forEach((element) {
            listaFalencias.add(AutoComplete(id:element.falenciaEmpaqueId,nombre: element.falenciaEmpaqueNombre));
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
                    width: w -150,
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
  Widget _itemFalencia(FalenciaReporteEmpaque falencia,Size size) {

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
                  falencia.falenciaEmpaqueNombre,
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
                await DatabaseFalenciaReporteEmpaque.deleteFalenciaReporteEmpaques(falencia.falenciaEmpaqueId,empaqueId);
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
      final falenciaReporteEmpaques = FalenciaReporteEmpaque();
      falenciaReporteEmpaques.falenciaEmpaqueId = falenciaId;
      falenciaReporteEmpaques.falenciaEmpaqueNombre = falenciaNombre;
      falenciaReporteEmpaques.falenciasReporteEmpaqueCantidad = 1;
      if(this.empaqueId == 0){
        this.empaqueId = await DatabaseEmpaque.addEmpaque(this.controlEmpaqueId);
      }
      falenciaReporteEmpaques.empaqueId = this.empaqueId;
      await DatabaseFalenciaReporteEmpaque.addFalenciaReporteEmpaque(falenciaReporteEmpaques);

    }else{

    }
    await cargarLista(this.empaqueId);

  }
  cargarLista(int empaqueId) async{
    List<FalenciaReporteEmpaque> falencias = List();
    falencias = await DatabaseFalenciaReporteEmpaque.getAllFalenciasXEmpaqueId(empaqueId);
    widget.actualizarLista('');
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }
}
