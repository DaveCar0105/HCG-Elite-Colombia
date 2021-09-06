import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_variedad.dart';
import 'package:hcgcalidadapp/src/constantes.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';
import 'package:hcgcalidadapp/src/modelos/destinos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_empaque.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';
import 'package:hcgcalidadapp/src/modelos/problema_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';
import 'package:hcgcalidadapp/src/modelos/tipoActividad.dart';
import 'package:hcgcalidadapp/src/modelos/tipoCliente.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
import 'package:hcgcalidadapp/src/basedatos/database_categoria_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_categoria_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_cliente.dart';
import 'package:hcgcalidadapp/src/basedatos/database_destinos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecommerce.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_falencia_ramos.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_postcosecha.dart';
import 'package:hcgcalidadapp/src/basedatos/database_producto.dart';
import 'package:hcgcalidadapp/src/modelos/variedad.dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SincronizarEntidadesApp {
  Future<void> sincronizarentidadesApp() async {
    Constantes co = Constantes();
    try {
      var url = Uri.http(co.url, '/api/Productos');
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
    } catch (e) {
      print("error " + e.toString());
    }

    var url1 = Uri.http(co.url, '/api/Clientes');
    final responseCliente = await http.get(url1);
    var clientes = json.decode(responseCliente.body);
    for (int i = 0; i < clientes.length; i++) {
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
      } catch (DatabaseException) {
        await DatabaseEcuador.updateTipoControl(tipo);
      }
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
      } catch (DatabaseException) {
        await DatabaseEcuador.updateTipoActividad(tipo);
      }
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
      } catch (DatabaseException) {
        await DatabaseEcuador.updateTipoCliente(tipo);
      }
    }

    var url12 = Uri.http(co.url, '/api/DestinoMaritimo');
    final responseDestinos = await http.get(url12);
    var destinos = json.decode(responseDestinos.body);
    for (int i = 0; i < destinos.length; i++) {
      var tipoDestino = ProcesoMaritimoDestinos(
          procesoMaritimoDestinoId: destinos[i]["destinoMaritimoId"],
          procesoMaritimoDestinoNombre: destinos[i]["destinoMaritimoNombre"]);
      try {
        await DatabaseDestino.addProcesoMaritimoDestinos(tipoDestino);
      } catch (DatabaseException) {
        await DatabaseDestino.updateProcesoMaritimoDestinos(tipoDestino);
      }
    }

    await _sincronizarEntityVariedad(co);
  }

  Future<void> _sincronizarEntityVariedad(Constantes constant) async {
    var url = Uri.http(constant.url, '/api/Variedad');
    final response = await http.get(url);
    var variedad = json.decode(response.body);
    for (int i = 0; i < variedad.length; i++) {
      var newVariedad = VariedadDto(
          variedadId: variedad[i][DatabaseCreator.variedadId],
          variedadNombre: variedad[i][DatabaseCreator.variedadNombre]);
      try {
        await DatabaseVariedad.addVariedad(newVariedad);
      } catch (DatabaseException) {
        await DatabaseVariedad.updateVariedad(newVariedad);
      }
    }
  }
}
