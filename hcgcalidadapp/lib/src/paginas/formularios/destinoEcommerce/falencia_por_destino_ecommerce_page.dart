import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_destinoecommerce.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/destino_ecommerce.dto.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_control_destinoEcommerce.dto.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';

// ignore: must_be_immutable
class FalenciasPorDestinoEcommercePage extends StatefulWidget {
  int destinoEcommerceId;
  int controlDestionoEcommerceId;
  final ValueChanged<String> actualizarLista;
  FalenciasPorDestinoEcommercePage(this.destinoEcommerceId,
      this.controlDestionoEcommerceId, this.actualizarLista);
  @override
  _FalenciasPorDestinoEcommercePageState createState() =>
      _FalenciasPorDestinoEcommercePageState(
          this.destinoEcommerceId, this.controlDestionoEcommerceId);
}

class _FalenciasPorDestinoEcommercePageState
    extends State<FalenciasPorDestinoEcommercePage> {
  GlobalKey<ListaBusquedaState> _keyFalencias = GlobalKey();
  static List<AutoComplete> listaFalencias = new List<AutoComplete>();
  String falenciaNombre = "";
  int falenciaId = 0;
  bool falenciaEnable = false;

  List<FalenciaReporteDestinoEcommerce> listaFalenciasReporte = List();
  int destinoEcommerceId;
  int controlDestinoEcommerceId;

  _FalenciasPorDestinoEcommercePageState(
      this.destinoEcommerceId, this.controlDestinoEcommerceId) {
    cargarLista(this.destinoEcommerceId);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Falencias por destino-ecommerce"),
      ),
      body: Scrollbar(
          child: Column(children: [
        Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: listaFalenciasReporte.length,
              itemBuilder: (context, index) =>
                  _itemFalencia(listaFalenciasReporte[index], size)),
        )
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          listaFalencias = [];
          List<FalenciaRamos> falenciaRamos = List();
          falenciaRamos = await DatabaseFalenciaRamos.getAllFalenciaRamos();
          falenciaRamos.forEach((element) {
            listaFalencias.add(AutoComplete(
                id: element.falenciaRamosId,
                nombre: element.falenciaRamosNombre));
          });
          setState(() {
            falenciaEnable = true;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Nueva Falencia',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          falenciaEnable
                              ? ListaBusqueda(
                                  key: _keyFalencias,
                                  lista: listaFalencias,
                                  hintText: "Falencias",
                                  valorDefecto: falenciaNombre,
                                  hintSearchText:
                                      "Escriba el nombre de la falencia",
                                  icon: Icon(Icons.bug_report),
                                  width: w - 160,
                                  style: TextStyle(fontSize: 14),
                                  parentAction: (value) {
                                    if (value != null && value != "") {
                                      AutoComplete falencia =
                                          listaFalencias.firstWhere((item) {
                                        return item.nombre == value;
                                      });
                                      falenciaId = falencia.id;
                                    }
                                  },
                                )
                              : Container(
                                  child: CircularProgressIndicator(),
                                ),
                          Expanded(child: Container()),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () async {
                              await agregarFalencia();
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              child: Text('Agregar'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          height: 35,
          width: w - 10,
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Aceptar '),
          ),
        ),
      ],
    );
  }

  Widget _itemFalencia(FalenciaReporteDestinoEcommerce falencia, Size size) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  falencia.falenciaRamosNombre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.4 - 40,
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                await DatabaseControlDestinoEcommerce
                    .deleteFalenciaDestinoEcommerceByFalenciaRamoIdDestinoId(
                        falencia.falenciaRamosId, destinoEcommerceId);
                cargarLista(destinoEcommerceId);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              child:
                  Container(height: 50, width: 50, child: Icon(Icons.delete)),
            ),
          )
        ],
      ),
    );
  }

  agregarFalencia() async {
    if (falenciaId > 0) {
      final falenciaReporteDestinoEcommerce = FalenciaReporteDestinoEcommerce();
      falenciaReporteDestinoEcommerce.falenciaRamosId = falenciaId;
      falenciaReporteDestinoEcommerce.falenciaRamosNombre = falenciaNombre;
      falenciaReporteDestinoEcommerce.falenciasControlDestinoEcommerceCantidad =
          1;
      if (this.destinoEcommerceId == 0) {
        final destinoEcommerceAdd = new DestinoEcommerceDto();
        this.destinoEcommerceId =
            await DatabaseControlDestinoEcommerce.addDestinoEcommerce(
                this.controlDestinoEcommerceId, destinoEcommerceAdd);
      }
      falenciaReporteDestinoEcommerce.destinoEcommerceId =
          this.destinoEcommerceId;
      await DatabaseControlDestinoEcommerce.addFalenciaReporteDestinoEcommerce(
          falenciaReporteDestinoEcommerce);
    } else {}
    await cargarLista(this.destinoEcommerceId);
  }

  cargarLista(int destinoEcommerceId) async {
    List<FalenciaReporteDestinoEcommerce> falencias = List();
    falencias = await DatabaseControlDestinoEcommerce
        .getAllFalenciasByDestinoEcommerceId(destinoEcommerceId);
    widget.actualizarLista('');
    setState(() {
      listaFalenciasReporte = falencias;
    });
  }
}
