import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/banda.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos_banda.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

// ignore: must_be_immutable
class FalenciasPorRamoBanda extends StatefulWidget {
  int ramoId;
  int controlRamoId;
  String numeroMesaGetValue;
  String variedadGetValue;
  String lineaGetValue;
  final ValueChanged<String> actualizarLista;
  FalenciasPorRamoBanda(
      this.ramoId,
      this.numeroMesaGetValue,
      this.variedadGetValue,
      this.lineaGetValue,
      this.controlRamoId,
      this.actualizarLista);
  @override
  _FalenciasPorRamoBandaState createState() => _FalenciasPorRamoBandaState(
      this.ramoId,
      this.numeroMesaGetValue,
      this.variedadGetValue,
      this.lineaGetValue,
      this.controlRamoId);
}

class _FalenciasPorRamoBandaState extends State<FalenciasPorRamoBanda> {
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
  List<FalenciaReporteRamosBanda> listaFalenciasReporte = List();
  int ramoId;
  int controlRamoId;
  String numeroMesaGetValue;
  String variedadGetValue;
  String lineaGetValue;

  _FalenciasPorRamoBandaState(this.ramoId, this.numeroMesaGetValue,
      this.variedadGetValue, this.lineaGetValue, this.controlRamoId) {
    cargarLista(this.ramoId, this.numeroMesaGetValue, this.variedadGetValue,
        this.lineaGetValue);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Falencias por ramo Banda"),
      ),
      body: Scrollbar(
          child: Column(children: [
        Container(
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
                          children: <Widget>[
                            Text('Guardar '),
                            Icon(Icons.save)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: listaFalenciasReporte.length,
              itemBuilder: (context, index) =>
                  _itemFalencia(listaFalenciasReporte[index], size)),
        )
      ])),
      floatingActionButton: floatingEnable
          ? FloatingActionButton(
              onPressed: () async {
                listaFalencias = [];
                List<FalenciaRamos> falenciaRamos = List();
                falenciaRamos =
                    await DatabaseFalenciaRamos.getAllFalenciaRamos();
                falenciaRamos.forEach((element) {
                  listaFalencias.add(AutoComplete(
                      id: element.falenciaRamosId,
                      nombre: element.falenciaRamosNombre));
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
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Nueva Falencia',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                                      borderRadius: BorderRadius.circular(15)),
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
            )
          : Container(),
      persistentFooterButtons: <Widget>[
        Container(
          height: 35,
          width: w - 10,
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Aceptar '),
          ),
        ),
      ],
    );
  }

  Widget _itemFalencia(FalenciaReporteRamosBanda falencia, Size size) {
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
                  falencia.falenciaRamosNombre,
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
                await DatabaseFalenciaReporteRamos.deleteFalenciaReporteRamos(
                    falencia.falenciaBandaId, ramoId);
                cargarLista(
                    ramoId,
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
      final falenciaReporteRamos = FalenciaReporteRamosBanda();
      falenciaReporteRamos.falenciaBandaId = falenciaId;
      falenciaReporteRamos.falenciaRamosNombre = falenciaNombre;
      falenciaReporteRamos.falenciasReporteRamosCantidad = 1;

      if (this.ramoId == 0) {
        final ramoAdd = new Banda();
        ramoAdd.numeroMesa = numeroMesaTextEditingController.text;
        ramoAdd.variedad = variedadTextEditingController.text;
        ramoAdd.linea = lineaTextEditingController.text;
        this.ramoId =
            await DatabaseBanda.addRamoBanda(this.controlRamoId, ramoAdd);
      }
      falenciaReporteRamos.ramosId = this.ramoId;
      await DatabaseBanda.addFalenciaReporteRamosbanda(falenciaReporteRamos);
    } else {}
    await cargarLista(this.ramoId, numeroMesaTextEditingController.text,
        variedadTextEditingController.text, lineaTextEditingController.text);
  }

  cargarLista(int ramoId, String numeroMesaGetValue, String variedadGetValue,
      String lineaGetValue) async {
    List<FalenciaReporteRamosBanda> falencias = List();
    falencias = await DatabaseBanda.getAllFalenciasXBandaId(ramoId);
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
    });
  }
}
