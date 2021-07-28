import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/cantidad.dart';

class SincronizarPage extends StatefulWidget {
  @override
  _SincronizarPageState createState() => _SincronizarPageState();
}

class _SincronizarPageState extends State<SincronizarPage> {
  Cantidad cantidad = Cantidad();
  int total = 0;
  bool sincronizando = false;
  @override
  void initState() {
    cargarReportes();
    super.initState();
  }

  cargarReportes() async {
    cantidad = await DatabaseReportesAprobacion.getAllReportesCantidad();
    total = cantidad.ecuador +
        cantidad.actividades +
        cantidad.temperaturas +
        cantidad.procesoHid +
        cantidad.procesoEmp +
        cantidad.ramos +
        cantidad.empaque +
        cantidad.banda;
    setState(() {});
  }

  sincronizar() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        sincronizando = true;
        setState(() {});
        await DatabaseReportesAprobacion.getAllReportesSinc();
        await cargarReportes();
        setState(() {
          sincronizando = false;
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext cont) => AlertDialog(
                  title: Text("Error de internet"),
                  content: Text("Su conexión de internet presenta fallas"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Aceptar"))
                  ],
                ));
      }
    } on SocketException catch (_) {
      showDialog(
          context: context,
          builder: (BuildContext cont) => AlertDialog(
                title: Text("Error de internet"),
                content: Text("Su conexión de internet presenta fallas"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Aceptar"))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SINCRONIZAR'),
        actions: [
          RaisedButton(
            onPressed: () async {
              try {
                String valor = await DatabaseReportesAprobacion.jsonRamos();
                Clipboard.setData(new ClipboardData(text: valor));
              } catch (e) {
                Clipboard.setData(new ClipboardData(text: e.toString()));
              }
            },
            child: Text("Copiar"),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Actividades: " + cantidad.actividades.toString()),
                Text("Proceso Empaque: " + cantidad.procesoEmp.toString()),
                Text("Proceso Hidratacion: " + cantidad.procesoHid.toString()),
                Text("Temperaturas: " + cantidad.temperaturas.toString()),
                Text("Control Ramos: " + cantidad.ramos.toString()),
                Text("Control Empaque: " + cantidad.empaque.toString()),
                Text("Control Banda: " + cantidad.banda.toString()),
                Text("Control Ecuador: " + cantidad.ecuador.toString()),
              ],
            )),
            Container(
              child: Text(
                "Total: " + total.toString(),
                style: TextStyle(fontSize: 50),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            sincronizando
                ? Container(
                    width: 200,
                    child: LinearProgressIndicator(),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            sincronizando
                ? Container()
                : RaisedButton(
                    onPressed: () async {
                      await sincronizar();
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text(
                        "SINCRONIZAR",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
