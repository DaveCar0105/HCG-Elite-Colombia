import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/modelos/banda.dart';
import 'package:hcgcalidadapp/src/modelos/control_banda.dart';
import 'package:hcgcalidadapp/src/paginas/falencias_por_ramo_banda.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

// ignore: must_be_immutable
class ListaBandasRamosPage extends StatefulWidget {
  ControlBanda ramo = new ControlBanda();
  ListaBandasRamosPage(this.ramo);
  @override
  _ListaBandasRamosPageState createState() =>
      _ListaBandasRamosPageState(this.ramo);
}

class _ListaBandasRamosPageState extends State<ListaBandasRamosPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ControlBanda ramo = new ControlBanda();
  _ListaBandasRamosPageState(this.ramo) {
    cargarRamos('');
  }
  List<Banda> ramosBanda = new List<Banda>();

  cargarRamos(String x) async {
    ramosBanda = [];
    ramosBanda = await DatabaseBanda.getAllBanda(this.ramo.controlRamosId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Ramos revisados Banda'),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: ramosBanda.length,
        itemBuilder: (BuildContext context, int index) =>
            itemRamo(ramosBanda[index], index + 1),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FalenciasPorRamoBanda(
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
                await DatabaseBanda.finBandas(ramo);
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

  itemRamo(Banda ramoItem, int index) {
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
        subtitle: Text('Numero de Falencias: ${ramoItem.cantidadFalencias} '),
        leading: Icon(Icons.local_florist),
        onTap: () {
          print("entro");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FalenciasPorRamoBanda(
                      ramoItem.ramoId,
                      ramoItem.numeroMesa,
                      ramoItem.variedad,
                      ramoItem.linea,
                      ramo.controlRamosId,
                      cargarRamos)));
          print('${ramoItem.ramoId} --------------');
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
                                    await DatabaseBanda.deleteBanda(
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
