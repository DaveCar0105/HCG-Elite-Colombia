import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/paginas/actividades_page.dart';
import 'package:hcgcalidadapp/src/paginas/calculo_muestra_page.dart';
import 'package:hcgcalidadapp/src/paginas/registro_temperatura_page.dart';

class HomeRegistrosPage extends StatefulWidget {
  @override
  _HomeRegistrosPageState createState() => _HomeRegistrosPageState();
}

class _HomeRegistrosPageState extends State<HomeRegistrosPage> {
  bool _switchVal = true;
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
                        builder: (context) => RegistroTemperaturaPage()));
              },
              child: Container(
                width: 130,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Temperaturas',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.pending_actions)
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ActividadesPage()));
              },
              child: Container(
                width: 130,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Actividades',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.engineering_outlined)
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
                        builder: (context) =>
                            CalculoMuestraPage()));
              },
              child: Container(
                width: 130,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Muestra',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.analytics)
                  ],
                ),
              ),
            ),
            //text: 'raise botton',
          ),
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
