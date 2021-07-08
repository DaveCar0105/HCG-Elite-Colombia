import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_reportes_aprobacion.dart';
import 'package:hcgcalidadapp/src/modelos/historial.dart';

class ReporteGeneralPage extends StatefulWidget {
  @override
  _ReporteGeneralPageState createState() => _ReporteGeneralPageState();
}

class _ReporteGeneralPageState extends State<ReporteGeneralPage> {
  List<Historial> lista = List();
  @override
  void initState() {
    cargarLista();
    super.initState();
  }

  cargarLista() async {
    lista = await DatabaseReportesAprobacion.historialReportes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REPORTE GENERAL"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellowAccent,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 7)]),
        child: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(
              'Tipo: ' +
                  lista[index].tipo.toString() +
                  '          ' +
                  'ID:' +
                  lista[index].controlRamosId.toString() +
                  '\n' +
                  'N# Orden:' +
                  lista[index].ramosNumeroOrden.toString() +
                  ' \n' +
                  'Rt: ' +
                  lista[index].ramosTotal.toString() +
                  '        ' +
                  'Rf: ' +
                  lista[index].ramosFecha.toString() +
                  '         ' +
                  'E: ' +
                  lista[index].estado.toString() +
                  '      ' +
                  'Df: ' +
                  lista[index].detalleFirmaId.toString() +
                  ' \n' +
                  'Ci: ' +
                  lista[index].clienteId.toString() +
                  '     ' +
                  'Cn: ' +
                  lista[index].clienteNombre.toString() +
                  '    ' +
                  'Pi: ' +
                  lista[index].productoId.toString() +
                  '     ' +
                  'Pn: ' +
                  lista[index].productoNombre.toString() +
                  '\n' +
                  'Tl: ' +
                  lista[index].ramosTallos.toString() +
                  '     ' +
                  'Rd: ' +
                  lista[index].ramosDespachar.toString() +
                  '     ' +
                  'Re: ' +
                  lista[index].ramosElaborados.toString() +
                  '     ' +
                  'Rg: ' +
                  lista[index].ramosDerogado.toString() +
                  '\n' +
                  'Pci: ' +
                  lista[index].postcosechaId.toString() +
                  '     ' +
                  'Pcn: ' +
                  lista[index].postcosechaNombre.toString() +
                  '     ' +
                  'Rm:' +
                  lista[index].ramosMarca.toString() +
                  ' \n' +
                  'Cr: ' +
                  lista[index].cajasRevisar.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
/*child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellowAccent,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                item['clienteNombre'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ramos > 0
                ? Text(
                    'Resumen control Banda',
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  )
                : Container(),
            ramos > 0
                ? itemTexto('Promedio % No conformidad: ',
                    report.inconformidadP.toStringAsFixed(2), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalRamosRamos.toString(), w - 20)
                : Container(),
            ramos > 0
                ? itemTexto(
                    'Problema principal: ', report.falenciaPrincipal, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto(
                    'Problema secundario: ', report.falenciaSegundaria, w - 20)
                : Container(),
            ramos > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalRamosRevisados.toString(), w - 20)
                : Container(),
            empaque > 0
                ? Text(
                    'Resumen control Empaque',
                    style: TextStyle(fontSize: 21, color: Colors.blue),
                  )
                : Container(),
            empaque > 0
                ? itemTexto(
                    'Promedio % No conformes Cajas: ',
                    report.inconformidadEmpaqueCajasP.toStringAsFixed(2),
                    w - 20)
                : Container(),
            empaque > 0
                ? itemTexto(
                    'Promedio % No conformes Ramos: ',
                    report.inconformidadEmpaqueRamosP.toStringAsFixed(2),
                    w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cantidad Cajas No conformes: ',
                    report.totalEmpaqueCajas.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cantidad Ramos No conformes: ',
                    report.totalEmpaqueRamos.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Problema principal: ',
                    report.falenciaPrincipalEmpaque.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Problema secundario: ',
                    report.falenciaSegundariaEmpaque.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Ramos revisados: ',
                    report.totalEmpaqueRamosRevisados.toString(), w - 20)
                : Container(),
            empaque > 0
                ? itemTexto('Cajas revisadas: ',
                    report.totalEmpaqueCajasRevisadas.toString(), w - 20)
                : Container(),
          ],
        ),
      ), */