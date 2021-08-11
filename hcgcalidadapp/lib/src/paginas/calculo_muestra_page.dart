import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/modelos/calculo_muestra.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class calculoMuestraPage extends StatefulWidget {
  calculoMuestraPage() {}

  @override
  _calculoMuestraPageState createState() =>
      _calculoMuestraPageState();
}

class _calculoMuestraPageState extends State<calculoMuestraPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final totalRamos = TextEditingController();
  final margenDeError = TextEditingController();
  final nivelDeConfianza = TextEditingController();
  String resultadoText = "";
  String textoResultado = "Cantidad de muestreo: ";
  _calculoMuestraPageState() {}

  _guardarReporteRamos() {
    CalculoMuestra calculoMuestra = new CalculoMuestra();
    calculoMuestra.NivelDeConfianza = 0;
    calculoMuestra.RamosTotales = 0;
    calculoMuestra.MargenDeError = 0;
    try{
      calculoMuestra.NivelDeConfianza = double.parse(nivelDeConfianza.text);
      calculoMuestra.RamosTotales = int.parse(totalRamos.text);
      calculoMuestra.MargenDeError = double.parse(margenDeError.text);
      setState(() {
        resultadoText = this.textoResultado + calculoMuestra.calcularMuestra();
      });
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    String value2 = "";
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('CALCULO DE MUESTRA'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _cantidadRamosTotales(),
                    _NivelDeConfianza(),
                    _margenDeError(),
                    Divider(),
                    Text(resultadoText,
                      style: Theme.of(context).textTheme.subtitle1),
                      Divider(),
                    _botonSiguiente(context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Divider(),
                Column(
                  children: [
                    Text(
                      "RESULTADO DE MUESTRA",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _NivelDeConfianza() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        maxLengthEnforced: true,
        maxLength: 2,
        decoration: InputDecoration(
          hintText: 'Nivel de confianza en %',
          labelText: 'Nivel de confianza en %',
        ),
        controller: nivelDeConfianza,
      ),
    );
  }

  Widget _margenDeError() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        maxLengthEnforced: true,
        maxLength: 2,
        decoration: InputDecoration(
          hintText: 'Margen de Error en %',
          labelText: 'Margen de Error en %',
        ),
        controller: margenDeError,
      ),
    );
  }

  Widget _cantidadRamosTotales() {
    return Container(
      width: 200,
      height: 90,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Ramos Totales',
          labelText: 'RamosTotales',
        ),
        controller: totalRamos,
      ),
    );
  }

  Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          if (_validarRamos()) {
            final util = Utilidades();
            if (util.isNumberEntero(totalRamos.text) && util.isNumberEntero(nivelDeConfianza.text) && util.isNumberEntero(margenDeError.text)) {
              _guardarReporteRamos();
            } else {
              mostrarSnackbar('Ingrese solo valores numericos', null, scaffoldKey);
            }
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.red,
        textColor: Colors.white,
        child: Container(
          height: 60,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('Calcular'), Icon(Icons.exposure)],
          ),
        ),
      ),
    );
  }

  bool _validarRamos() {
    if (nivelDeConfianza.text == '' ||
        totalRamos.text == '' ||
        margenDeError.text == '') {
      mostrarSnackbar('Ingrese los valores', null, scaffoldKey);
      return false;
    }
    return true;
  }
}
