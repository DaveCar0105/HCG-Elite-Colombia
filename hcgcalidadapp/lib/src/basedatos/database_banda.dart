import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/banda.dart';
import 'package:hcgcalidadapp/src/modelos/control_banda.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos_banda.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class DatabaseBanda {
  static Future<List<ControlBanda>> getAllBandas() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.controlBandaTable} ''';
    final data = await db.rawQuery(sql);
    List<ControlBanda> ramos = List();
    for (final node in data) {
      ramos.add(new ControlBanda(
          controlRamosId: node[DatabaseCreator.controlRamosId],
          ramosNumeroOrden: node[DatabaseCreator.ramosNumeroOrden],
          ramosTotal: node[DatabaseCreator.ramosTotal],
          ramosFecha: node[DatabaseCreator.ramosFecha],
          ramosAprobado: node[DatabaseCreator.ramosAprobado]));
    }
    return ramos;
  }

  static Future<int> addRamoBanda(int controlRamoId, Banda ramo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.bandaTable} 
    (${DatabaseCreator.controlRamosId},
    ${DatabaseCreator.variedad},${DatabaseCreator.numeroMesa},${DatabaseCreator.linea})
    VALUES(${controlRamoId},'${ramo.variedad}','${ramo.numeroMesa}','${ramo.linea}')''';
    return await db.rawInsert(sql);
  }

  static Future<int> addFalenciaReporteRamosbanda(
      FalenciaReporteRamosBanda falenciaReporteRamosBanda) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.falenciaBandaTable}(${DatabaseCreator.falenciaRamosId},${DatabaseCreator.bandaId},${DatabaseCreator.falenciaBandaRamos}) 
    VALUES(${falenciaReporteRamosBanda.falenciaBandaId},${falenciaReporteRamosBanda.ramosId},
    ${falenciaReporteRamosBanda.falenciasReporteRamosCantidad})''';
    return await db.rawInsert(sql);
  }

  static Future<List<Banda>> getAllBanda(int controlRamoId) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.bandaTable} WHERE ${DatabaseCreator.controlRamosId} = $controlRamoId''';
    final data = await db.rawQuery(sql);
    List<Banda> ramosBanda = List();
    for (final node in data) {
      final sql1 =
          '''SELECT count(*) as FALENCIAS FROM ${DatabaseCreator.falenciaBandaTable} WHERE ${DatabaseCreator.bandaId} = ${node[DatabaseCreator.bandaId]}''';
      final data1 = await db.rawQuery(sql1);
      ramosBanda.add(new Banda(
          controlRamoId: node[DatabaseCreator.controlRamosId],
          ramoId: node[DatabaseCreator.bandaId],
          numeroMesa: node[DatabaseCreator.numeroMesa],
          variedad: node[DatabaseCreator.variedad],
          linea: node[DatabaseCreator.linea],
          cantidadFalencias: data1[0]['FALENCIAS']));
    }
    return ramosBanda;
  }

  static Future<int> getAllBandasSinSincro() async {
    int valor = 0;
    final sql = '''SELECT COUNT(*) AS VALOR 
    FROM ${DatabaseCreator.controlBandaTable} 
    WHERE ${DatabaseCreator.ramosAprobado} = 1''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      valor += node["VALOR"];
    }
    return valor;
  }

  static Future<void> deleteBanda(int ramoId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.falenciasReporteBandaTable} WHERE ${DatabaseCreator.bandaId} = $ramoId''';
    await db.rawDelete(sql0);
    final sql =
        '''DELETE FROM ${DatabaseCreator.bandaTable} WHERE ${DatabaseCreator.bandaId} = $ramoId''';
    await db.rawDelete(sql);
  }

  static Future deleteBandas(int id) async {
    final sql = '''UPDATE ${DatabaseCreator.controlBandaTable}
    SET ${DatabaseCreator.ramosAprobado} = 10
    WHERE ${DatabaseCreator.controlRamosId} = $id
    ''';
    await db.rawUpdate(sql);
  }

  static Future<List<Map<String, dynamic>>> getAllBandasAprobacion() async {
    Preferences pref = Preferences();
    List<Map<String, dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlBandaTable},${DatabaseCreator.clienteTable},${DatabaseCreator.postcosechaTable},${DatabaseCreator.productoTable}
    WHERE ${DatabaseCreator.ramosAprobado} = 1
    AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId}=${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.postcosechaId}=${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId}
    AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.productoId}=${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}
    ''';
    final data = await db.rawQuery(sql);

    for (final node in data) {
      Map<String, dynamic> item = new Map();
      final sql1 =
          '''SELECT ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaBandaId},
       ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre},
       ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaBandaRamos}
      FROM ${DatabaseCreator.falenciaBandaTable},${DatabaseCreator.falenciaRamosTable}
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}
      AND ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaRamosId}=${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId}''';
      final data1 = await db.rawQuery(sql1);
      List<Map<String, dynamic>> listaFalencias = [];

      for (final fal in data1) {
        Map<String, dynamic> itemFal = Map();
        itemFal = {
          'falenciaRamosNombre': fal[DatabaseCreator.falenciaRamosNombre],
          'falenciaBandaId': fal[DatabaseCreator.falenciaBandaId],
          'falenciaBandaRamos': fal[DatabaseCreator.falenciaBandaRamos]
        };

        listaFalencias.add(itemFal);
      }
      item = {
        'controlBandaId': node[DatabaseCreator.controlRamosId],
        'controlNumeroOrden': node[DatabaseCreator.ramosNumeroOrden],
        'bandaRamos': node[DatabaseCreator.ramosTotal],
        'bandaFecha': node[DatabaseCreator.ramosFecha],
        'bandaAprobado': node[DatabaseCreator.ramosAprobado],
        'bandaTallos': node[DatabaseCreator.ramosTallos],
        'bandaDerogado': node[DatabaseCreator.ramosDerogado],
        'bandaElaborado': node[DatabaseCreator.ramosElaborados],
        'bandaDespachado': node[DatabaseCreator.ramosDespachar],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'clienteId': node[DatabaseCreator.clienteId],
        'productoId': node[DatabaseCreator.productoId],
        'clienteNombre': node[DatabaseCreator.clienteNombre],
        'postcosechaNombre': node[DatabaseCreator.postcosechaNombre],
        'productoNombre': node[DatabaseCreator.productoNombre],
        'usuarioId': pref.userId,
        'marca': node[DatabaseCreator.ramoMarca],
        'bandaProblemas': listaFalencias,
        'tipoId': node[DatabaseCreator.tipoControlId],
        'detalleFirmaId': node[DatabaseCreator.detalleFirmaId]
      };

      listaBandas.add(item);
    }

    return listaBandas;
  }

  static Future<Map<String, dynamic>> getAllBandasSincro() async {
    Preferences pref = Preferences();
    List<Map<String, dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlBandaTable} 
    WHERE ${DatabaseCreator.ramosAprobado} = 2''';
    final data = await db.rawQuery(sql);

    for (final node in data) {
      Map<String, dynamic> item = new Map();
      final sql1 = '''SELECT * 
      FROM ${DatabaseCreator.falenciaBandaTable} 
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}''';
      final data1 = await db.rawQuery(sql1);
      List<Map<String, dynamic>> listaFalencias = [];

      for (final fal in data1) {
        Map<String, dynamic> itemFal = Map();
        itemFal = {
          'falenciaRamosId': fal[DatabaseCreator.falenciaRamosId],
          'falenciaBandaId': fal[DatabaseCreator.falenciaBandaId],
          'falenciaBandaRamos': fal[DatabaseCreator.falenciaBandaRamos]
        };

        listaFalencias.add(itemFal);
      }
      item = {
        'controlBandaId': node[DatabaseCreator.controlRamosId],
        'controlNumeroOrden': node[DatabaseCreator.ramosNumeroOrden],
        'bandaRamos': node[DatabaseCreator.ramosTotal],
        'bandaFecha': node[DatabaseCreator.ramosFecha],
        'bandaAprobado': node[DatabaseCreator.ramosAprobado],
        'bandaTallos': node[DatabaseCreator.ramosTallos],
        'bandaDerogado': node[DatabaseCreator.ramosDerogado],
        'bandaElaborado': node[DatabaseCreator.ramosElaborados],
        'bandaDespachado': node[DatabaseCreator.ramosDespachar],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'clienteId': node[DatabaseCreator.clienteId],
        'productoId': node[DatabaseCreator.productoId],
        'usuarioId': pref.userId,
        'marca': node[DatabaseCreator.ramoMarca],
        'bandaProblemas': listaFalencias,
        'tipoId': node[DatabaseCreator.tipoControlId],
        'detalleFirmaId': node[DatabaseCreator.detalleFirmaId]
      };

      listaBandas.add(item);
    }

    List<Map<String, dynamic>> listaFirma = [];
    final sql1 = '''
      SELECT ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre} 
      FROM ${DatabaseCreator.firmaTable}, 
      ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlBandaTable} 
      WHERE ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId} = 
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      AND ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 2 
      GROUP BY ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre}
    ''';
    final data1 = await db.rawQuery(sql1);
    for (var firma in data1) {
      Map<String, dynamic> item = new Map();
      item = {
        "firmaId": firma[DatabaseCreator.firmaId],
        "firmaCodigo": firma[DatabaseCreator.firmaCodigo],
        "firmaCargo": firma[DatabaseCreator.firmaCargo],
        "firmaNombre": firma[DatabaseCreator.firmaNombre],
        "firmaCorreo": firma[DatabaseCreator.firmaCorreo]
      };
      listaFirma.add(item);
    }

    final sql2 = '''
      SELECT ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      FROM ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlBandaTable} 
      WHERE ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 2 
      GROUP BY ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
    ''';

    final data2 = await db.rawQuery(sql2);

    List<Map<String, dynamic>> detalleFirma = [];

    for (var detFirma in data2) {
      Map<String, dynamic> itemDetalle = new Map();
      itemDetalle = {
        "detalleFirmaId": detFirma[DatabaseCreator.detalleFirmaId],
        "detalleFirmaCodigo": detFirma[DatabaseCreator.detalleFirmaCodigo],
        "firmaId": detFirma[DatabaseCreator.firmaId]
      };
      detalleFirma.add(itemDetalle);
    }
    Map<String, dynamic> retorno = new Map();
    retorno = {
      "firmas": listaFirma,
      "detallesFirma": detalleFirma,
      "listaBanda": listaBandas
    };
    return retorno;
  }

  static Future<int> addBandas(ControlBanda ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.controlBandaTable}(${DatabaseCreator.detalleFirmaId},${DatabaseCreator.productoId},${DatabaseCreator.usuarioId},${DatabaseCreator.ramosFecha},${DatabaseCreator.ramosNumeroOrden},${DatabaseCreator.ramosTotal},${DatabaseCreator.ramosAprobado},${DatabaseCreator.ramosTallos},${DatabaseCreator.ramosDespachar},${DatabaseCreator.ramosElaborados},${DatabaseCreator.ramosDerogado},${DatabaseCreator.postcosechaId},${DatabaseCreator.ramoMarca},${DatabaseCreator.ramosDesde},${DatabaseCreator.ramosHasta},${DatabaseCreator.clienteId},${DatabaseCreator.elite},${DatabaseCreator.tipoControlId}
        ) 
    VALUES(${ramos.detalleFirmaId},${ramos.productoId},${ramos.usuarioId},'${ramos.ramosFecha}','${ramos.ramosNumeroOrden}',${ramos.ramosTotal},${ramos.ramosAprobado},${ramos.ramosTallos},${ramos.ramosDespachar},${ramos.ramosElaborados},'${ramos.ramosDerogado}',${ramos.postcosechaId},'${ramos.ramosMarca}',${ramos.ramosDesde},${ramos.ramosHasta},${ramos.clienteId},${ramos.elite},${ramos.tipoId})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateBandas(ControlBanda ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlBandaTable}
    SET ${DatabaseCreator.ramosNumeroOrden} = '${ramos.ramosNumeroOrden}',
    ${DatabaseCreator.ramosTallos} = ${ramos.ramosTallos},
    ${DatabaseCreator.ramosDerogado} = '${ramos.ramosDerogado}',
    ${DatabaseCreator.ramosDespachar} = ${ramos.ramosDespachar},
    ${DatabaseCreator.ramosElaborados} = ${ramos.ramosElaborados},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta},
    ${DatabaseCreator.ramosTotal} = ${ramos.ramosTotal},
    ${DatabaseCreator.clienteId} = ${ramos.clienteId},
    ${DatabaseCreator.productoId} = ${ramos.productoId},
    ${DatabaseCreator.postcosechaId} =${ramos.postcosechaId},
    ${DatabaseCreator.ramoMarca} ='${ramos.ramosMarca}'
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> finBandas(ControlBanda ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlBandaTable}
    SET ${DatabaseCreator.ramosAprobado} = ${ramos.ramosAprobado},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta}
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> bandaSincronizadas() async {
    final sql = '''UPDATE ${DatabaseCreator.controlBandaTable}
    SET ${DatabaseCreator.ramosAprobado} = 3
    ''';
    await db.rawInsert(sql);
  }

  static Future<int> addFalenciaReporteBanda(
      FalenciaReporteRamos falenciaReporteRamos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.falenciaBandaTable}(${DatabaseCreator.falenciaRamosId},${DatabaseCreator.falenciaBandaRamos},${DatabaseCreator.controlRamosId}) 
    VALUES(${falenciaReporteRamos.falenciaRamosId},${falenciaReporteRamos.falenciasReporteRamosCantidad},${falenciaReporteRamos.ramosId})''';
    return await db.rawInsert(sql);
  }

  static Future<List<FalenciaReporteRamosBanda>> getAllFalenciasXBandaId(
      int id) async {
    final sql =
        '''SELECT ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre},
    ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId},
    ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaBandaRamos},
    ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaBandaId}
    FROM ${DatabaseCreator.falenciaBandaTable},${DatabaseCreator.falenciaRamosTable}
    WHERE ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.bandaId} = $id
    AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaRamosId}
    ''';
    final data = await db.rawQuery(sql);
    List<FalenciaReporteRamosBanda> falenciaReporteRamos = [];
    for (final node in data) {
      falenciaReporteRamos.add(new FalenciaReporteRamosBanda(
        ramosId: id,
        falenciasReporteRamosCantidad: node[DatabaseCreator.falenciaBandaRamos],
        falenciasReporteRamosId: node[DatabaseCreator.falenciaBandaId],
        falenciaBandaId: node[DatabaseCreator.falenciaRamosId],
        falenciaRamosNombre: node[DatabaseCreator.falenciaRamosNombre],
      ));
    }
    return falenciaReporteRamos;
  }

  static Future<void> updateCantidadFalenciaReporteBanda(
      FalenciaReporteRamosBanda falenciaReporteRamos) async {
    final sql = '''UPDATE ${DatabaseCreator.falenciaBandaTable}
    SET ${DatabaseCreator.falenciaBandaRamos} = ${falenciaReporteRamos.falenciasReporteRamosCantidad}
    WHERE ${DatabaseCreator.falenciaBandaId} = ${falenciaReporteRamos.falenciasReporteRamosId}
    ''';

    await db.rawInsert(sql);
  }
}
