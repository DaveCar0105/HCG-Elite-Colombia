import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_ordenes_clientes_banda_page.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_ordenes_clientes_page.dart';

class AprobacionPage extends StatefulWidget {
  @override
  _AprobacionPageState createState() => _AprobacionPageState();
}

class _AprobacionPageState extends State<AprobacionPage> {
  List<ReporteAprobacion> listaReportes = [];

  List<ReporteAprobacionBanda> listaBandas = [];
  List<Map<String, dynamic>> listaEcuador = [];
  bool inicio = false;
  @override
  void initState() {
    cargarReportes();
    super.initState();
  }

  cargarReportes() async {
    List<ReporteAprobacion> lista = [];
    lista = await DatabaseReportesAprobacion.getAllReportes();
    listaReportes = lista;
    List<ReporteAprobacionBanda> listaB = [];
    listaB = await DatabaseReportesAprobacion.getAllReportesBanda();
    listaBandas = listaB;
    listaEcuador = await DatabaseEcuador.getAllEcuadorAprobacion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //title: Text('Aprobación'),
          title: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.local_florist),
              ),
              Tab(
                icon: Icon(Icons.set_meal),
              ),
              Tab(
                icon: Icon(Icons.flag),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: listaReportes.length,
              itemBuilder: (context, index) =>
                  _itemReporte(listaReportes[index], w),
            ),
            ListView.builder(
              itemCount: listaBandas.length,
              itemBuilder: (context, index) => _itemResumenBanda(
                  listaBandas[index], w), //cambiar la variable despues
            ),
            ListView.builder(
              itemCount: listaEcuador.length,
              itemBuilder: (context, index) =>
                  _itemResumenEcuador(listaEcuador[index]),
            )
          ],
        ),
        floatingActionButton:
            listaReportes.length + listaBandas.length + listaEcuador.length > 0
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'listaFirma');
                    },
                    child: Icon(Icons.assignment_turned_in_rounded),
                  )
                : null,
      ),
    );
  }

  Widget _itemResumenBanda(ReporteAprobacionBanda report, double w) {
    int ramos = 0;
    //int empaque = 0;
    ramos = report.totalRamosRevisadosBanda;
    // empaque = report.totalEmpaqueRamosRevisadosBanda +
    //     report.totalEmpaqueCajasRevisadasBanda;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DetalleOrdenesClienteBanda(
                    report.clienteBandaId))); //item['controlBandaId']
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellowAccent,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                report.clienteBandaNombre, //item['clienteNombre']
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ramos > 0
                ? Text(
                    'Resumen control Banda',
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  )
                : Container(),
            ramos > 0
                ? itemTexto('Promedio % No conformidad: ',
                    report.inconformidadBandaP.toStringAsFixed(2), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalRamosRamosBanda.toString(), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Problema principal: ',
                    report.falenciaPrincipalBanda, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Problema secundario: ',
                    report.falenciaSegundariaBanda, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalRamosRevisadosBanda.toString(), w - 20)
                : Container(),
            // empaque > 0
            //     ? Text(
            //         'Resumen control Empaque',
            //         style: TextStyle(fontSize: 21, color: Colors.blue),
            //       )
            //     : Container(),
            // empaque > 0
            //     ? itemTexto(
            //         'Promedio % No conformes Cajas: ',
            //         report.inconformidadEmpaqueCajasBandaP.toStringAsFixed(2),
            //         w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto(
            //         'Promedio % No conformes Ramos: ',
            //         report.inconformidadEmpaqueRamosBandaP.toStringAsFixed(2),
            //         w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto('Cantidad Cajas No conformes: ',
            //         report.totalEmpaqueCajasBanda.toString(), w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto('Cantidad Ramos No conformes: ',
            //         report.totalEmpaqueRamosBanda.toString(), w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto('Problema principal: ',
            //         report.falenciaPrincipalEmpaqueBanda.toString(), w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto('Problema secundario: ',
            //         report.falenciaSegundariaEmpaqueBanda.toString(), w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto('Ramos revisados: ',
            //         report.totalEmpaqueRamosRevisadosBanda.toString(), w - 20)
            //     : Container(),
            // empaque > 0
            //     ? itemTexto('Cajas revisadas: ',
            //         report.totalEmpaqueCajasRevisadasBanda.toString(), w - 20)
            //     : Container(),
          ],
        ),
      ),
    );
  }

  Widget _itemResumenEcuador(Map<String, dynamic> item) {
    List<Map<String, dynamic>> problemas = [];
    problemas = item['ecuadorProblemas'];
    String problemaBanda = '';
    if (problemas.length > 0) {
      problemas.forEach((element) {
        problemaBanda += element['falenciaRamosNombre'] +
            ' - Ramos: ' +
            element['falenciaBandaRamos'].toString() +
            '\n';
      });
    }
    return ListTile(
      title: Text(item['controlNumeroOrden'] +
          '\n' +
          item['clienteNombre'] +
          '\n' +
          item['postcosechaNombre'] +
          '\n' +
          item['productoNombre']),
      subtitle: Text(problemaBanda),
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Confirmar eliminar'),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await DatabaseEcuador.deleteEcuador(
                            item['controlBandaId']);
                        await cargarReportes();
                        Navigator.pop(context);
                      },
                      child: Text('Aceptar'),
                    ),
                  ],
                ));
      },
    );
  }

  Widget _itemReporte(ReporteAprobacion report, double w) {
    int ramos = 0;
    int empaque = 0;
    ramos = report.totalRamosRevisados;
    empaque =
        report.totalEmpaqueRamosRevisados + report.totalEmpaqueCajasRevisadas;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetalleOrdenesCliente(report.clienteId)));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.amber,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 100)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                report.clienteNombre,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ramos > 0
                ? Text(
                    'Resumen control Ramos',
                    style: TextStyle(fontSize: 21, color: Colors.blueAccent),
                  )
                : Container(),
            ramos > 0
                ? itemTexto('Promedio % No conformidad: ',
                    report.inconformidadP.toStringAsFixed(2), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalRamosRamos.toString(), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto(
                    'Problema principal: ', report.falenciaPrincipal, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto(
                    'Problema secundario: ', report.falenciaSegundaria, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalRamosRevisados.toString(), w - 20)
                : Container(),
            empaque > 0
                ? Text(
                    'Resumen control Empaque',
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  )
                : Container(),
            empaque > 0
                ? itemTexto(
                    'Promedio % No conformes Cajas: ',
                    report.inconformidadEmpaqueCajasP.toStringAsFixed(2),
                    w - 20)
                : Container(),
            empaque > 0
                ? itemTexto(
                    'Promedio % No conformes Ramos: ',
                    report.inconformidadEmpaqueRamosP.toStringAsFixed(2),
                    w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cantidad Cajas No conformes: ',
                    report.totalEmpaqueCajas.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalEmpaqueRamos.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Problema principal: ',
                    report.falenciaPrincipalEmpaque.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Problema secundario: ',
                    report.falenciaSegundariaEmpaque.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalEmpaqueRamosRevisados.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cajas revisadas: ',
                    report.totalEmpaqueCajasRevisadas.toString(), w - 20)
                : Container(),
          ],
        ),
      ),
    );
  }

  itemTexto(String clave, String valor, double w) {
    return Container(
        width: w,
        child: Wrap(
          children: <Widget>[
            Container(
              width: w,
              child: Text(
                clave,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            Container(
              child: Text(
                valor,
                style: TextStyle(
                  fontSize: 18,
                ),
                textScaleFactor: 1,
              ),
            )
          ],
        ));
  }
}
