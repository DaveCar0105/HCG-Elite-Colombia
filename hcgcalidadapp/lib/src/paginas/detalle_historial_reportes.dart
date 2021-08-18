import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';

class DetalleHistorialReporteGeneralPage extends StatefulWidget {
  final CirculoCalidadInformacionGeneral data;

  DetalleHistorialReporteGeneralPage({this.data});

  @override
  _DetalleHistorialReporteGeneralPageState createState() =>
      _DetalleHistorialReporteGeneralPageState(data: data);
}

class _DetalleHistorialReporteGeneralPageState
    extends State<DetalleHistorialReporteGeneralPage> {
  final CirculoCalidadInformacionGeneral data;
  _DetalleHistorialReporteGeneralPageState({this.data});

  bool loading = true;

  get rows => null;

  bool sinc = false;
  bool reporteGeneralValue;
  bool ramosRevisadosValue;
  bool ramosNoConformes;
  bool porRamosNoConformes;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Widget> dinamicos = List<Widget>();
  List<Widget> dinamicosClientes = List<Widget>();
  List<Widget> dinamicosProductos = List<Widget>();
  List<Widget> dinamicosVariedad = List<Widget>();
  List<Widget> dinamicosNumeroMesa = List<Widget>();
  List<Widget> dinamicosLinea = List<Widget>();
  List<Producto> listaAllProductos = new List<Producto>();
  List<Cliente> listaAllClientes = new List<Cliente>();
  List<FalenciaRamos> listaAllFalencias = new List<FalenciaRamos>();
  bool banderaList = false;

  //VARIABLE DE CIRCULO DE CALIDAD
  final GlobalKey<FormState> _formCirculoCalidadKey = GlobalKey<FormState>();
  final numeroReunionTextEditingController = TextEditingController();
  final supervisor1TextEditingController = TextEditingController();
  final supervisor2TextEditingController = TextEditingController();
  final comentarioTextEditingController = TextEditingController();
  List<String> evaluacion = ["Bueno", "Regular", "Excelente"];

  @override
  void initState() {
    cargarLista();
    super.initState();
  }

  cargarLista() async {
    dinamicos = new List<Widget>();
    dinamicosProductos = new List<Widget>();
    dinamicosVariedad = new List<Widget>();
    dinamicosNumeroMesa = new List<Widget>();
    dinamicosLinea = new List<Widget>();
    dinamicosClientes = new List<Widget>();
    listaAllProductos = await DatabaseProducto.getAllProductos(1);
    listaAllClientes = await DatabaseCliente.getAllCliente(1);
    listaAllFalencias = await DatabaseFalenciaRamos.getAllFalenciaRamos();
    if (data.circuloCalidad.circuloCalidadPorcentajeNoConforme == null)
      data.circuloCalidad.circuloCalidadPorcentajeNoConforme = 0;
    if (data.listaCirculoCalidadFalencia != null) {
      for (int i = 0; i < data.listaCirculoCalidadFalencia.length; i++) {
        cargarFalenciaListWidget(data.listaCirculoCalidadFalencia[i], (i + 1));
      }
    }
    if (data.listaCirculoCalidadCliente != null) {
      for (int i = 0; i < data.listaCirculoCalidadCliente.length; i++) {
        cargarClientesListWidget(data.listaCirculoCalidadCliente[i], (i + 1));
      }
    }
    if (data.listaCirculoCalidadProducto != null) {
      for (int i = 0; i < data.listaCirculoCalidadProducto.length; i++) {
        cargarProductosListWidget(data.listaCirculoCalidadProducto[i], (i + 1));
      }
    }
    if (data.listaCirculoCalidadVariedad != null) {
      for (int i = 0; i < data.listaCirculoCalidadVariedad.length; i++) {
        cargarVariedadListWidget(data.listaCirculoCalidadVariedad[i], (i + 1));
      }
    }
    if (data.listaCirculoCalidadNumeroMesa != null) {
      for (int i = 0; i < data.listaCirculoCalidadNumeroMesa.length; i++) {
        cargarNumeroMesaListWidget(data.listaCirculoCalidadNumeroMesa[i], (i + 1));
      }
    }
    if (data.listaCirculoCalidadLinea != null) {
      for (int i = 0; i < data.listaCirculoCalidadLinea.length; i++) {
        cargarLineaListWidget(data.listaCirculoCalidadLinea[i], (i + 1));
      }
    }
    setState(() {
      banderaList = true;
    });
  }

  cargarFalenciaListWidget(CirculoCalidadFalencia falencia, int indice) {
    String tituloObjeto = "No encontrado";
    int indice2 = listaAllFalencias.lastIndexWhere((element) => element.falenciaRamosId==falencia.falenciaRamosId);
    if (indice2!=-1){
      tituloObjeto = listaAllFalencias[indice2].falenciaRamosNombre;
    }
    String textoTitle = indice.toString() + ". " + tituloObjeto.toString();
    String falenciaText = "Falencias: " + falencia.rechazados.toString();
    String porcentajeText =
        "Porcentaje: " + falencia.porcentaje.toStringAsFixed(2) + "%";

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

  cargarClientesListWidget(CirculoCalidadCliente cliente, int indice) {
    String tituloObjeto = "No encontrado";
    int indice2 = listaAllClientes.lastIndexWhere((element) => element.clienteId==cliente.clienteId);
    if (indice2!=-1){
      tituloObjeto = listaAllClientes[indice2].clienteNombre;
    }
    String textoTitle = indice.toString() + ". " + tituloObjeto;
    String clienteTextRevisados =
        "revisados: " + cliente.revisados.toString();
    String clienteTextRechazados = "rechazados: " + cliente.rechazados.toString();
    String porcentajeText =
        "%: " + cliente.porcentaje.toStringAsFixed(2) + "%";
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

  cargarProductosListWidget(CirculoCalidadProducto producto, int indice) {
    String tituloObjeto = "No encontrado";
    int indice2 = listaAllProductos.lastIndexWhere((element) => element.productoId==producto.productoId);
    if (indice2!=-1){
      tituloObjeto = listaAllProductos[indice2].productoNombre;
    }
    String textoTitle = indice.toString() + ". " + tituloObjeto.toString();
    String productoTextRevisados =
        "revisados: " + producto.revisados.toString();
    String productoTextRechazados =
        "rechazados: " + producto.rechazados.toString();
    String porcentajeText =
        "%: " + producto.porcentaje.toStringAsFixed(2) + "%";
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

  cargarVariedadListWidget(CirculoCalidadVariedad variedad, int indice) {
    String textoTitle = indice.toString() + ". " + variedad.circuloCalidadVariedadNombre;
    String falenciaText = "Cantidad: " + variedad.rechazados.toString();

    String porcentajeText =
        "Porcentaje: " + variedad.porcentaje.toStringAsFixed(2) + "%";

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
    dinamicosVariedad.add(falenciaSetear);
  }

  cargarNumeroMesaListWidget(
      CirculoCalidadNumeroMesa numeroMesa, int indice) {
    String textoTitle = indice.toString() + ". " + numeroMesa.circuloCalidadNumeroMesaNombre;
    String falenciaText = "Cantidad: " + numeroMesa.rechazados.toString();

    String porcentajeText = "Porcentaje: " +
        numeroMesa.porcentaje.toStringAsFixed(2) +
        "%";

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
    dinamicosNumeroMesa.add(falenciaSetear);
  }

  cargarLineaListWidget(CirculoCalidadLinea linea, int indice) {
    String textoTitle = indice.toString() + ". " + linea.circuloCalidadLineaNombre;
    String falenciaText = "Cantidad: " + linea.rechazados.toString();

    String porcentajeText =
        "Porcentaje: " + linea.porcentaje.toStringAsFixed(2) + "%";

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
    dinamicosLinea.add(falenciaSetear);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Resumen de reporte"),
      ),
      key: scaffoldKey,
      body: ProgressHUD(
          child: Builder(
        builder: (context) => Container(
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
                                    style:
                                        Theme.of(context).textTheme.headline6),
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
                                              '${data.circuloCalidad.circuloCalidadRevisados}',
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
                                              '${data.circuloCalidad.circuloCalidadRechazados}',
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
                                              '${data.circuloCalidad.circuloCalidadPorcentajeNoConforme.toStringAsFixed(2)}' +
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
                                    style:
                                        Theme.of(context).textTheme.headline6)
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
                                    style:
                                        Theme.of(context).textTheme.headline6)
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
                                Text('RESUMEN CAUSAS - VARIEDAD',
                                    style:
                                        Theme.of(context).textTheme.headline6)
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
                                    children: dinamicosVariedad,
                                  )
                                : Container(
                                    child: CircularProgressIndicator(),
                                  ),
                            Divider(),
                            Divider(),
                            Column(
                              children: [
                                Text('RESUMEN CAUSAS - # MESA',
                                    style:
                                        Theme.of(context).textTheme.headline6)
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
                                    children: dinamicosNumeroMesa,
                                  )
                                : Container(
                                    child: CircularProgressIndicator(),
                                  ),
                            Divider(),
                            Divider(),
                            Column(
                              children: [
                                Text('RESUMEN CAUSAS - LÍNEA',
                                    style:
                                        Theme.of(context).textTheme.headline6)
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
                                    children: dinamicosLinea,
                                  )
                                : Container(
                                    child: CircularProgressIndicator(),
                                  ),
                            Divider(),
                            Divider(),
                            Column(
                              children: [
                                Text('RESUMEN CAUSAS - PROBLEMAS',
                                    style:
                                        Theme.of(context).textTheme.headline6)
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
                            Divider(),
                            Divider(),
                            Column(
                              children: [
                                Text('FORMULARIO CÍRCULO CALIDAD',
                                    style:
                                        Theme.of(context).textTheme.headline6)
                              ],
                            ),
                            Divider(),
                            Container(
                                //margin: EdgeInsets.all(10),
                                //padding: EdgeInsets.all(15),
                                child: Form(
                              key: _formCirculoCalidadKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //DataTable( rows: reportesLista.map<DataRow>((element) => DataRow(cells: cells))),

                                  //rows: DataRow(cells: cells),
                                  Text(
                                      'Numero de Reunion:\t' +
                                          data.circuloCalidad.circuloCalidadNumeroReunion
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Divider(),
                                  Text(
                                      'Nombre Supervisor 1:' +
                                          data.circuloCalidad.circuloCalidadSupervisor
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Divider(),
                                  Text(
                                      'Evaluacion Supervisor 1:' +
                                          data.circuloCalidad.circuloCalidadEvaluacionSupervisor
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Divider(),
                                  Text(
                                      'Nombre Supervisor 2:' +
                                          data.circuloCalidad.circuloCalidadSupervisor2
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Divider(),
                                  Text(
                                      'Evaluacion Supervisor 2:' +
                                          data.circuloCalidad.circuloCalidadEvaluacionSupervisor2
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  Divider(),
                                  Text(
                                      'Comentario:' +
                                          data.circuloCalidad.circuloCalidadComentario
                                              .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                ],
                              ),
                            ))
                          ],
                        )
                      : Container(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            )),
      )),
    );
  }
}
