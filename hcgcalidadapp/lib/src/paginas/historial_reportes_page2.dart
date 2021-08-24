import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_historial_reportes.dart';

// ignore: must_be_immutable
class ListaReporteGeneralPage2 extends StatefulWidget {
  @override
  _ListaReporteGeneralPage2State createState() =>
      _ListaReporteGeneralPage2State();
}

class _ListaReporteGeneralPage2State extends State<ListaReporteGeneralPage2> {
  //final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<CirculoCalidadInformacionGeneral> reportesLista = new List<CirculoCalidadInformacionGeneral>();
  bool loading = true;
  Future fetchAllReportes() async {
    reportesLista = await DatabaseCirculoCalidad.getAllcirculoCalidadBySincronizar();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAllReportes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de reportes'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.redAccent, width: 2)),
        //color: Colors.amber,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Center(
            child: SizedBox(
              width: double.infinity,
              child: 
                DataTable(
                  //dividerThickness: 5,
                  //dataRowHeight: 70,
                  //headingRowHeight: 60,
                  //columnSpacing: 2,
                  columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.1,
                  dataRowHeight: 80,
                  columns: [
                    DataColumn(label: Text('Reunión'), numeric: true),
                    DataColumn(label: Text('Ramos\nrevisados'), numeric: true),
                    DataColumn(label: Text('Ramos\nrechazados'), numeric: true),
                    DataColumn(label: Text('%No\nconformidad'), numeric: true),
                    DataColumn(label: Text('Ver\nreporte'), numeric: true),
                  ],
                  rows: reportesLista != null
                      ? reportesLista
                          .map<DataRow>((element) => DataRow(
                            cells: [
                                DataCell(Text(element.circuloCalidad
                                    .circuloCalidadNumeroReunion
                                    .toString())),
                                DataCell(Text(element.circuloCalidad.circuloCalidadRevisados
                                    .toString())),
                                DataCell(Text(element.circuloCalidad.circuloCalidadRechazados
                                    .toString())),
                                DataCell(Text(element.circuloCalidad
                                    .circuloCalidadPorcentajeNoConforme
                                    .toStringAsFixed(2))),
                                DataCell(Icon(Icons.visibility), onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetalleHistorialReporteGeneralPage(
                                                data: element,
                                              )));
                                }),
                              ]))
                          .toList()
                      : [],
                )
              ,
            ),
          )),
        ),
      ),
    );
  }
}
