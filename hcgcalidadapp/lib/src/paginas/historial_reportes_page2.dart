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

  List<CirculoCalidad> reportesLista = new List<CirculoCalidad>();
  bool loading = true;
  Future fetchAllReportes() async {
    reportesLista = await DatabaseCirculoCalidad.getAllcirculoCalidad();
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
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Text('Historial Reportes', style: TextStyle(fontSize: 40)),
            DataTable(
              dividerThickness: 5,
              dataRowHeight: 100,
              headingRowHeight: 50,
              columnSpacing: 5,
              columns: [
                DataColumn(label: Text('Reunion'), numeric: true),
                DataColumn(label: Text('Ramos\nRevisados'), numeric: true),
                DataColumn(label: Text('Ramos\nRechazados'), numeric: true),
                DataColumn(label: Text('%No\nConformidad'), numeric: true),
                DataColumn(label: Text('Ver\nreporte'), numeric: true),
              ],
              rows: reportesLista != null
                  ? reportesLista
                      .map<DataRow>((element) => DataRow(cells: [
                            DataCell(Text(element.circuloCalidadNumeroReunion
                                .toString())),
                            DataCell(Text(
                                element.circuloCalidadRevisados.toString())),
                            DataCell(Text(
                                element.circuloCalidadRechazados.toString())),
                            DataCell(Text(element
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
          ],
        ),
      )),
    );
  }
}
