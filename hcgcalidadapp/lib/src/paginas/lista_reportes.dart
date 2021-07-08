import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';

// ignore: must_be_immutable
class ListaReportes extends StatefulWidget {

  @override
  _ListaReportesState createState() => _ListaReportesState();
}

class _ListaReportesState extends State<ListaReportes> with SingleTickerProviderStateMixin{
  int clienteId;
  TabController _controller;
  List<OrdenEmpaque> listaEmpaque = List();
  List<OrdenRamo> listaRamo = List();
  List<Widget> list = [
    Tab(icon: Icon(Icons.local_florist)),
    Tab(icon: Icon(Icons.view_compact)),
  ];

  cargarOrdenes() async{
    listaEmpaque = await DatabaseReportesAprobacion.getAllOrden();
    listaRamo =await DatabaseReportesAprobacion.getAllOrdenRamos();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: list.length, vsync: this);
    cargarOrdenes();
    _controller.addListener(() {
      setState(() {
      });
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
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 7
                        )
                      ]
                  ),
                  child:ListTile(
                    title: Text(' Finca: ' +listaRamo[index].postCosechaNombre +
                        '\n Cliente: '+listaRamo[index].clienteNombre +
                        '\n Nro Orden: '+listaRamo[index].numeroOrden +
                        '\n Producto: ' +listaRamo[index].productoNombre +
                        '\n Marca: ' +listaRamo[index].marca + '\n '
                    ),
                    subtitle: Text(' Ramos a despachar: ' +listaRamo[index].ramosADespachar.toString() +
                        '\n Ramos elaborados: ' + listaRamo[index].ramosElaborados.toString() +
                        '\n % Inspección: ' + listaRamo[index].inspeccion.toStringAsFixed(2) + '%' +
                        '\n Total ramos no conformes: ' + listaRamo[index].ramosNoConformes.toString() +
                        '\n % Ramos no conformes: '+listaRamo[index].ramoInconformidad.toStringAsFixed(2) + '%' +
                        '\n Falencia principal: ' +listaRamo[index].falenciaPrincipal +
                        '\n Falencia secundaria: ' + listaRamo[index].falenciaSegundaria + '\n '
                    ),
                    onLongPress: () async{
                      showDialog(
                          context: context,
                          builder: (BuildContext context)=>Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Desea reintentar sincronizar esta orden?'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('Aceptar'),
                                          onPressed: () async {
                                            await DatabaseFirma.reintReportesRamos(listaRamo[index].ordenRamoId);
                                            cargarOrdenes();
                                            Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
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
                              )
                          )
                      );


                    },

                  ),
                );
              },
            ),
          ),
          Center(
            child: ListView.builder(
              itemCount: listaEmpaque.length,
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 7
                        )
                      ]
                  ),
                  child: ListTile(
                    title: Text(' Finca: ' +listaEmpaque[index].postCosechaNombre +
                        '\n Cliente: '+listaEmpaque[index].clienteNombre +
                        '\n Nro Orden: '+listaEmpaque[index].numeroOrden +
                        '\n Producto: ' +listaEmpaque[index].productoNombre +
                        '\n Marca: ' +listaEmpaque[index].marca + '\n'
                    ),
                    subtitle: Text(' Cajas a despachar: '+ listaEmpaque[index].cajasDespachar.toString() +
                        '\n Cajas revisadas: '+ listaEmpaque[index].cajasRevisadas.toString() +
                        '\n % No conformidad cajas: ' + listaEmpaque[index].empaqueInconformidadCajas.toStringAsFixed(2) + '%'+
                        '\n Falencia principal (cajas): ' + listaEmpaque[index].falenciaPrincipalCajas.toString() +
                        '\n Falencia segundaria (cajas): ' + listaEmpaque[index].falenciaSegundariaCajas.toString() +
                        '\n Ramos revisados: ' + listaEmpaque[index].ramosRevisados.toString() +
                        '\n Ramos no conformes: ' + listaEmpaque[index].ramosNoConformes.toString() +
                        '\n % No conformidad ramos: ' + listaEmpaque[index].empaqueInconformidadRamos.toStringAsFixed(2) +'%'+
                        '\n Falencia principal (ramos): ' + listaEmpaque[index].falenciaPrincipalRamos.toString() +
                        '\n Falencia segundaria (ramos): ' + listaEmpaque[index].falenciaSegundariaRamos.toString()+ '\n'
                    ),
                    onLongPress: () async{
                      showDialog(
                          context: context,
                          builder: (BuildContext context)=>Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Desea reintentar sincronizar esta orden?'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('Aceptar'),
                                          onPressed: () async {
                                            await DatabaseFirma.reintReportesEmpaque(listaEmpaque[index].ordenEmpaqueId);
                                            cargarOrdenes();
                                            Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
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
                              )
                          )
                      );

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
