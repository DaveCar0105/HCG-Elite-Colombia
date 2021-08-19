import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hcgcalidadapp/src/basedatos/database_circulo_calidad.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reporte_general.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';
//import 'package:hcgcalidadapp/src/paginas/historial_reportes_page.dart';
import 'package:hcgcalidadapp/src/paginas/historial_reportes_page2.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

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
  List<Widget> dinamicosVariedad = List<Widget>();
  List<Widget> dinamicosNumeroMesa = List<Widget>();
  List<Widget> dinamicosLinea = List<Widget>();
  bool banderaList = false;

  //VARIABLE DE CIRCULO DE CALIDAD
  final GlobalKey<FormState> _formCirculoCalidadKey = GlobalKey<FormState>();
  final numeroReunionTextEditingController = TextEditingController();
  final supervisor1TextEditingController = TextEditingController();
  final supervisor2TextEditingController = TextEditingController();
  final comentarioTextEditingController = TextEditingController();
  int _supervisor1GroupValue = -1;
  int _supervisor2GroupValue = -1;
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
    reporteGeneral = await DatabaseReporteGeneral.getReporteGeneral();
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
    if (reporteGeneral.variedades != null) {
      for (int i = 0; i < reporteGeneral.variedades.length; i++) {
        cargarVariedadListWidget(reporteGeneral.variedades[i], (i + 1));
      }
    }
    if (reporteGeneral.numerosMesa != null) {
      for (int i = 0; i < reporteGeneral.numerosMesa.length; i++) {
        cargarNumeroMesaListWidget(reporteGeneral.numerosMesa[i], (i + 1));
      }
    }
    if (reporteGeneral.lineas != null) {
      for (int i = 0; i < reporteGeneral.lineas.length; i++) {
        cargarLineaListWidget(reporteGeneral.lineas[i], (i + 1));
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
    String clienteTextRevisados =
        "revisados: " + cliente.totalClientes.toString();
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
    String productoTextRevisados =
        "revisados: " + producto.totalProductos.toString();
    String productoTextRechazados =
        "rechazados: " + producto.cantidad.toString();
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

  cargarVariedadListWidget(VariedadReporteGeneralDto variedad, int indice) {
    String textoTitle = indice.toString() + ". " + variedad.nombreVariedad;
    String falenciaText = "Cantidad: " + variedad.cantidad.toString();

    String porcentajeText =
        "Porcentaje: " + variedad.porcentajeVariedad.toStringAsFixed(2) + "%";

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
      NumeroMesaReporteGeneralDto numeroMesa, int indice) {
    String textoTitle = indice.toString() + ". " + numeroMesa.nombreNumeroMesa;
    String falenciaText = "Cantidad: " + numeroMesa.cantidad.toString();

    String porcentajeText = "Porcentaje: " +
        numeroMesa.porcentajeNumeroMesa.toStringAsFixed(2) +
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

  cargarLineaListWidget(LineaReporteGeneralDto linea, int indice) {
    String textoTitle = indice.toString() + ". " + linea.nombreLinea;
    String falenciaText = "Cantidad: " + linea.cantidad.toString();

    String porcentajeText =
        "Porcentaje: " + linea.porcentajeLinea.toStringAsFixed(2) + "%";

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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
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
                                            child: Text(
                                                'RAMOS NO CONFORMES:    ',
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
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Número de reunión",
                                        hintText: 'Ingrese el # reunión',
                                      ),
                                      controller:
                                          numeroReunionTextEditingController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Llene este campo";
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Nombre supervisor 1",
                                        hintText:
                                            'Ingrese el nombre del supervisor',
                                      ),
                                      controller:
                                          supervisor1TextEditingController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Llene este campo";
                                        }
                                      },
                                    ),
                                    Divider(),
                                    Text('Evaluación supervisor 1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Row(children: [
                                          Radio(
                                              value: 1,
                                              groupValue:
                                                  _supervisor1GroupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _supervisor1GroupValue =
                                                      value;
                                                });
                                              }),
                                          Text('Regular',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ])),
                                        Expanded(
                                            child: Row(children: [
                                          Radio(
                                              value: 2,
                                              groupValue:
                                                  _supervisor1GroupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _supervisor1GroupValue =
                                                      value;
                                                });
                                              }),
                                          Text('Bueno',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ])),
                                        Expanded(
                                            child: Row(children: [
                                          Radio(
                                              value: 3,
                                              groupValue:
                                                  _supervisor1GroupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _supervisor1GroupValue =
                                                      value;
                                                });
                                              }),
                                          Text('Excelente',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ])),
                                      ],
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Nombre supervisor 2",
                                        hintText:
                                            'Ingrese el nombre del supervisor',
                                      ),
                                      controller:
                                          supervisor2TextEditingController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Llene este campo";
                                        }
                                      },
                                    ),
                                    Divider(),
                                    Text('Evaluación supervisor 2',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Row(children: [
                                          Radio(
                                              value: 1,
                                              groupValue:
                                                  _supervisor2GroupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _supervisor2GroupValue =
                                                      value;
                                                });
                                              }),
                                          Text('Regular',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ])),
                                        Expanded(
                                            child: Row(children: [
                                          Radio(
                                              value: 2,
                                              groupValue:
                                                  _supervisor2GroupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _supervisor2GroupValue =
                                                      value;
                                                });
                                              }),
                                          Text('Bueno',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ])),
                                        Expanded(
                                            child: Row(children: [
                                          Radio(
                                              value: 3,
                                              groupValue:
                                                  _supervisor2GroupValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _supervisor2GroupValue =
                                                      value;
                                                });
                                              }),
                                          Text('Excelente',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2)
                                        ])),
                                      ],
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Comentario",
                                        hintText: 'Ingrese el comentario',
                                      ),
                                      controller:
                                          comentarioTextEditingController,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Llene este campo";
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          if (_formCirculoCalidadKey
                                                  .currentState
                                                  .validate() &&
                                              _supervisor1GroupValue != -1 &&
                                              _supervisor2GroupValue != -1) {
                                            final progress =
                                                ProgressHUD.of(context);
                                            progress
                                                ?.showWithText('Guardando...');
                                            String selectSup1 = evaluacion[
                                                _supervisor1GroupValue - 1];
                                            String selectSup2 = evaluacion[
                                                _supervisor2GroupValue - 1];
                                            CirculoCalidad circuloCalidad =
                                                new CirculoCalidad();
                                            circuloCalidad
                                                    .circuloCalidadNumeroReunion =
                                                int.parse(
                                                    numeroReunionTextEditingController
                                                        .text);
                                            circuloCalidad
                                                    .circuloCalidadSupervisor =
                                                supervisor1TextEditingController
                                                    .text;
                                            circuloCalidad
                                                    .circuloCalidadSupervisor2 =
                                                supervisor2TextEditingController
                                                    .text;
                                            circuloCalidad
                                                    .circuloCalidadEvaluacionSupervisor =
                                                selectSup1;
                                            circuloCalidad
                                                    .circuloCalidadEvaluacionSupervisor2 =
                                                selectSup2;
                                            circuloCalidad
                                                    .circuloCalidadComentario =
                                                comentarioTextEditingController
                                                    .text;
                                                    circuloCalidad.postcosechaId = reporteGeneral.postcosechaId;
                                            try {
                                              await DatabaseCirculoCalidad
                                                  .addcirculoCalidadByReporteGeneral(
                                                      reporteGeneral,
                                                      circuloCalidad);
                                              await DatabaseCirculoCalidad
                                                  .ciruculoCalidadSaveChangeEntitiesHidratacionEmpaqueFinBanda();
                                              progress?.dismiss();
                                              mostrarSnackbar(
                                                  "Guardado exitosamente",
                                                  Colors.green,
                                                  scaffoldKey);
                                              setState(() {});
                                              Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                                            } catch (e) {
                                              progress?.dismiss();
                                              mostrarSnackbar(
                                                  "Error al guardar",
                                                  Colors.redAccent,
                                                  scaffoldKey);
                                            }
                                          } else {
                                            mostrarSnackbar(
                                                "Llenar todo el formulario",
                                                Colors.redAccent,
                                                scaffoldKey);
                                          }
                                        },
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        child: Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  'Generar circulo de calidad '),
                                              Icon(Icons.save)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.description),
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListaReporteGeneralPage2()));
          },
        ));
  }
}
