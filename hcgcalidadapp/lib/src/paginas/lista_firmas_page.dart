import 'dart:async';
import 'dart:ui' as ui;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:hcgcalidadapp/src/basedatos/database_detalle_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/bloc/firmas_bloc.dart';
import 'package:hcgcalidadapp/src/modelos/detalleFirma.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/utilidades/snackBar.dart';

class ListaFirmasPage extends StatefulWidget {
  ListaFirmasPage({Key key}) : super(key: key);

  @override
  _ListaFirmasPageState createState() => _ListaFirmasPageState();
}

class _ListaFirmasPageState extends State<ListaFirmasPage> {
  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 5.0;

  final _sign = GlobalKey<SignatureState>();
  final firmaBloc = new FirmasBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Firmas'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: firmaBloc.firmasStream(),
          builder: (BuildContext context, AsyncSnapshot<List<Firma>> snapshot){
            if(snapshot.hasData){
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i){
                return ListTile(
                  title: Text('Nombre: ${data[i].firmaNombre}\nCargo: ${data[i].firmaCargo}'),
                  subtitle: Text('Codigo: ${data[i].firmaCodigo}'),
                  leading: Text((i+1).toString()),
                  onTap: ()async {
                    await showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                        title: Text("Firma aquí este documento"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 150,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 10
                                  ),
                                ]
                              ),
                              child: Signature(
                                color: color,
                                key: _sign,
                                onSign: () {
                                  final sign = _sign.currentState;
                                },
                                backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                                strokeWidth: strokeWidth,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              color: Colors.white,
                              textColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              onPressed: () {
                                final sign = _sign.currentState;
                                sign.clear();
                                setState(() {
                                  _img = ByteData(0);
                                });
                              },
                              child: Text(
                                "Limpiar",style: TextStyle(
                                  fontSize: 18
                                ),
                              )
                            ),
                          ], 
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Firmar'),
                            onPressed: () async{
                              final sign = _sign.currentState;
                              //retrieve image data, do whatever you want with it (send to server, save locally...)
                              final image = await sign.getData();
                              var dataImage = await image.toByteData(format: ui.ImageByteFormat.png);
                              sign.clear();
                              final encoded = base64.encode(dataImage.buffer.asUint8List());
                              setState(() {
                                _img = dataImage;
                              });
                              if(encoded.length > 320) {
                                DetalleFirma detalleFirma = new DetalleFirma();
                                detalleFirma.detalleFirmaCodigo = encoded;
                                detalleFirma.firmaId = data[i].firmaId;
                                int detalleFirmaID = await DatabaseDetalleFirma.addDetalleFirma(detalleFirma);
                                await DatabaseFirma.firmarReportes(detalleFirmaID);
                                setState(() {});
                                Navigator.of(context).pop();
                                mostrarSnackbar('Firma Agregada Correctamente, regresando al menu Principal', Colors.green, _scaffoldKey);
                                Timer(Duration(milliseconds: 200), (){
                                  Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                                });
                              }else{
                                mostrarSnackbar('Ingrese una firma', null, _scaffoldKey);
                              }
                              
                              // encoded.length > 100 &&

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
                  },
                );
              }
            );
          }

          return Container();
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, 'firma');
        }
      ),
    );
  }
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    //canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}