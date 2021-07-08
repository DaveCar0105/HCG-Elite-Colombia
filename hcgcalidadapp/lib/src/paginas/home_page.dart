import 'package:flutter/material.dart';
import 'package:hcgcalidadapp/src/basedatos/database_categoria_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_categoria_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecommerce.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/constantes.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/problema_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/procesoEmpaque.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
import 'package:hcgcalidadapp/src/paginas/actividades_page.dart';
import 'package:hcgcalidadapp/src/paginas/alistamiento_page.dart';
import 'package:hcgcalidadapp/src/paginas/aprobacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/banda_page.dart';
import 'package:hcgcalidadapp/src/paginas/boncheo_page.dart';
import 'package:hcgcalidadapp/src/paginas/ecommerce_page.dart';
import 'package:hcgcalidadapp/src/paginas/ecuador_page.dart';
import 'package:hcgcalidadapp/src/paginas/empaque_elite_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_empaque_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_hidratacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/ramos_elite_page.dart';
import 'package:hcgcalidadapp/src/paginas/registro_temperatura_page.dart';
import 'package:hcgcalidadapp/src/paginas/reporte_general_page.dart';
import 'package:hcgcalidadapp/src/paginas/sincronizar_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _switchVal = true;
  bool sinc = false;
  sincornizar() async {
    setState(() {
      sinc = true;
    });
    Constantes co = Constantes();
    var url = Uri.http(co.url, 'Productos');
    final dataProductos = await http.get(url);
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
    var url1 = Uri.http(co.url, 'Clientes');
    final responseCliente = await http.get(url1);
    var clientes = json.decode(responseCliente.body);
    for (int i = 0; i < clientes.length; i++) {
      var cliente = Cliente(
          clienteId: clientes[i]["clienteId"],
          clienteNombre: clientes[i]["clienteNombre"],
          elite: clientes[i]["elite"]);
      try {
        await DatabaseCliente.addCliente(cliente);
      } catch (DatabaseException) {
        await DatabaseCliente.updateCliente(cliente);
      }
    }
    var url2 = Uri.http(co.url, 'Categoriasfalenciaramos');
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
    var url3 = Uri.http(co.url, 'Categoriafalenciaempaques');
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
    var url4 = Uri.http(co.url, 'Falenciasramos');
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
    var url5 = Uri.http(co.url, 'Falenciaempaques');
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
    var url6 = Uri.http(co.url, 'Postcosechas');
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
    var url7 = Uri.http(co.url, 'Firmas');
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
    setState(() {
      sinc = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HIGH CONTROL GROUP'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  sincornizar();
                })
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
              // ListTile(
              //   title: Text('Aprobacion'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, 'aprobacion');
              //   },
              // ),
              // ListTile(
              //   title: Text('Sincronizar'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, 'sincronizar');
              //   },
              // ),
              // ListTile(
              //   title: Text('Proceso de Hidratación'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, 'hidratacion');
              //   },
              // ),
              // ListTile(
              //   title: Text('Proceso de empaque'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, 'empaque');
              //   },
              // ),
              // ListTile(
              //   title: Text('Registro de Temperaturas'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, 'temperatura');
              //   },
              // ),
              // ListTile(
              //   title: Text('Actividades'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, 'actividades');
              //   },
              // ),
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'login', (Route<dynamic> route) => false);
                },
              )
            ],
          ),
        ),
        body: sinc
            ? Container(
                height: 30,
                width: double.infinity,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 75,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      Text("Esperar un par de  minutos...")
                    ],
                  ),
                ),
              )
            : Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RaisedButton(
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
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Hidratacion',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.local_florist_outlined)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
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
                        height: 30,
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BandaPage(this._switchVal, 0)));
                      },
                      child: Container(
                        width: 120,
                        height: 30,
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EcuadorPage(this._switchVal, 0)));
                      },
                      child: Container(
                        width: 120,
                        height: 30,
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AprobacionPage()));
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Aprobacion',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.check_circle)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SincronizarPage()));
                      },
                      child: Container(
                        width: 130,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Sincronizacion',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.autorenew_rounded)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProcesoHidratacionPage()));
                      },
                      child: Container(
                        width: 150,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'HidratacionCheck',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.fact_check)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
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
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'EmpaqueCheck',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.fact_check_rounded)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistroTemperaturaPage()));
                      },
                      child: Container(
                        width: 130,
                        height: 30,
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActividadesPage()));
                      },
                      child: Container(
                        width: 130,
                        height: 30,
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReporteGeneralPage()));
                      },
                      child: Container(
                        width: 135,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Reporte general',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.assessment_outlined)
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActividadesPage()));
                      },
                      child: Container(
                        width: 135,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Circulo Calidad',
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(Icons.trip_origin_rounded)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ));
  }
}
