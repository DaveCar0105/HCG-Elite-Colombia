import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_actividad.dart';
import 'package:hcgcalidadapp/src/modelos/actividad.dart';

class DetalleRegistroActividadesPage extends StatelessWidget {
  const DetalleRegistroActividadesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
      future: DatabaseActividad.getAllActividad(),
        builder: (context, AsyncSnapshot<List<Actividad>> snapshot){
          if(snapshot.hasData){
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i){
                return ListTile(
                  title: Text('Descripción: ${data[i].actividadDetalle}\nHora Inicio: ${data[i].actividadHoraInicio}\nHora Fin: ${data[i].actividadHoraFin}'),
                  subtitle: Text('Fecha: ${data[i].actividadFecha.toString().substring(0,19)}'),
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
}