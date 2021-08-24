import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';

class DetalleRegistroProcesoHidratacionPage extends StatelessWidget {
  const DetalleRegistroProcesoHidratacionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
      future: DatabaseProcesoHidratacion.getAllProcesosHidratacion(),
        builder: (context, AsyncSnapshot<List<ProcesoHidratacion>> snapshot){
          if(snapshot.hasData){
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i){
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
                    title: Text('Estado solución: ${_respuesta(data[i].procesoHidratacionEstadoSoluciones)}\n'
                    'Tiempos de hidratación: ${_respuesta(data[i].procesoHidratacionTiemposHidratacion)}\n'
                    'Cantidad ramos tinas: ${_respuesta(data[i].procesoHidratacionCantidadRamos)}\n'
                    'Ph solución: ${data[i].procesoHidratacionPhSolucion}\n'
                    'Nivel solución: ${data[i].procesoHidratacionNivelSolucion}\n'),
                    subtitle: Text('Fecha: ${data[i].procesoHidratacionFecha.toString().substring(0,19)}'),              
                    leading: Text((i+1).toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                );
              }
            );
          }
          return Container();
        },
      ),
    );
  }

  String _respuesta(int valor){
    return valor == 0 ? 'Cumple' : 'No Cumple';
  }
}