import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/empaque_item.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_empaque.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

// ignore: must_be_immutable
class FalenciasPorCaja extends StatefulWidget {
  int empaqueId;
  int controlEmpaqueId;
  int tipo;
  String numeroMesaGetValue;
  String variedadGetValue;
  String lineaGetValue;
  final ValueChanged<String> actualizarLista;
  FalenciasPorCaja(
      this.empaqueId,
      this.numeroMesaGetValue,
      this.variedadGetValue,
      this.lineaGetValue,
      this.controlEmpaqueId,
      this.tipo,
      this.actualizarLista);
  @override
  _FalenciasPorCajaState createState() => _FalenciasPorCajaState(
      this.empaqueId,
      this.numeroMesaGetValue,
      this.variedadGetValue,
      this.lineaGetValue,
      this.controlEmpaqueId,
      this.tipo);
}

class _FalenciasPorCajaState extends State<FalenciasPorCaja> {
  final numeroMesaTextEditingController = TextEditingController();
  final variedadTextEditingController = TextEditingController();
  final lineaTextEditingController = TextEditingController();
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static List<AutoComplete> listaFalencias = new List<AutoComplete>();
  String falenciaNombre = "";
  int falenciaId = 0;
  bool falenciaEnable = false;
  bool floatingEnable = false;
  bool estaticFormEnable = true;
  bool banderaVisableForm = true;
  List<FalenciaReporteEmpaque> listaFalenciasReporte = List();
  int empaqueId;
  int controlEmpaqueId;
  int tipo;
  String numeroMesaGetValue;
  String variedadGetValue;
  String lineaGetValue;

  _FalenciasPorCajaState(
      this.empaqueId,
      this.numeroMesaGetValue,
      this.variedadGetValue,
      this.lineaGetValue,
      this.controlEmpaqueId,
      this.tipo) {
    cargarLista(this.empaqueId, this.numeroMesaGetValue, this.variedadGetValue,
        this.lineaGetValue);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Falencias por empaque"),
      ),
      body: Scrollbar(
          child: Column(children: [
        banderaVisableForm?Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Número de mesa",
                              hintText: 'Ingrese el # mesa',
                              enabled: estaticFormEnable),
                          controller: numeroMesaTextEditingController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Llene este campo";
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Línea",
                              hintText: 'Ingrese el #línea',
                              enabled: estaticFormEnable),
                          controller: lineaTextEditingController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Llene este campo";
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Variedad",
                        hintText: 'Ingrese la variedad',
                        enabled: estaticFormEnable),
                    controller: variedadTextEditingController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Llene este campo";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            estaticFormEnable = false;
                            floatingEnable = true;
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[Text('Guardar '), Icon(Icons.save)],
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ): Container(),
        Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: listaFalenciasReporte.length,
              itemBuilder: (context, index) =>
                  _itemFalencia(listaFalenciasReporte[index], size)),
        )
      ])),
      floatingActionButton: floatingEnable?FloatingActionButton(
        onPressed: () async {
          listaFalencias = [];
          List<FalenciaEmpaque> falenciaEmpaques = List();
          String valor = 'C';
          if (this.tipo == 0) {
            valor = 'R';
          }
          falenciaEmpaques =
              await DatabaseFalenciaEmpaque.getAllFalenciaEmpaque(valor);
          falenciaEmpaques.forEach((element) {
            listaFalencias.add(AutoComplete(
                id: element.falenciaEmpaqueId,
                nombre: element.falenciaEmpaqueNombre));
          });
          setState(() {
            falenciaEnable = true;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Nueva Falencia',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          falenciaEnable
                              ? ListaBusqueda(
                                  key: _keyFalencias,
                                  lista: listaFalencias,
                                  hintText: "Falencias",
                                  valorDefecto: falenciaNombre,
                                  hintSearchText:
                                      "Escriba el nombre de la falencia",
                                  icon: Icon(Icons.bug_report),
                                  width: w - 160,
                                  style: TextStyle(fontSize: 14),
                                  parentAction: (value) {
                                    AutoComplete falencia =
                                        listaFalencias.firstWhere((item) {
                                      return item.nombre == value;
                                    });
                                    falenciaId = falencia.id;
                                  },
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Expanded(child: Container()),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () async {
                              await agregarFalencia();
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              child: Text('Agregar'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ): Container(),
      persistentFooterButtons: <Widget>[
        Container(
          height: 35,
          width: w - 10,
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Aceptar '),
          ),
        ),
      ],
    );
  }

  Widget _itemFalencia(FalenciaReporteEmpaque falencia, Size size) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  falencia.falenciaEmpaqueNombre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.4 - 40,
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                await DatabaseFalenciaReporteEmpaque
                    .deleteFalenciaReporteEmpaques(
                        falencia.falenciaEmpaqueId, empaqueId);
                cargarLista(
                    this.empaqueId,
                    numeroMesaTextEditingController.text,
                    variedadTextEditingController.text,
                    lineaTextEditingController.text);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              child:
                  Container(height: 50, width: 50, child: Icon(Icons.delete)),
            ),
          )
        ],
      ),
    );
  }

  agregarFalencia() async {
    if (falenciaId > 0) {
      final falenciaReporteEmpaques = FalenciaReporteEmpaque();
      falenciaReporteEmpaques.falenciaEmpaqueId = falenciaId;
      falenciaReporteEmpaques.falenciaEmpaqueNombre = falenciaNombre;
      falenciaReporteEmpaques.falenciasReporteEmpaqueCantidad = 1;
      if (this.empaqueId == 0) {
        final empaqueAdd = new Empaque();
        empaqueAdd.numeroMesa = numeroMesaTextEditingController.text;
        empaqueAdd.variedad = variedadTextEditingController.text;
        empaqueAdd.linea = lineaTextEditingController.text;
        this.empaqueId =
            await DatabaseEmpaque.addEmpaque(this.controlEmpaqueId, empaqueAdd);
      }
      falenciaReporteEmpaques.empaqueId = this.empaqueId;
      await DatabaseFalenciaReporteEmpaque.addFalenciaReporteEmpaque(
          falenciaReporteEmpaques);
    }
    await cargarLista(this.empaqueId, numeroMesaTextEditingController.text,
        variedadTextEditingController.text, lineaTextEditingController.text);
  }

  cargarLista(int empaqueId, String numeroMesaGetValue, String variedadGetValue,
      String lineaGetValue) async {
    List<FalenciaReporteEmpaque> falencias = List();
    falencias = await DatabaseFalenciaReporteEmpaque.getAllFalenciasXEmpaqueId(
        empaqueId);
    widget.actualizarLista('');
    setState(() {
      listaFalenciasReporte = falencias;
      if (falencias.length > 0) {
        numeroMesaTextEditingController.text = numeroMesaGetValue;
        variedadTextEditingController.text = variedadGetValue;
        lineaTextEditingController.text = lineaGetValue;
        estaticFormEnable = false;
        floatingEnable = true;
      }
      if (tipo == 1){
        floatingEnable = true;
        numeroMesaTextEditingController.text = "N/A en empaque";
        variedadTextEditingController.text = "N/A en empaque";
        lineaTextEditingController.text = "N/A en empaque";
        estaticFormEnable = false;
        banderaVisableForm = false;
      }
    });
  }
}
