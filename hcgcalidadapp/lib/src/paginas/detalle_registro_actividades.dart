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
                  title: Text('Descripción: ${data[i].actividadDetalle}\nHora inicio: ${data[i].actividadHoraInicio}\nHora finalización: ${data[i].actividadHoraFin}\n'),
                  subtitle: Text('Fecha: ${data[i].actividadFecha.toString().substring(0,19)}'),
                  leading: Text((i+1).toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                )
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