import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/cantidad.dart';
import 'package:hcgcalidadapp/src/utilidades/alertMesssageDialog.dart';

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
        cantidad.banda +
        cantidad.procesoMaritimos +
        cantidad.circuloCalidad;
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
        alertDialogInternet(context);
      }
    } on SocketException catch (_) {
      alertDialogInternet(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
                Text("FORMULARIOS DE CONTROL",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Control Ramos: " + cantidad.ramos.toString()),
                Text("Control Empaque: " + cantidad.empaque.toString()),
                Text("Control Banda: " + cantidad.banda.toString()),
                Text("Control Ecuador: " + cantidad.ecuador.toString()),
                Text("PROCESOS DE CONTROL",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Proceso Hidratación: " + cantidad.procesoHid.toString()),
                Text("Proceso Empaque: " + cantidad.procesoEmp.toString()),
                Text("Proceso Marítimos: " + cantidad.procesoMaritimos.toString()),
                Text("PROCESOS DE REGISTROS",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Temperaturas: " + cantidad.temperaturas.toString()),
                Text("Actividades: " + cantidad.actividades.toString()),
                Text("PROCESOS DE CALIDAD",style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Círculo de Calidad: " + cantidad.circuloCalidad.toString()),
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
