import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_temperatura.dart';
import 'package:hcgcalidadapp/src/bloc/registro_temperatura_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/autocompletar.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/temperatura.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';
import 'package:hcgcalidadapp/src/utilidades/auto_completar.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class RegistroTemperaturaPage extends StatefulWidget {



  @override
  _RegistroTemperaturaPageState createState() => _RegistroTemperaturaPageState();
}

class _RegistroTemperaturaPageState extends State<RegistroTemperaturaPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _temperaturaBloc = new RegistroTemperaturaBloc();

  final appBar = AppBar();

  final temperaturaExterna = TextEditingController();

  final temperaturaInterna = TextEditingController();

  final prefs = new Preferences();

  GlobalKey<ListaBusquedaState> _keyPostcosecha = GlobalKey();
  List<AutoComplete> listaPostcosecha = new List<AutoComplete>();
  String postcosechaNombre = "";

  int postcosechaId=0;

  bool postcosechaEnable = false;
  _RegistroTemperaturaPageState(){
   cargarCombo();
  }
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
  Widget _postcosecha() {
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
        title: Text('Registro Temperatura'),
        actions: <Widget>[
          StreamBuilder(
            stream: _temperaturaBloc.registroTemperaturaStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              if(snapshot.hasData){
                final data = snapshot.data;
                return data == 0 ? Container() :Bounce(
                  controller: (controller) => _temperaturaBloc.bounceController = controller,
                  from: 20,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, 'detalleTemperatura');
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
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[

              Container(
                padding: EdgeInsets.only(
                  top: height * 0.05
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _postcosecha(),
                    _InputTemperatura(
                      title: 'Temperatura Cuarto Frío',
                      fontSize: height * 0.025,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                      controller: temperaturaExterna
                    ),
                    _InputTemperatura(
                      title: 'Temperatura Caja',
                      fontSize: height * 0.025,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                      margin: EdgeInsets.only(
                        top: height * 0.1
                      ),
                      controller: temperaturaInterna
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: height * 0.12,
                  left: width * 0.1,
                  right: width * 0.1,
                ),

                child: Row(
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
              ),
              ),
              SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }



  _validarForm() async{
    if(temperaturaExterna.text == '' && temperaturaInterna.text == ''){
      mostrarSnackbar('No se ha ingresado ninguna temperatura', Colors.red, _scaffoldKey);
    }else if(postcosechaId == 0){
      mostrarSnackbar('No se ha seleccionado una postcosecha', Colors.red, _scaffoldKey);
    }
    else{
      Temperatura temperatura = new Temperatura(
        temperaturaUsuarioControlId: 1,//prefs.userId,
        temperaturaInterna: temperaturaInterna.text == '' ? null : double.parse(temperaturaInterna.text),
        temperaturaExterna: temperaturaExterna.text == '' ? null : double.parse(temperaturaExterna.text),
        temperaturaFecha: DateTime.now(),
        postcosechaId: postcosechaId
      );
      final temperaturaId = await DatabaseTemperatura.addTemperatura(temperatura);
      if(temperaturaId != 0){
        mostrarSnackbar('Registro Guardado', Colors.green, _scaffoldKey);
        _temperaturaBloc.registroTemperaturaStream();
        _temperaturaBloc.itemAgregado();
        temperaturaExterna.text = '';
        temperaturaInterna.text = '';
      }else{
        mostrarSnackbar('No se pudo ingresar a la base de datos', Colors.red, _scaffoldKey);
      }
    }
  }
}

class _InputTemperatura extends StatelessWidget {
  const _InputTemperatura({
    Key key,
    @required this.fontSize,
    @required this.controller,
    @required this.title,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(      
        children: <Widget>[
          Text(
              title, 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "ejm: 9.5",                
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}