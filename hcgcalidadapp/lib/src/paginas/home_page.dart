import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/paginas/aprobacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/home_checks_page.dart';
import 'package:hcgcalidadapp/src/paginas/home_formularios_page.dart';
import 'package:hcgcalidadapp/src/paginas/home_registros_page.dart';
import 'package:hcgcalidadapp/src/paginas/reporte_general_page.dart';
import 'package:hcgcalidadapp/src/paginas/sincronizar_page.dart';
import 'package:hcgcalidadapp/src/servicios/sincronizar_entidades.services.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currenIndexBottomNavigation = 0;
  bool sinc = false;
  sincornizar() async {
    setState(() {
      sinc = true;
    });
    SincronizarEntidadesApp sincronizarEntidadesApp = new SincronizarEntidadesApp();
    await sincronizarEntidadesApp.sincronizarentidadesApp();
    setState(() {
      sinc = false;
    });
  }

  final pages = [
    HomeFormulariosPage(),
    HomeChecksPage(),
    HomeRegistrosPage(),
    AprobacionPage(),
    SincronizarPage(),
    ReporteGeneralPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('HIGH CONTROL GROUP'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              sincornizar();
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('HIGH CONTROL GROUP'),
                accountEmail: Text('https://highcontrolgroup.com/'),
                currentAccountPicture: Container(
                  height: 40,
                  width: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.asset(
                    'assets/img/logo_app.jpg',
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                )),
            ListTile(
              title: Text('Errores'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'errores');
              },
            ),
            ListTile(
              title: Text('Reportes sincronizados'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'listaReportes');
              },
            ),
            ListTile(
              title: Text('Lista Reporte Detalle'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'listaHistorial');
              },
            ),
            ListTile(
              title: Text('Salir'),
              onTap: () {
                Preferences pref = Preferences();
                pref.userId = 0;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'login', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
      body:pages[_currenIndexBottomNavigation],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currenIndexBottomNavigation,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon:Icon(Icons.library_books),
            title: Text("Formulario"),
            backgroundColor: Colors.blue 
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.playlist_add_check),
            title: Text("Checks"),
            backgroundColor: Colors.blue 
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.bar_chart),
            title: Text("Registros"),
            backgroundColor: Colors.blue 
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.check_circle),
            title: Text("Aprobacion"),
            backgroundColor: Colors.blue 
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.autorenew_rounded),
            title: Text("Sincronizacion"),
            backgroundColor: Colors.blue 
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.assessment_outlined),
            title: Text("Reporte General"),
            backgroundColor: Colors.blue 
          ),
        ],
        onTap: (index){
          setState(() {
            _currenIndexBottomNavigation = index;
          });
        },
      )
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
            ],
          ),
        ),
      ),
    );
  }
}
