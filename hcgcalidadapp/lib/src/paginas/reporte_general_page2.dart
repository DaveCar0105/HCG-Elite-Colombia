import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/historial.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';

class ReporteGeneralPage extends StatefulWidget {
  @override
  _ReporteGeneralPageState createState() => _ReporteGeneralPageState();
}

class _ReporteGeneralPageState extends State<ReporteGeneralPage> {
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

  cargarFalenciaListWidget(FalenciaReporteGeneralDto falencia, int indice) {
    String textoTitle = indice.toString() + ". " + falencia.nombreFalencia;
    String falenciaText = "Falencias: " + falencia.cantidad.toString();
    String porcentajeText =
        "Porcentaje: " + falencia.porcentajeFalencia.toStringAsFixed(2) + "%";
    dynamic falenciaSetear = Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.error_outline), title: Text(textoTitle)),
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
      ),
    );
    dinamicos.add(falenciaSetear);
  }

  cargarLista() async {
    dinamicos = new List<Widget>();
    lista = await DatabaseReportesAprobacion.historialReportes();
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: scaffoldKey,
  //     appBar: AppBar(
  //       title: Text('REPORTE GENERAL HCG'),
  //     ),
  //     body: Container(
  //         width: double.infinity,
  //         child: Container(
  //           child: ListView(
  //             children: <Widget>[
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Column(
  //                     children: [
  //                       Text('RESUMEN REVISION',
  //                           style: Theme.of(context).textTheme.subtitle1),
  //                     ],
  //                   ),

  //                   // Center(
  //                   //   child: banderaList
  //                   //       ? ListView(
  //                   //           children: dinamicos,
  //                   //         )
  //                   //       : Container(
  //                   //           child: CircularProgressIndicator(),
  //                   //         ),
  //                   // )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         )),
  //   );
  // }

  // Widget _reporteGeneral() {
  //   return Scaffold(
  //     //appBar: AppBar(title: Text("REPORTE GENERAL")),
  //     body: Container(
  //       margin: EdgeInsets.all(10),
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Colors.green,
  //           boxShadow: [BoxShadow(color: Colors.green, blurRadius: 10)]),
  //       child: banderaList
  //           ? ListView(
  //               children: dinamicos,
  //             )
  //           : Container(
  //               child: CircularProgressIndicator(),
  //             ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REPORTE GENERAL")),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            boxShadow: [BoxShadow(color: Colors.green, blurRadius: 10)]),
        child: banderaList
            ? ListView(
                children: dinamicos,
              )
            : Container(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
