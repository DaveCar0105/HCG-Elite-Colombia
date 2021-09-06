import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/paginas/banda_page.dart';
import 'package:hcgcalidadapp/src/paginas/ecuador_page.dart';
import 'package:hcgcalidadapp/src/paginas/empaque_elite_page.dart';
import 'package:hcgcalidadapp/src/paginas/formularios/destinoEcommerce/control_destinoEcommerce_page.dart';
import 'package:hcgcalidadapp/src/paginas/ramos_elite_page.dart';

class HomeFormulariosPage extends StatefulWidget {
  @override
  _HomeFormulariosPageState createState() => _HomeFormulariosPageState();
}

class _HomeFormulariosPageState extends State<HomeFormulariosPage> {
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RamosElitePage(this._switchVal, 10)));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.red,
              textColor: Colors.white,
              child: Container(
                width: 120,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Hidratación',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.local_florist_outlined)
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
                        builder: (context) =>
                            EmpaqueElitePage(this._switchVal, 0)));
              },
              child: Container(
                width: 120,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Empaque',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.all_inbox)
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
                        builder: (context) => BandaPage(this._switchVal, 0)));
              },
              child: Container(
                width: 120,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Final banda',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.set_meal)
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
                        builder: (context) => EcuadorPage(this._switchVal, 0)));
              },
              child: Container(
                width: 120,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Ecuador',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.flag)
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
                        builder: (context) =>
                            ControlDestinoEcommercePage(this._switchVal, 10)));
              },
              child: Container(
                width: 120,
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Destino',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'E-commerce',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Icon(Icons.local_shipping)
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
