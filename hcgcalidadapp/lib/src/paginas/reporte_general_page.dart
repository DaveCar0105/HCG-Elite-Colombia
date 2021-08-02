import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';

class ReporteGeneralPage extends StatefulWidget {
  @override
  _ReporteGeneralPageState createState() => _ReporteGeneralPageState();
}

class _ReporteGeneralPageState extends State<ReporteGeneralPage> {
  bool sinc = false;
  bool reporteGeneralValue;
  bool ramosRevisadosValue;
  bool ramosNoConformes;
  bool porRamosNoConformes;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ReporteGeneralDto reporteGeneral;
  List<Widget> dinamicos = List<Widget>();
  List<Widget> dinamicosClientes = List<Widget>();
  List<Widget> dinamicosProductos = List<Widget>();
  bool banderaList = false;

  @override
  void initState() {
    cargarLista();
    super.initState();
  }

  cargarLista() async {
    dinamicos = new List<Widget>();
    reporteGeneral = await DatabaseReportesAprobacion.getReporteGeneral();
    if (reporteGeneral.porRamosNoConformes == null)
      reporteGeneral.porRamosNoConformes = 0;
    if (reporteGeneral.falencias != null) {
      for (int i = 0; i < reporteGeneral.falencias.length; i++) {
        cargarFalenciaListWidget(reporteGeneral.falencias[i], (i + 1));
      }
    }
    if (reporteGeneral.clientes != null) {
      for (int i = 0; i < reporteGeneral.clientes.length; i++) {
        cargarClientesListWidget(reporteGeneral.clientes[i], (i + 1));
      }
    }
    if (reporteGeneral.productos != null) {
      for (int i = 0; i < reporteGeneral.productos.length; i++) {
        cargarProductosListWidget(reporteGeneral.productos[i], (i + 1));
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

  cargarClientesListWidget(ClienteReporteGeneralDto cliente, int indice) {
    String textoTitle = indice.toString() + ". " + cliente.nombreCliente;
    String clienteTextRevisados = "revisados: " + cliente.totalClientes.toString();
    String clienteTextRechazados = "rechazados: " + cliente.cantidad.toString();
    String porcentajeText =
        "%: " + cliente.porcentajeCliente.toStringAsFixed(2) + "%";
    dynamic clienteSetear = Center(
        child: Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(leading: Icon(Icons.person), title: Text(textoTitle)),
        Column(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(clienteTextRevisados),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: Text(clienteTextRechazados),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: Text(porcentajeText),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ]),
    ));
    dinamicosClientes.add(clienteSetear);
  }

  cargarProductosListWidget(ProductoReporteGeneralDto producto, int indice) {
    String textoTitle = indice.toString() + ". " + producto.nombreProducto;
    String productoTextRevisados = "revisados: " + producto.totalProductos.toString();
    String productoTextRechazados = "rechazados: " + producto.cantidad.toString();
    String porcentajeText =
        "%: " + producto.porcentajeProducto.toStringAsFixed(2) + "%";
    dynamic productoSetear = Center(
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
                  child: Text(productoTextRevisados),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: Text(productoTextRechazados),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: Text(porcentajeText),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ]),
    ));
    dinamicosProductos.add(productoSetear);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.redAccent, width: 2)),
          width: double.infinity,
          child: Container(
            child: ListView(
              children: <Widget>[
                banderaList
                    ? Column(
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
                                    Expanded(
                                        child: Text('RAMOS REVISADOS:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)),
                                    Expanded(
                                        child: Text(
                                            '${reporteGeneral.ramosRevisados}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1))
                                  ],
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Divider(),
                          banderaList
                              ? Row(
                                  children: [
                                    Expanded(
                                        child: Text('RAMOS NO CONFORMES:    ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)),
                                    Expanded(
                                        child: Text(
                                            '${reporteGeneral.ramosNoConformes}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1))
                                  ],
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Divider(),
                          banderaList
                              ? Row(
                                  children: [
                                    Expanded(
                                        child: Text('%RAMOS NO CONFORMES: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)),
                                    Expanded(
                                        child: Text(
                                            '${reporteGeneral.porRamosNoConformes.toStringAsFixed(2)}' +
                                                '%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1))
                                  ],
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Divider(),
                          Divider(),
                          Column(
                            children: [
                              Text('RESUMEN CAUSAS - CLIENTES',
                                  style: Theme.of(context).textTheme.headline6)
                            ],
                          ),
                          Divider(),
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.primaries.last,
                                        width: 2))),
                          ),
                          Divider(),
                          banderaList
                              ? Column(
                                  children: dinamicosClientes,
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Divider(),
                          Divider(),
                          Column(
                            children: [
                              Text('RESUMEN CAUSAS - PRODUCTOS',
                                  style: Theme.of(context).textTheme.headline6)
                            ],
                          ),
                          Divider(),
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.primaries.last,
                                        width: 2))),
                          ),
                          Divider(),
                          banderaList
                              ? Column(
                                  children: dinamicosProductos,
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Divider(),
                          Divider(),
                          Column(
                            children: [
                              Text('RESUMEN CAUSAS - PROBLEMAS',
                                  style: Theme.of(context).textTheme.headline6)
                            ],
                          ),
                          Divider(),
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.primaries.last,
                                        width: 2))),
                          ),
                          Divider(),
                          banderaList
                              ? Column(
                                  children: dinamicos,
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                        ],
                      )
                    : Container(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          )),
      /*floatingActionButton: FloatingActionButton(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SincronizarPage()));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.red,
          textColor: Colors.white,
          child: Container(
            width: 130,
            height: 70,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Text(
                //   'FORMULARIOS',
                //   style: TextStyle(fontSize: 15),
                // ),
                Icon(Icons.save)
              ],
            ),
          ),
        ),
      ),*/
    );
  }
}
