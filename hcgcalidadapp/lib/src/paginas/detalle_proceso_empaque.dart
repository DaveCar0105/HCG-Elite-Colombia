import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/procesoEmpaque.dart';

class DetalleRegistroProcesoEmpaquePage extends StatelessWidget {
  const DetalleRegistroProcesoEmpaquePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
      future: DatabaseProcesoEmpaque.getAllProcesosEmpaque(),
        builder: (context, AsyncSnapshot<List<ProcesoEmpaques>> snapshot){
          if(snapshot.hasData){
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i){
                return ListTile(
                  title: Text('Altura de pallets: ${_respuesta(data[i].procesoEmpaqueAltura)}\n'
                  'Cajas Buenas Condiciones: ${_respuesta(data[i].procesoEmpaqueCajas)}\n'
                  'Sujección Correcta: ${_respuesta(data[i].procesoEmpaqueSujeccion)}\n'
                  'Movimientos y traslados correctos: ${_respuesta(data[i].procesoEmpaqueMovimientos)}\n'
                  'Temperatura cuarto frío: ${_respuesta(data[i].procesoEmpaqueTemperaturaCuartoFrio)}\n'
                  'Temperatura de cajas: ${_respuesta(data[i].procesoEmpaqueTemperaturaCajas)}\n'
                  'Temperatura de camión: ${_respuesta(data[i].procesoEmpaqueTemperaturaCamion)}\n'
                  'Apilamiento Adecuado: ${_respuesta(data[i].procesoEmpaqueApilamiento)}\n'),
                  subtitle: Text('Fecha: ${data[i].procesoEmpaqueFecha.toString().substring(0,19)}'),              
                  leading: Text((i+1).toString()),
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