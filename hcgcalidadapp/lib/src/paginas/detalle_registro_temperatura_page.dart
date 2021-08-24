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
                  title: Text(
                      'Temperatura cuarto frío: ${data[i].temperaturaExterna}, \n'
                      'Identificador de cliente: ${data[i].clienteId}, \n'
                      'Temperatura caja #1: ${data[i].temperaturaInterna1},\n'
                      'Temperatura caja #2: ${data[i].temperaturaInterna2},\n' 
                      'Temperatura caja #3: ${data[i].temperaturaInterna3}\n'),
                  subtitle: Text(
                      'Fecha: ${data[i].temperaturaFecha.toString().substring(0, 19)}'),
                  leading: Text((i + 1).toString(),style: TextStyle(fontWeight: FontWeight.bold)),
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
