import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_destinoecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/control_destinoecommerce.dto.dart';
import 'package:hcgcalidadapp/src/modelos/destino_ecommerce.dto.dart';
import 'package:hcgcalidadapp/src/paginas/formularios/destinoEcommerce/falencia_por_destino_ecommerce_page.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

// ignore: must_be_immutable
class ListaDestinoEcommercePage extends StatefulWidget {
  ControlDestinoEcommerceDto controlDestinoEcommerce =
      new ControlDestinoEcommerceDto();
  ListaDestinoEcommercePage(this.controlDestinoEcommerce);
  @override
  _ListaDestinoEcommercePageState createState() =>
      _ListaDestinoEcommercePageState(this.controlDestinoEcommerce);
}

class _ListaDestinoEcommercePageState extends State<ListaDestinoEcommercePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ControlDestinoEcommerceDto controlDestinoEcommerce =
      new ControlDestinoEcommerceDto();
  _ListaDestinoEcommercePageState(this.controlDestinoEcommerce) {
    cargarDestinoEcommerce('');
  }
  List<DestinoEcommerceDetalleFalenciaDto> listDestinoEcommerce =
      new List<DestinoEcommerceDetalleFalenciaDto>();

  cargarDestinoEcommerce(String x) async {
    listDestinoEcommerce = [];
    listDestinoEcommerce = await DatabaseControlDestinoEcommerce
        .getAllDestinosEcommerceByControlDestinoEcommerceId(
            this.controlDestinoEcommerce.controlDestinoEcommerceId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Destinos ecommerce revisados'),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: listDestinoEcommerce.length,
        itemBuilder: (BuildContext context, int index) =>
            itemDestinoEcommerce(listDestinoEcommerce[index], index + 1),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FalenciasPorDestinoEcommercePage(
                          0,
                          controlDestinoEcommerce.controlDestinoEcommerceId,
                          cargarDestinoEcommerce)));
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
              if (controlDestinoEcommerce.controlDestinoEcommerceAprobado ==
                  0) {
                controlDestinoEcommerce.controlDestinoEcommerceHasta =
                    DateTime.now().millisecondsSinceEpoch;
                controlDestinoEcommerce.controlDestinoEcommerceAprobado = 1;
                await DatabaseControlDestinoEcommerce
                    .updateControlDestinoEcommerceAprobado(
                        controlDestinoEcommerce);
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

  itemDestinoEcommerce(
      DestinoEcommerceDetalleFalenciaDto destinoEcommerceItem, int index) {
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
        title: Text('Destino ecommerce #$index'),
        subtitle: Text('Falencias: ${destinoEcommerceItem.cantidadFalencias} '),
        leading: Icon(Icons.local_florist),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FalenciasPorDestinoEcommercePage(
                          destinoEcommerceItem.destinoEcommerceId,
                          destinoEcommerceItem.controlDestinoEcommerceId,
                          cargarDestinoEcommerce)));
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
                            child: Text('Eliminar destino ecommerce?'),
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
                                    print(destinoEcommerceItem
                                        .destinoEcommerceId);
                                    await DatabaseControlDestinoEcommerce
                                        .deleteDestinoEcommerce(
                                            destinoEcommerceItem
                                                .destinoEcommerceId);
                                    Navigator.pop(context);
                                    cargarDestinoEcommerce('');
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
