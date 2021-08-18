import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';

// ignore: must_be_immutable
class DetalleOrdenesClienteBanda extends StatefulWidget {
  int clienteId;
  DetalleOrdenesClienteBanda(this.clienteId);
  @override
  _DetalleOrdenesClienteBandaState createState() =>
      _DetalleOrdenesClienteBandaState(this.clienteId);
}

class _DetalleOrdenesClienteBandaState extends State<DetalleOrdenesClienteBanda>
    with SingleTickerProviderStateMixin {
  int clienteId;
  TabController _controller;
  List<OrdenEmpaque> listaEmpaque = List();
  List<OrdenBanda> listaRamo = List();
  List<Widget> list = [
    Tab(icon: Icon(Icons.local_florist)),
    //Tab(icon: Icon(Icons.view_compact)),
  ];

  _DetalleOrdenesClienteBandaState(this.clienteId);

  cargarOrdenes() async {
    listaRamo =
        await DatabaseReportesAprobacion.getAllOrdenesBanda(this.clienteId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: list.length, vsync: this);
    cargarOrdenes();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          onTap: (index) {
            // Should not used it as it only called when tab options are clicked,
            // not when user swapped
          },
          controller: _controller,
          tabs: list,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Center(
            child: ListView.builder(
              itemCount: listaRamo.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 7)
                      ]),
                  child: ListTile(
                    title: Text(' Finca: ' +
                        listaRamo[index].postCosechaNombre +
                        '\n Cliente: ' +
                        listaRamo[index].clienteNombre +
                        '\n Nro Orden: ' +
                        listaRamo[index].numeroOrden +
                        '\n Producto: ' +
                        listaRamo[index].productoNombre +
                        '\n Tipo Control: ' +
                        listaRamo[index].tipoControlNombre +
                        '\n Marca: ' +
                        listaRamo[index].marca +
                        '\n '),
                    subtitle: Text(' Ramos a despachar: ' +
                        listaRamo[index].ramosADespachar.toString() +
                        '\n Ramos elaborados: ' +
                        listaRamo[index].ramosElaborados.toString() +
                        '\n % Inspección: ' +
                        listaRamo[index].inspeccion.toStringAsFixed(2) +
                        '%' +
                        '\n Total ramos no conformes: ' +
                        listaRamo[index].ramosNoConformes.toString() +
                        '\n % Ramos no conformes: ' +
                        listaRamo[index].ramoInconformidad.toStringAsFixed(2) +
                        '%' +
                        '\n Falencia principal: ' +
                        listaRamo[index].falenciaPrincipal +
                        '\n Falencia secundaria: ' +
                        listaRamo[index].falenciaSegundaria +
                        '\n '),
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Desea eliminar esta orden?'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('Aceptar'),
                                          onPressed: () async {
                                            await DatabaseFirma
                                                .borrarReportesBanda(
                                                    listaRamo[index]
                                                        .ordenRamoId);
                                            cargarOrdenes();
                                            Navigator.pop(context);
                                            Navigator.pushReplacementNamed(
                                                context, 'home');
                                          },
                                        ),
                                        RaisedButton(
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
