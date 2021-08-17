import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/modelos/calculo_muestra.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:hcgcalidadapp/src/utilidades/utilidades.dart';

// ignore: must_be_immutable
class CalculoMuestraPage extends StatefulWidget {
  calculoMuestraPage() {}

  @override
  _CalculoMuestraPageState createState() =>
      _CalculoMuestraPageState();
}

class _CalculoMuestraPageState extends State<CalculoMuestraPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formCalculoMuestraKey = GlobalKey<FormState>();
  final totalRamos = TextEditingController();
  final margenDeError = TextEditingController();
  final nivelDeConfianza = TextEditingController();
  String resultadoText = "";
  String textoResultado = "Cantidad de muestreo: ";
  _CalculoMuestraPageState() {}

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
          padding: const EdgeInsets.all(26.0),
          width: double.infinity,
          child: 
          Form(
            key: _formCalculoMuestraKey,
            child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _cantidadRamosTotales(),
                    _nivelDeConfianza(),
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
                )
              ],
            ),
          )
          ),
          ),
    );
  }

  Widget _nivelDeConfianza() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLengthEnforced: true,
        maxLength: 2,
        decoration: InputDecoration(
          hintText: 'Nivel de confianza en %',
          labelText: 'Nivel de confianza en %',
        ),
        controller: nivelDeConfianza,
        validator: (value) {
          if (value.isEmpty) {
            return "Llene este campo";
          }
        },
      ),
    );
  }

  Widget _margenDeError() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLengthEnforced: true,
        maxLength: 2,
        decoration: InputDecoration(
          hintText: 'Margen de Error en %',
          labelText: 'Margen de Error en %',
        ),
        controller: margenDeError,
        validator: (value) {
          if (value.isEmpty) {
            return "Llene este campo";
          }
        },
      ),
    );
  }

  Widget _cantidadRamosTotales() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLengthEnforced: true,
        maxLength: 9,
        decoration: InputDecoration(
          hintText: 'Ramos Totales',
          labelText: 'ramos totales',
        ),
        controller: totalRamos,
        validator: (value) {
          if (value.isEmpty) {
            return "Llene este campo";
          }
        },
      ),
    );
  }

  Widget _botonSiguiente(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () async {
          if (_formCalculoMuestraKey.currentState.validate()) {
            final util = Utilidades();
            if (util.isNumberEntero(totalRamos.text) && util.isNumberEntero(nivelDeConfianza.text) && util.isNumberEntero(margenDeError.text)) {
              _guardarReporteRamos();
            } else {
              mostrarSnackbar('Ingrese solo valores numericos', null, scaffoldKey);
            }
          } else {
            mostrarSnackbar('Llene el formulario', Colors.redAccent, scaffoldKey);
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.red,
        textColor: Colors.white,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text('CALCULAR '), Icon(Icons.exposure)],
          ),
        ),
      ),
    );
  }
}
