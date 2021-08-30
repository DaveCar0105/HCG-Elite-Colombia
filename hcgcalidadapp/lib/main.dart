import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/paginas/actividades_page.dart';
import 'package:hcgcalidadapp/src/paginas/aprobacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_proceso_empaque.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_proceso_maritimo_page.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_registro_actividades.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_registro_temperatura_page.dart';
import 'package:hcgcalidadapp/src/paginas/detalle_proceso_hidratacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/errores_page.dart';
import 'package:hcgcalidadapp/src/paginas/falencias_ramos_page.dart';
import 'package:hcgcalidadapp/src/paginas/firma_page.dart';
import 'package:hcgcalidadapp/src/paginas/home_page.dart';
import 'package:hcgcalidadapp/src/paginas/lista_firmas_page.dart';
import 'package:hcgcalidadapp/src/paginas/lista_reportes.dart';
import 'package:hcgcalidadapp/src/paginas/lista_reportes_detalles.dart';
import 'package:hcgcalidadapp/src/paginas/login_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_empaque_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_hidratacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/registro_temperatura_page.dart';
import 'package:hcgcalidadapp/src/paginas/sincronizar_page.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';
import 'package:hcgcalidadapp/src/providers/TipoClienteProvider.dart';
import 'package:hcgcalidadapp/src/servicios/sincronizar_entidades.services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseCreator db = new DatabaseCreator();
  final pref = Preferences();
  await pref.initPrefs();
  await db.initDatabase();
  bool sinc = false;
  try {
    sinc = pref.sinc;
  } catch (e) {
    sinc = false;
  }
  if (sinc == false) {
    SincronizarEntidadesApp sincronizarEntidadesApp  = new SincronizarEntidadesApp();
    await sincronizarEntidadesApp.sincronizarentidadesApp();
    pref.fechaIns = DateTime.now().toIso8601String();
    pref.sinc = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pref = Preferences();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TipoClienteProvide())
      ],
      child: MaterialApp(
        title: 'HCG CONTROL APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red, primaryColor: Colors.red),
        //darkTheme: ThemeData.dark(),
        initialRoute: pref.userId > 0 ? 'home' : 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'falenciasRamos': (BuildContext context) => FalenciasRamosPage(),
          'aprobacion': (BuildContext context) => AprobacionPage(),
          'listaFirma': (BuildContext context) => ListaFirmasPage(),
          'firma': (BuildContext context) => FirmaPage(),
          'sincronizar': (BuildContext context) => SincronizarPage(),
          'hidratacion': (BuildContext context) => ProcesoHidratacionPage(),
          'detalleHidratacion': (BuildContext context) =>
              DetalleRegistroProcesoHidratacionPage(),
          'temperatura': (BuildContext context) => RegistroTemperaturaPage(),
          'detalleTemperatura': (BuildContext context) =>
              DetalleRegistroTemperaturaPage(),
          'empaque': (BuildContext context) => ProcesoEmpaquePage(),
          'detalleEmpaque': (BuildContext context) =>
              DetalleRegistroProcesoEmpaquePage(),
          'detalleMaritimo': (BuildContext context) =>
              DetalleRegistroProcesoMaritimoPage(),
          'detalleMaritimoAlstroemeria': (BuildContext context) =>
              DetalleRegistroProcesoMaritimoPage(),
          'actividades': (BuildContext context) => ActividadesPage(),
          'detalleActividades': (BuildContext context) =>
              DetalleRegistroActividadesPage(),
          'errores': (BuildContext context) => ErroresPage(),
          'listaReportes': (BuildContext context) => ListaReportes(),
          'listaHistorial': (BuildContext context) => ListaReporteDetalle()
        },
      )
    );
  }
}
