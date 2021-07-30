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
import 'package:hcgcalidadapp/src/paginas/circulo_calidad_page.dart';
import 'package:hcgcalidadapp/src/paginas/ecommerce_page.dart';
import 'package:hcgcalidadapp/src/paginas/ecuador_page.dart';
import 'package:hcgcalidadapp/src/paginas/empaque_elite_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_empaque_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_hidratacion_page.dart';
import 'package:hcgcalidadapp/src/paginas/proceso_maritimo_page.dart';
import 'package:hcgcalidadapp/src/paginas/ramos_elite_page.dart';
import 'package:hcgcalidadapp/src/paginas/registro_temperatura_page.dart';
import 'package:hcgcalidadapp/src/paginas/reporte_general_page.dart';
import 'package:hcgcalidadapp/src/paginas/sincronizar_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeChecksPage extends StatefulWidget {
  @override
  _HomeChecksPageState createState() => _HomeChecksPageState();
}

class _HomeChecksPageState extends State<HomeChecksPage> {
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
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
        title: Text('CHECKS HCG'),
      ),*/
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
                      'Hidratacion',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.fact_check)
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
                      'Maritimo',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.fact_check)
                  ],
                ),
              ),
            ),
            // text: 'raise botton',
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
