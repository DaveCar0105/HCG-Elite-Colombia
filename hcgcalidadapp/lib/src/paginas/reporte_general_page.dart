import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/historial.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';

class ReporteGeneralPage extends StatefulWidget {
  @override
  _ReporteGeneralPageState createState() => _ReporteGeneralPageState();
}

class _ReporteGeneralPageState extends State<ReporteGeneralPage> {
  bool sinc = false;
  //int ramosRevisados = 0;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Historial> lista = List();
  ReporteGeneralDto reporteGeneral;
  List<Widget> dinamicos = List<Widget>();
  bool banderaList = false;

  @override
  void initState() {
    cargarLista();
    super.initState();
  }

  cargarLista() async {
    dinamicos = new List<Widget>();
    //lista = await DatabaseReportesAprobacion.historialReportes();
    reporteGeneral = await DatabaseReportesAprobacion.getReporteGeneral();
    var asd = jsonEncode(lista);
    if (reporteGeneral.falencias != null) {
      for (int i = 0; i < reporteGeneral.falencias.length; i++) {
        cargarFalenciaListWidget(reporteGeneral.falencias[i], (i + 1));
      }
    }
    setState(() {
      banderaList = true;
    });
  }

  cargarFalenciaListWidget(FalenciaReporteGeneralDto falencia, int indice) {
    String textoTitle = indice.toString() + ". " + falencia.nombreFalencia;
    String falenciaText = "Falencias: " + falencia.cantidad.toString();
    String porcentajeText =
        "Porcentaje: " + falencia.porcentajeFalencia.toStringAsFixed(2) + "%";

    dynamic falenciaSetear = Center(
        child: Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(leading: Icon(Icons.description), title: Text(textoTitle)),
        Column(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(falenciaText),
                  onPressed: () {/* ... */},
                ),
                //const SizedBox(width: 8),
                TextButton(
                  child: Text(porcentajeText),
                  onPressed: () {/* ... */},
                ),
                //const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ]),
    ));
    dinamicos.add(falenciaSetear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('REPORTE GENERAL HCG'),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent,
              boxShadow: [BoxShadow(color: Colors.redAccent, blurRadius: 10)]),
          width: double.infinity,
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Text('RESUMEN REVISION',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),

                    Divider(),
                    banderaList
                        ? Row(
                            children: [
                              Text(
                                  'RAMOS REVISADOS:' +
                                      '                                ' +
                                      '${reporteGeneral.ramosRevisados}',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          )
                        : Container(
                            child: CircularProgressIndicator(),
                          ),
                    Divider(),
                    banderaList
                        ? Row(
                            children: [
                              Text(
                                  'RAMOS NO CONFORMES:' +
                                      '                       ' +
                                      '${reporteGeneral.ramosNoConformes}',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          )
                        : Container(
                            child: CircularProgressIndicator(),
                          ),
                    Divider(),
                    banderaList
                        ? Row(
                            children: [
                              Text(
                                  '%RAMOS NO CONFORMES:' +
                                      '                    ' +
                                      '${reporteGeneral.porRamosNoConformes.toStringAsFixed(2)}' +
                                      '%',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          )
                        : Container(
                            child: CircularProgressIndicator(),
                          ),
                    Divider(),
                    Column(
                      children: [
                        Text('RESUMEN CAUSAS',
                            style: Theme.of(context).textTheme.headline6)
                      ],
                    ),
                    banderaList
                        ? Column(
                            children: dinamicos,
                          )
                        : Container(
                            child: CircularProgressIndicator(),
                          ),
                    // _graficarReporte(),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
