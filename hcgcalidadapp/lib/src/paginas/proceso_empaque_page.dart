import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/procesoEmpaque.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class ProcesoEmpaquePage extends StatefulWidget {
  @override
  _ProcesoEmpaquePageState createState() => _ProcesoEmpaquePageState();
}

class _ProcesoEmpaquePageState extends State<ProcesoEmpaquePage> {
  int alturasGroupValue = -1;
  int cajasGroupValue = -1;
  int sujecionGroupValue = -1;
  int movimientosGroupValue = -1;
  int temperaturaCuartoFrioGroupValue = -1;
  int temperaturaCajasGroupValue = -1;
  int temperaturaCamionGroupValue = -1;
  int apilamientoGroupValue = -1;
  final phSolucionController = new TextEditingController();
  final nivelSolucionController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";
  int postcosechaId=0;
  bool postcosechaEnable = false;
  @override
  void initState() {
    cargarCombo();
    super.initState();
  }
  cargarCombo() async {
    List<PostCosecha> postcosechas = List();
    listaPostcosecha = List<AutoComplete>();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(1);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(id:element.postCosechaId,nombre: element.postCosechaNombre));
    });
    setState(() {
      postcosechaEnable = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Proceso Empaque Check'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: (){
                Navigator.pushNamed(context, 'detalleEmpaque');
              },
            ),
          ]
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                _postcosecha(),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: screenSize.width*0.5,
                    ),
                    Expanded(child: Text(
                      'Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    Expanded(child: 
                    Text(
                      'No Cumple:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.025,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Alturas de pallets adecuado (max 220 cm)'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: alturasGroupValue,
                        onChanged: (value){
                          setState(() {
                            alturasGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: alturasGroupValue,
                        onChanged: (value){
                          setState(() {
                            alturasGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Cajas buenas condiciones (no cajas balón, razgamiento, humedas)'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: cajasGroupValue,
                        onChanged: (value){
                          setState(() {
                            cajasGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: cajasGroupValue,
                        onChanged: (value){
                          setState(() {
                            cajasGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Sujeción correcta (no por perforaciones, ni zuncho)'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: sujecionGroupValue,
                        onChanged: (value){
                          setState(() {
                            sujecionGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: sujecionGroupValue,
                        onChanged: (value){
                          setState(() {
                            sujecionGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Movimientos y traslados correctos (no lanzamiento)'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: movimientosGroupValue,
                        onChanged: (value){
                          setState(() {
                            movimientosGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: movimientosGroupValue,
                        onChanged: (value){
                          setState(() {
                            movimientosGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Temperatura cuarto frío adecuada'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: temperaturaCuartoFrioGroupValue,
                        onChanged: (value){
                          setState(() {
                            temperaturaCuartoFrioGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: temperaturaCuartoFrioGroupValue,
                        onChanged: (value){
                          setState(() {
                            temperaturaCuartoFrioGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Temperatura de cajas empacadas adecuada (3˚C)'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: temperaturaCajasGroupValue,
                        onChanged: (value){
                          setState(() {
                            temperaturaCajasGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: temperaturaCajasGroupValue,
                        onChanged: (value){
                          setState(() {
                            temperaturaCajasGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Temperatura de camión adecuada ( máximo 6°C)'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: temperaturaCamionGroupValue,
                        onChanged: (value){
                          setState(() {
                            temperaturaCamionGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: temperaturaCamionGroupValue,
                        onChanged: (value){
                          setState(() {
                            temperaturaCamionGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.5,
                      child: Text('Apilamiento de cajas adecuada'),
                    ),
                    Radio(
                        value: 0,
                        groupValue: apilamientoGroupValue,
                        onChanged: (value){
                          setState(() {
                            apilamientoGroupValue = value;
                          });
                        }
                    ),
                    Spacer(),
                    Radio(
                        value: 1,
                        groupValue: apilamientoGroupValue,
                        onChanged: (value){
                          setState(() {
                            apilamientoGroupValue = value;
                          });
                        }
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton.icon(
                        onPressed: _validarFormulario,
                        color: Colors.red,
                        textColor: Colors.white,
                        icon: Icon(Icons.save),
                        label: Text('Guardar'),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        )
      ),
    );
  }
  Widget _postcosecha() {
    return Container(
      child: postcosechaEnable?ListaBusqueda(
        key: _keyPostcosecha,
        lista: listaPostcosecha,
        hintText: "Post Cosecha",
        valorDefecto: postcosechaNombre,
        hintSearchText: "Escriba el nombre de Postcosecha",
        icon: Icon(Icons.move_to_inbox),
        width: MediaQuery.of(context).size.width * 0.75,
        parentAction: (value){
          if(value!= null && value!=""){
            AutoComplete postcosecha = listaPostcosecha.firstWhere((item){
              return item.nombre.compareTo(value) == 0;
            });
            postcosechaId = postcosecha.id;
          }
        },
      ):Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
  _validarFormulario() async{
    if(alturasGroupValue >= 0 && cajasGroupValue >= 0 && sujecionGroupValue >= 0 && movimientosGroupValue >= 0
        && temperaturaCajasGroupValue >= 0 && temperaturaCuartoFrioGroupValue >= 0 && temperaturaCamionGroupValue >= 0
        && apilamientoGroupValue >= 0 && postcosechaId != 0
    ){
      ProcesoEmpaques procesoEmpaque = new ProcesoEmpaques(
          procesoEmpaqueUsuarioControlId: 1,
          procesoEmpaqueAltura: alturasGroupValue,
          procesoEmpaqueCajas: cajasGroupValue,
          procesoEmpaqueSujeccion: sujecionGroupValue,
          procesoEmpaqueMovimientos: movimientosGroupValue,
          procesoEmpaqueTemperaturaCuartoFrio: temperaturaCuartoFrioGroupValue,
          procesoEmpaqueTemperaturaCajas: temperaturaCajasGroupValue,
          procesoEmpaqueTemperaturaCamion: temperaturaCamionGroupValue,
          procesoEmpaqueApilamiento: apilamientoGroupValue,
          procesoEmpaqueFecha: DateTime.now(),
          postcosechaId:postcosechaId
      );
      int procesoEmpaqueId = await DatabaseProcesoEmpaque.addProcesosEmpaque(procesoEmpaque);
      if(procesoEmpaqueId != 0){
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _limpiarFormulario();
      }else{
        mostrarSnackbar('No se pudo ingresar a la base de datos', Colors.red, _scaffoldKey);
      }
    }else{
      mostrarSnackbar('No se han llenado todos los campos', Colors.red, _scaffoldKey);
    }
  }

  _limpiarFormulario(){
    alturasGroupValue = -1;
    cajasGroupValue = -1;
    sujecionGroupValue = -1;
    movimientosGroupValue = -1;
    temperaturaCuartoFrioGroupValue = -1;
    temperaturaCajasGroupValue = -1;
    temperaturaCamionGroupValue = -1;
    apilamientoGroupValue = -1;
    setState(() {});
  }
}