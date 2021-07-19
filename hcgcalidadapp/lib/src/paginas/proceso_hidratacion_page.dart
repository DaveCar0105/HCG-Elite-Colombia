import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/bloc/registro_proceso_hidratacion_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class ProcesoHidratacionPage extends StatefulWidget {

  @override
  _ProcesoHidratacionPageState createState() => _ProcesoHidratacionPageState();
}

class _ProcesoHidratacionPageState extends State<ProcesoHidratacionPage> {

  int estadoSolucionesGroupValue = -1;
  int tiemposDeHidratacionGroupValue = -1;
  int cantidadRamosTinasGroupValue = -1;

  final phSolucionController = new TextEditingController();
  final nivelSolucionController = new TextEditingController();

  final appBar = AppBar();
  final _procesoHidratacionBloc = new RegistroProcesoHidratacionBloc();
  @override
  void initState() {
    cargarCombo();
    super.initState();
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";

  int postcosechaId=0;
  bool postcosechaEnable = false;

  cargarCombo()async{
    List<PostCosecha> postcosechas = List();
    postcosechas = await DatabasePostcosecha.getAllPostcosecha(1);
    postcosechas.forEach((element) {
      listaPostcosecha.add(AutoComplete(id:element.postCosechaId,nombre: element.postCosechaNombre));
    });
    setState(() {
      postcosechaEnable = true;
    });
  }
  Widget  _postcosecha() {
    return Container(
      width: 250,
      height: 80,
      child: postcosechaEnable?ListaBusqueda(
        key: _keyPostcosecha,
        lista: listaPostcosecha,
        hintText: "Post Cosecha",
        valorDefecto: postcosechaNombre,
        hintSearchText: "Escriba el nombre de Postcosecha",
        icon: Icon(Icons.move_to_inbox),
        width: 200.0,
        style: TextStyle(
          fontSize: 15,
        ),
        parentAction: (value){
          AutoComplete postcosecha= listaPostcosecha.firstWhere((item){
            return item.nombre == value;
          });
          postcosechaId = postcosecha.id;
        },
      ):Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Proceso Hidratación Check'),
        actions: <Widget>[
          StreamBuilder(
            stream: _procesoHidratacionBloc.registroProcesoHidratacionStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              if(snapshot.hasData){
                final data = snapshot.data;
                return data == 0 ? Container() : Bounce(                  
                  controller: (controller) => _procesoHidratacionBloc.bounceController = controller,
                  from: 20,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, 'detalleHidratacion');
                    },
                    child: Container(
                      width: width * 0.1,
                      child: Stack(                    
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.brightness_1, 
                              color: Colors.white
                            )
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                color: Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.01,
            horizontal: width * 0.05
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.05,
              ),
              _postcosecha(),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: width*0.5,
                  ),
                  Text(
                    'Cumple:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.023
                    ),
                  ),
                  Spacer(),
                  Text(
                    'No Cumple:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.023
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text('Estado de Soluciones'),
                  ),
                  Radio(
                    value: 0, 
                    groupValue: estadoSolucionesGroupValue, 
                    onChanged: (value){
                      setState(() {
                        estadoSolucionesGroupValue = value;
                      });
                    }
                  ),
                  Spacer(),
                  Radio(
                    value: 1, 
                    groupValue: estadoSolucionesGroupValue, 
                    onChanged: (value){
                      setState(() {
                        estadoSolucionesGroupValue = value;
                      });
                    }
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text('Tiempos de Hidratación'),
                  ),
                  Radio(
                    value: 0, 
                    groupValue: tiemposDeHidratacionGroupValue, 
                    onChanged: (value){
                      setState(() {
                        tiemposDeHidratacionGroupValue = value;
                      });
                    }
                  ),
                  Spacer(),
                  Radio(
                    value: 1, 
                    groupValue: tiemposDeHidratacionGroupValue, 
                    onChanged: (value){
                      setState(() {
                        tiemposDeHidratacionGroupValue = value;
                      });
                    }
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text('Cantidad Ramos Tinas'),
                  ),
                  Radio(
                    value: 0, 
                    groupValue: cantidadRamosTinasGroupValue, 
                    onChanged: (value){
                      setState(() {
                        cantidadRamosTinasGroupValue = value;
                      });
                    }
                  ),
                  Spacer(),
                  Radio(
                    value: 1, 
                    groupValue: cantidadRamosTinasGroupValue, 
                    onChanged: (value){
                      setState(() {
                        cantidadRamosTinasGroupValue = value;
                      });
                    }
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text('Ph Solución'),
                  ),
                  Expanded(
                    child: TextField(
                      controller: phSolucionController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )
                  )
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.5,
                    child: Text('Nivel Solución'),
                  ),
                  Expanded(
                    child: TextField(
                      controller: nivelSolucionController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )
                  )
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton.icon(
                      onPressed: _validarForm,
                      color: Colors.red,
                      textColor: Colors.white,
                      icon: Icon(Icons.save),
                      label: Text('Guardar'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validarForm() async{
    if( estadoSolucionesGroupValue  >= 0  && 
    tiemposDeHidratacionGroupValue  >= 0  && 
    cantidadRamosTinasGroupValue    >= 0  &&
    phSolucionController.text       != '' &&
    nivelSolucionController.text    != '' &&
    postcosechaId != 0){
      ProcesoHidratacion procesoHidratacion = new ProcesoHidratacion(
        procesoHidratacionUsuarioControlId: 1,
        procesoHidratacionEstadoSoluciones: estadoSolucionesGroupValue,
        procesoHidratacionTiemposHidratacion: tiemposDeHidratacionGroupValue,
        procesoHidratacionCantidadRamos: cantidadRamosTinasGroupValue,
        procesoHidratacionPhSolucion: double.parse(phSolucionController.text),
        procesoHidratacionNivelSolucion: double.parse(nivelSolucionController.text),
        procesoHidratacionFecha: DateTime.now(),
        postcosechaId: postcosechaId

      );
      int procesoHidratacionId = await DatabaseProcesoHidratacion.addProcesosHidratacion(procesoHidratacion);
      if(procesoHidratacionId != 0){
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _limpiarForm();
        _procesoHidratacionBloc.registroProcesoHidratacionStream();
        _procesoHidratacionBloc.itemAgregado();
      }else{
      mostrarSnackbar('No se pudo ingresar en la base de datos', Colors.red, _scaffoldKey);
      }
    }else{
      mostrarSnackbar('No se llenaron todos los campos', Colors.red, _scaffoldKey);
    }
  }

  _limpiarForm(){
    estadoSolucionesGroupValue = -1;
    tiemposDeHidratacionGroupValue = -1;
    cantidadRamosTinasGroupValue = -1;
    phSolucionController.text = '';
    nivelSolucionController.text = '';
    setState(() {});
  }
}