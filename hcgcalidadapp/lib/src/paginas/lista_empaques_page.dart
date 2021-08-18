import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/empaque.dart';
import 'package:hcgcalidadapp/src/modelos/empaque_item.dart';
import 'package:hcgcalidadapp/src/paginas/falencias_por_caja.dart';

// ignore: must_be_immutable
class ListaEmpaquePage extends StatefulWidget {
  ControlEmpaque empaque = new ControlEmpaque();
  ListaEmpaquePage(this.empaque);
  @override
  _ListaEmpaquePageState createState() => _ListaEmpaquePageState(this.empaque);
}

class _ListaEmpaquePageState extends State<ListaEmpaquePage> {
  ControlEmpaque empaque = new ControlEmpaque();
  _ListaEmpaquePageState(this.empaque) {
    cargarEmpaques('');
  }
  List<Empaque> empaques = new List<Empaque>();

  cargarEmpaques(String x) async {
    empaques = [];
    empaques = await DatabaseEmpaque.getAllEmpaque(empaque.controlEmpaqueId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Empaque'),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: empaques.length,
        itemBuilder: (BuildContext context, int index) =>
            itemEmpaque(empaques[index], index + 1),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FalenciasPorCaja(
                                              0,
                                              "",
                                              "",
                                              "",
                                              empaque.controlEmpaqueId,
                                              0,
                                              cargarEmpaques)));
                            },
                            child: Text('RAMO'),
                          ),
                          RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FalenciasPorCaja(
                                              0,
                                              "",
                                              "",
                                              "",
                                              empaque.controlEmpaqueId,
                                              1,
                                              cargarEmpaques)));
                            },
                            child: Text('CAJA'),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add_circle),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 35,
          width: size.width - 10,
          child: RaisedButton(
            onPressed: () async {
              if (empaque.empaqueAprobado == 0) {
                empaque.empaqueAprobado = 1;
                empaque.empaqueHasta = DateTime.now().millisecondsSinceEpoch;
                await DatabaseEmpaque.finEmpaques(empaque);
              }
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'home', (Route<dynamic> route) => false);
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

  itemEmpaque(Empaque empaqueItem, int index) {
    String tipo = '';
    int tipoId = 0;
    if (empaqueItem.tipo.compareTo('C') == 0) {
      tipo = 'CAJA';
      tipoId = 1;
    } else {
      tipo = 'RAMO';
    }
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
        title: Text('Empaque #$index'),
        subtitle:
            Text('Falencias: ${empaqueItem.cantidadFalencias} - Tipo:  $tipo'),
        leading: Icon(Icons.local_florist),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FalenciasPorCaja(
                      empaqueItem.empaqueId,
                      empaqueItem.numeroMesa,
                      empaqueItem.variedad,
                      empaqueItem.linea,
                      empaque.controlEmpaqueId,
                      tipoId,
                      cargarEmpaques)));
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
                            child: Text('Eliminar empaque?'),
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
                                    await DatabaseEmpaque.deleteEmpaque(
                                        empaqueItem.empaqueId);
                                    Navigator.pop(context);
                                    cargarEmpaques('');
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
