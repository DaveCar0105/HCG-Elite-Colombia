import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';

// ignore: must_be_immutable
class OrdenesLista extends StatefulWidget {
  int clienteId;
  OrdenesLista(this.clienteId);
  @override
  _OrdenesListaState createState() => _OrdenesListaState(this.clienteId);
}

class _OrdenesListaState extends State<OrdenesLista> {
  int clienteId;
  List<OrdenEmpaque> listaEmpaque = List();
  List<OrdenRamo> listaRamo = List();
  _OrdenesListaState(this.clienteId){
    cargarOrdenes();
  }

  cargarOrdenes() async{
    listaEmpaque = await DatabaseReportesAprobacion.getAllOrdenes(this.clienteId);
    listaRamo =await DatabaseReportesAprobacion.getAllOrdenesRamos(this.clienteId);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height -160;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordenes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 30,
            color: Colors.red,
            child: Text('Control ramos',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
          ),
          Container(
            height: h/2,
            child: ListView.builder(
              itemCount: listaRamo.length,
              itemBuilder: (context,index){
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
                  child:ListTile(
                    title: Text('# Orden: '+listaRamo[index].numeroOrden +
                        '\n Postcosecha: ' +listaRamo[index].postCosechaNombre +
                        '\n Producto: ' +listaRamo[index].productoNombre +
                        '\n Marca: ' +listaRamo[index].marca
                    ),
                    subtitle: Text('% No conformidad: '+ listaRamo[index].ramoInconformidad.toStringAsFixed(2) + '%' +
                    '\n Ramos revisados: '+ listaRamo[index].ramosRevisados.toString()),

                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 30,
            color: Colors.red,
            child: Text('Control empaque',style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
          ),
          Container(
            height: h/2,
            child: ListView.builder(
              itemCount: listaEmpaque.length,
              itemBuilder: (context,index){
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
                    title: Text('# Orden: '+listaEmpaque[index].numeroOrden +
                        '\n Postcosecha: ' +listaEmpaque[index].postCosechaNombre +
                        '\n Producto: ' +listaEmpaque[index].productoNombre +
                        '\n Marca: ' +listaEmpaque[index].marca
                    ),
                    subtitle: Text('Inconformidad Cajas: '+ listaEmpaque[index].empaqueInconformidadCajas.toStringAsFixed(2) + '%'
                        '\nInconformidad Ramos: '+ listaEmpaque[index].empaqueInconformidadRamos.toStringAsFixed(2) + '%' +
                        '\nCajas revisadas: ' + listaEmpaque[index].cajasRevisadas.toString() +
                        '\nRamos revisados: ' + listaEmpaque[index].ramosRevisados.toString()
                    ),

                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
