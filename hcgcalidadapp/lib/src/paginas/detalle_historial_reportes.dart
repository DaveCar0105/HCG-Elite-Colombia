import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';

class DetalleHistorialReportesCirculoCalidadPage extends StatelessWidget {
  const DetalleHistorialReportesCirculoCalidadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REPORTE'),
      ),
      body: FutureBuilder(
        future: DatabaseProcesoHidratacion.getAllProcesosHidratacion(),
        builder: (context, AsyncSnapshot<List<ProcesoHidratacion>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                        'Estado Solución: ${_respuesta(data[i].procesoHidratacionEstadoSoluciones)}\n'
                        'Tiempos de Hidratación: ${_respuesta(data[i].procesoHidratacionTiemposHidratacion)}\n'
                        'Cantidad Ramos Tinas: ${_respuesta(data[i].procesoHidratacionCantidadRamos)}\n'
                        'Ph Solución: ${data[i].procesoHidratacionPhSolucion}\n'
                        'Nivel Solución: ${data[i].procesoHidratacionNivelSolucion}\n'),
                    subtitle: Text(
                        'Fecha: ${data[i].procesoHidratacionFecha.toString().substring(0, 19)}'),
                    leading: Text((i + 1).toString()),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }

  String _respuesta(int valor) {
    return valor == 0 ? 'Cumple' : 'No Cumple';
  }
}
