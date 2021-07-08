import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/bloc/firmas_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';
import 'package:qrscan/qrscan.dart' as scanner;


class FirmaPage extends StatefulWidget {
  FirmaPage({Key key}) : super(key: key);

  @override
  _FirmaPageState createState() => _FirmaPageState();
}

class _FirmaPageState extends State<FirmaPage> {
  
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  final nombre = TextEditingController();
  final cargo = TextEditingController();
  final correo = TextEditingController();
  final codigoModal = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _firmaBloc = new FirmasBloc();

  String codigo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Agregar Firma'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 70,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: codigo == '' 
                        ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: RaisedButton(                          
                            onPressed: (){
                              _bottomSheetOrden(context);                
                            },
                            color: Colors.red,
                            child: Text('Ingresar Código'),
                            textColor: Colors.white,
                            shape: StadiumBorder(),              
                          ),
                        ) 
                        : Container(
                          child: Text(
                            codigo,
                            textScaleFactor: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      codigo == '' ? SizedBox() :RaisedButton(            
                        shape: CircleBorder(),
                        color: Colors.red,
                        child: Icon(Icons.create, color: Colors.white,),
                        onPressed: (){
                          _bottomSheetOrden(context);
                        }
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Nombre",
                      labelText: "Nombre"
                    ),
                    controller: nombre,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cargo",
                      labelText: "Cargo"
                    ),
                    controller: cargo,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Correo Electrónico",
                      labelText: "Correo Electrónico"
                    ),
                    controller: correo,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            onPressed: () async {                              
                              if(nombre.text.length>0 && cargo.text.length>0){
                                final firma = Firma();
                                firma.firmaNombre = nombre.text;
                                firma.firmaCargo = cargo.text;
                                firma.firmaCorreo = correo.text;
                                firma.firmaCodigo = codigo;
                                int firmaId =0;
                                firmaId=await DatabaseFirma.addFirma(firma);
                                if(firmaId != 0){
                                  mostrarSnackbar('Firma Agregada Correctamente, regresando al menu de firmas', Colors.green, _scaffoldKey);
                                  Timer(Duration(seconds: 2), (){
                                    _firmaBloc.obtenerFirmas();
                                    Navigator.pop(context);
                                  });
                                }else{
                                  mostrarSnackbar('No se pudo agregar la firma', null, _scaffoldKey);
                                }
                              }
                            },
                            child: Text("Guardar",style: TextStyle(
                                fontSize: 18
                            ),)),                        
                      ],
                    ),

                  ],
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  _bottomSheetOrden(context){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext bc){
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.red,),
                title: Text('Codigo de Barras'),
                onTap: () async{
                  Navigator.maybePop(context);
                  codigo = await scanner.scan();
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(Icons.font_download, color: Colors.red,),
                title: Text('Ingresar Código'),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => new AlertDialog(
                      title: Text("Ingresa el código"),
                      content: TextField(
                        controller: codigoModal,
                        decoration: InputDecoration(
                          hintText: 'Código'
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Guardar'),
                          onPressed: () {
                            codigo = codigoModal.text;
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    );
  }
}