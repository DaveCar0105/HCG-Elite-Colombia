import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/ramo.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/paginas/falencias_por_ramo.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

// ignore: must_be_immutable
class ListaRamosPage extends StatefulWidget {
  ControlRamos ramo = new ControlRamos();
  ListaRamosPage(this.ramo);
  @override
  _ListaRamosPageState createState() => _ListaRamosPageState(this.ramo);
}

class _ListaRamosPageState extends State<ListaRamosPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ControlRamos ramo = new ControlRamos();
  _ListaRamosPageState(this.ramo) {
    cargarRamos('');
  }
  List<Ramo> ramos = new List<Ramo>();

  cargarRamos(String x) async {
    ramos = [];
    ramos = await DatabaseRamos.getAllRamo(this.ramo.controlRamosId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Ramos revisados'),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: ramos.length,
        itemBuilder: (BuildContext context, int index) =>
            itemRamo(ramos[index], index + 1),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FalenciasPorRamo(
                      0, "", "", "", ramo.controlRamosId, cargarRamos)));
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add_circle),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 35,
          width: size.width - 10,
          child: RaisedButton(
            onPressed: () async {
              if (ramo.ramosAprobado == 0) {
                ramo.ramosHasta = DateTime.now().millisecondsSinceEpoch;
                ramo.ramosAprobado = 1;
                await DatabaseRamos.finRamos(ramo);
              }
              mostrarSnackbar("Ingreso Correcto", Colors.green, _scaffoldKey);
              Timer(Duration(milliseconds: 500), () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'home', (Route<dynamic> route) => false);
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Siguiente '),
          ),
        ),
      ],
    );
  }

  itemRamo(Ramo ramoItem, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(1, 1))
      ]),
      child: ListTile(
        title: Text('RAMO #$index'),
        subtitle: Text('Falencias: ${ramoItem.cantidadFalencias} '),
        leading: Icon(Icons.local_florist),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FalenciasPorRamo(
                      ramoItem.ramoId,
                      ramoItem.numeroMesa,
                      ramoItem.variedad,
                      ramoItem.linea,
                      ramo.controlRamosId,
                      cargarRamos)));
        },
        trailing: IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      height: 100,
                      width: 200,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text('Eliminar ramo?'),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text('Cancelar'),
                                ),
                                RaisedButton(
                                  onPressed: () async {
                                    await DatabaseRamos.deleteRamo(
                                        ramoItem.ramoId);
                                    Navigator.pop(context);
                                    cargarRamos('');
                                  },
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text('Aceptar'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )));
          },
        ),
      ),
    );
  }
}
