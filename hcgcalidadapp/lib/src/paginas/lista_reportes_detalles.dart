
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/historial.dart';


class ListaReporteDetalle extends StatefulWidget {
  @override
  _ListaReporteDetalleState createState() => _ListaReporteDetalleState();
}

class _ListaReporteDetalleState extends State<ListaReporteDetalle> {
  List<Historial> lista = List();
  @override
  void initState() {
    cargarLista();
    super.initState();
  }
  cargarLista() async {
    lista = await DatabaseReportesAprobacion.historialReportes();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista historial reportes"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context,int index)=>
          ListTile(
            title: Text(
                  'Tipo:'+lista[index].tipo.toString() + '\n' +
                  'Id:'+lista[index].controlRamosId.toString() + ' ' +
                  'No:'+lista[index].ramosNumeroOrden.toString() +' ' +
                  'Rt:'+lista[index].ramosTotal.toString() +' ' +
                  'Rf:'+lista[index].ramosFecha.toString() +' ' +
                  'E:'+lista[index].estado.toString() +'\n' +
                  'Df:'+lista[index].detalleFirmaId.toString() +' ' +
                  'Ci:'+lista[index].clienteId.toString() +' ' +
                  'Cn:'+lista[index].clienteNombre.toString() +' ' +
                  'Pi:'+lista[index].productoId.toString() +' ' +
                  'Pn:'+lista[index].productoNombre.toString() +'\n' +
                  'Tl:'+lista[index].ramosTallos.toString() +'' +
                  'Rd:'+lista[index].ramosDespachar.toString() +' ' +
                  'Re:'+lista[index].ramosElaborados.toString() +' ' +
                  'Rg:'+lista[index].ramosDerogado.toString() +' ' +
                  'Pci:'+lista[index].postcosechaId.toString() +'\n' +
                  'Pcn:'+lista[index].postcosechaNombre.toString() +' ' +
                  'Rm:'+lista[index].ramosMarca.toString() +' ' +
                  'Cr:'+lista[index].cajasRevisar.toString()
              ,
              style: TextStyle(
                color: Colors.black
              ),
            ),

          )
          ,
        ),
      ),
    );
  }
}
