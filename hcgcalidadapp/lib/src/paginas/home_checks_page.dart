import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_empaque_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_hidratacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_maritimo_alstro_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_maritimo_page.dart';

class HomeChecksPage extends StatefulWidget {
  @override
  _HomeChecksPageState createState() => _HomeChecksPageState();
}

class _HomeChecksPageState extends State<HomeChecksPage> {
  bool sinc = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Botones(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcesoHidratacionPage()));
              },
              child: Container(
                width: 130,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Hidratación',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.fact_check)
                  ],
                ),
              ),
            ),
          ),
          Botones(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcesoEmpaquePage()));
              },
              child: Container(
                width: 130,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Empaque',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.fact_check_rounded)
                  ],
                ),
              ),
            ),
            //text: 'raise botton',
          ),
          Botones(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcesoMaritimoPage()));
              },
              child: Container(
                width: 135,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Marítimo',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.fact_check)
                  ],
                ),
              ),
            ),
          ),
          Botones(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProcesoMaritimoAlstroemeriaPage()));
              },
              child: Container(
                width: 135,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Marítimo Alstro',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.fact_check)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Botones extends StatelessWidget {
  final Widget child;
  //final String text;
  const Botones({
    @required this.child,
    // @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              this.child,
              SizedBox(
                height: 10,
              ),
              //Text(this.text, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
