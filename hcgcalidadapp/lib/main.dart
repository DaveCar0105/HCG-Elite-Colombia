import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_categoria_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_categoria_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecommerce.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'dart:convert';
import 'package:hcgcalidadapp/src/constantes.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/problema_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/tipoActividad.dart';
import 'package:hcgcalidadapp/src/modelos/tipoCliente.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
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
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constantes co = Constantes();
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
    var url = Uri.http(co.url, '/api/Productos');
    print(url);
    final dataProductos = await http.get(url);
    print(url);
    var productos = json.decode(dataProductos.body);
    for (int i = 0; i < productos.length; i++) {
      var producto = Producto(
          productoId: productos[i]["productoId"],
          productoNombre: productos[i]["productoNombre"],
          elite: productos[i]["elite"]);
      try {
        await DatabaseProducto.addProducto(producto);
      } catch (DatabaseException) {
        await DatabaseProducto.updateProducto(producto);
      }
    }
    var url1 = Uri.http(co.url, '/api/Clientes');
    final responseCliente = await http.get(url1);
    var clientes = json.decode(responseCliente.body);
    for (int i = 0; i < clientes.length; i++) {
      //print(jsonEncode(clientes));
      //print("-----------------------------------------");
      var cliente = Cliente(
          clienteId: clientes[i]["clienteId"],
          clienteNombre: clientes[i]["clienteNombre"],
          elite: clientes[i]["elite"],
          tipoClienteId: clientes[i]["tipoClienteId"]);
      try {
        await DatabaseCliente.addCliente(cliente);
      } catch (DatabaseException) {
        await DatabaseCliente.updateCliente(cliente);
      }
    }
    var url2 = Uri.http(co.url, '/api/Categoriasfalenciaramos');
    final responseCategoriaRamos = await http.get(url2);
    var categoriasRamos = json.decode(responseCategoriaRamos.body);
    for (int i = 0; i < categoriasRamos.length; i++) {
      var categoriaRamos = CategoriaRamos(
          categoriaRamosId: categoriasRamos[i]["categoriaFalenciaRamoId"],
          categoriaRamosNombre: categoriasRamos[i]["categoriaFalenciaNombre"]);
      try {
        await DatabaseCategoriaRamos.addCategoriaRamos(categoriaRamos);
      } catch (DatabaseException) {
        await DatabaseCategoriaRamos.updateCategoriaRamos(categoriaRamos);
      }
    }
    var url3 = Uri.http(co.url, '/api/Categoriafalenciaempaques');
    final responseCategoriaEmpaque = await http.get(url3);
    var categoriasEmpaque = json.decode(responseCategoriaEmpaque.body);
    for (int i = 0; i < categoriasEmpaque.length; i++) {
      var categoriaEmpaque = CategoriaEmpaque(
          categoriaEmpaqueId: categoriasEmpaque[i]
              ["categoriaFalenciaEmpaqueId"],
          categoriaEmpaqueNombre: categoriasEmpaque[i]
              ["categoriaFalenciaEmpaqueNombre"]);
      try {
        await DatabaseCategoriaEmpaque.addCategoriaEmpaque(categoriaEmpaque);
      } catch (DatabaseException) {
        await DatabaseCategoriaEmpaque.updateCategoriaEmpaque(categoriaEmpaque);
      }
    }
    var url4 = Uri.http(co.url, '/api/Falenciasramos');
    final responseFalenciaRamos = await http.get(url4);
    var falenciasRamos = json.decode(responseFalenciaRamos.body);
    for (int i = 0; i < falenciasRamos.length; i++) {
      var falenciaRamos = FalenciaRamos(
          falenciaRamosId: falenciasRamos[i]["falenciaRamoId"],
          falenciaRamosNombre: falenciasRamos[i]["falenciaRamoNombre"],
          categoriaRamosId: falenciasRamos[i]["categoriaFalenciaRamoId"],
          elite: falenciasRamos[i]["elite"]);
      try {
        await DatabaseFalenciaRamos.addFalenciaRamos(falenciaRamos);
      } catch (DatabaseException) {
        await DatabaseFalenciaRamos.updateFalenciaRamos(falenciaRamos);
      }
    }
    var url5 = Uri.http(co.url, '/api/Falenciaempaques');
    final responseFalenciaEmpaque = await http.get(url5);
    var falenciasEmpaque = json.decode(responseFalenciaEmpaque.body);
    for (int i = 0; i < falenciasEmpaque.length; i++) {
      var falenciaEmpaque = FalenciaEmpaque(
          falenciaEmpaqueId: falenciasEmpaque[i]["falenciaEmpaqueId"],
          falenciaEmpaqueNombre: falenciasEmpaque[i]["falenciaEmpaqueNombre"],
          categoriaEmpaqueId: falenciasEmpaque[i]["categoriaEmpaqueId"],
          elite: falenciasEmpaque[i]["elite"]);
      try {
        await DatabaseFalenciaEmpaque.addFalenciaEmpaque(falenciaEmpaque);
      } catch (DatabaseException) {
        await DatabaseFalenciaEmpaque.updateFalenciaEmpaque(falenciaEmpaque);
      }
    }
    var url6 = Uri.http(co.url, '/api/Postcosechas');
    final responsePostcosecha = await http.get(url6);
    var postcosechas = json.decode(responsePostcosecha.body);
    for (int i = 0; i < postcosechas.length; i++) {
      var postcosecha = PostCosecha(
          postCosechaId: postcosechas[i]["postcosechaId"],
          postCosechaNombre: postcosechas[i]["postcosechaNombre"],
          elite: postcosechas[i]["elite"]);
      try {
        await DatabasePostcosecha.addPostcosecha(postcosecha);
      } catch (DatabaseException) {
        await DatabasePostcosecha.updatePostcosecha(postcosecha);
      }
    }
    var url7 = Uri.http(co.url, '/api/Firmas');
    final responseFirma = await http.get(url7);
    var firmas = json.decode(responseFirma.body);
    for (int i = 0; i < firmas.length; i++) {
      var firma = Firma(
          firmaId: firmas[i]["firmaId"],
          firmaNombre: firmas[i]["firmaNombre"],
          firmaCargo: firmas[i]["firmaCargo"],
          firmaCodigo: firmas[i]["firmaCodigo"],
          firmaCorreo: firmas[i]["firmaCorreo"]);
      try {
        await DatabaseFirma.addFirma(firma);
      } catch (DatabaseException) {
        await DatabaseFirma.updateFirma(firma);
      }
    }

    var url8 = Uri.http(co.url, '/api/Problemasecommerce');
    final responseProblema1 = await http.get(url8);
    var problemas = json.decode(responseProblema1.body);
    for (int i = 0; i < problemas.length; i++) {
      var prob = ProblemaEcommerce(
          id: problemas[i]["problemaEcommerceId"],
          nombre: problemas[i]["problemaEcommerceNombre"],
          numero: problemas[i]["problemaEcommerceNumero"],
          tipo: problemas[i]["problemaEcommerceTipo"]);
      try {
        await DatabaseEcommerce.addProblemaEcommerce(prob);
      } catch (DatabaseException) {
        await DatabaseEcommerce.updateProblemaEcommerce(prob);
      }
    }

    var url9 = Uri.http(co.url, '/api/TipoControles');
    final responseProblema2 = await http.get(url9);
    var tipoControl = json.decode(responseProblema2.body);
    for (int i = 0; i < tipoControl.length; i++) {
      var tipo = TipoControl(
          tipoControlId: tipoControl[i]["tipoControlId"],
          tipoControlNombre: tipoControl[i]["tipoControlNombre"],
          claseId: tipoControl[i]["claseControl"]);
      try {
        await DatabaseEcuador.addTipoControl(tipo);
      } catch (DatabaseException) {}
    }

    var url10 = Uri.http(co.url, '/api/TipoControles/Actividad');
    final responseProblema11 = await http.get(url10);
    var tipoActividad = json.decode(responseProblema11.body);
    for (int i = 0; i < tipoActividad.length; i++) {
      var tipo = TipoActividad(
          tipoActividadId: tipoActividad[i]["tipoActividadId"],
          tipoActividadDescripcion: tipoActividad[i]
              ["tipoActividadDescripcion"]);
      try {
        await DatabaseEcuador.addTipoActividad(tipo);
      } catch (DatabaseException) {}
    }

    var url11 = Uri.http(co.url, '/api/TipoControles/Cliente');
    final responseProblema13 = await http.get(url11);
    var tipoCliente = json.decode(responseProblema13.body);
    for (int i = 0; i < tipoCliente.length; i++) {
      var tipo = TipoCliente(
          tipoClienteId: tipoCliente[i]["tipoClienteId"],
          tipoClienteNombre: tipoCliente[i]["tipoClienteNombre"]);
      try {
        await DatabaseEcuador.addTipoCliente(tipo);
      } catch (DatabaseException) {}
    }

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
            'actividades': (BuildContext context) => ActividadesPage(),
            'detalleActividades': (BuildContext context) =>
                DetalleRegistroActividadesPage(),
            'errores': (BuildContext context) => ErroresPage(),
            'listaReportes': (BuildContext context) => ListaReportes(),
            'listaHistorial': (BuildContext context) => ListaReporteDetalle()
          },
        ));
  }
}
