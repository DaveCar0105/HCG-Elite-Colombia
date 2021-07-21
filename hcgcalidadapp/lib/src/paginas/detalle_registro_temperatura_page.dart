import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_temperatura.dart';
import 'package:hcgcalidadapp/src/modelos/temperatura.dart';

class DetalleRegistroTemperaturaPage extends StatefulWidget {
  DetalleRegistroTemperaturaPage({Key key}) : super(key: key);

  @override
  _DetalleRegistroTemperaturaState createState() =>
      _DetalleRegistroTemperaturaState();
}

class _DetalleRegistroTemperaturaState
    extends State<DetalleRegistroTemperaturaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(),
      body: FutureBuilder(
        future: DatabaseTemperatura.getAllTemperaturas(),
        builder: (context, AsyncSnapshot<List<Temperatura>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                        'Temperatura Cuarto Frío: ${data[i].temperaturaExterna}, \n ClienteID: ${data[i].clienteId}, \nTemperatura Caja#1: ${data[i].temperaturaInterna1},\n Temperatura Caja#2: ${data[i].temperaturaInterna2},\n Temperatura Caja#3: ${data[i].temperaturaInterna3}'),
                    subtitle: Text(
                        'Fecha: ${data[i].temperaturaFecha.toString().substring(0, 19)}'),
                    leading: Text((i + 1).toString()),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
