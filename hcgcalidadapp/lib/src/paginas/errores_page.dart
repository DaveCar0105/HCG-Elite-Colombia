import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_error.dart';
import 'package:hcgcalidadapp/src/modelos/error.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class ErroresPage extends StatefulWidget {
  @override
  _ErroresPageState createState() => _ErroresPageState();
}

class _ErroresPageState extends State<ErroresPage> {
  List<ErrorT> errores = new List<ErrorT>();
  Preferences pref = new Preferences();
  cargarErrores() async{

    errores = await DatabaseError.getAllErrores();
    setState(() {
    });
  }

  @override
  void initState() {
    cargarErrores();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            'Errores - Version 23.0',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          subtitle: Text(pref.fechaIns),
        )
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              ListTile(
                title: Text('Codigo'),
                subtitle: Text(errores[(errores.length-1) - index].errorDetalle.replaceAll(' ', '')),
              ),
          itemCount: errores.length,
        ),
      ),
    );
  }
}
