import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/banda.dart';
import 'package:hcgcalidadapp/src/modelos/control_banda.dart';
import 'package:hcgcalidadapp/src/modelos/detalleFirma.dart';
import 'package:hcgcalidadapp/src/modelos/error.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos_banda.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_sincronizacion.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

import 'database_detalle_firma.dart';
import 'database_error.dart';
import 'database_firma.dart';

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

  static Future<ReporteSincronizacionFinalBanda> getAllBandasSincro() async {
    ReporteSincronizacionFinalBanda listaFinalBanda = new ReporteSincronizacionFinalBanda();
    listaFinalBanda.listaRamo = [];
    listaFinalBanda.firmas = [];
    listaFinalBanda.detallesFirma = [];
    Preferences pref = Preferences();
    final sql = '''SELECT * 
          FROM ${DatabaseCreator.controlBandaTable}
          WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 2
          ''';
    var listaRamosSQL = await db.rawQuery(sql);
    try {
      var listaRamos = listaRamosSQL.toList();
      while (listaRamos.length > 0) {
        ListaRamoBanda itemRamo = ListaRamoBanda();
        itemRamo.controlRamosId = listaRamos[0][DatabaseCreator.controlRamosId];
        itemRamo.ramosNumeroOrden =
            listaRamos[0][DatabaseCreator.ramosNumeroOrden];
        itemRamo.clienteId = listaRamos[0][DatabaseCreator.clienteId];
        itemRamo.ramosDerogado = listaRamos[0][DatabaseCreator.ramosDerogado];
        itemRamo.ramosMarca = listaRamos[0][DatabaseCreator.ramoMarca];
        itemRamo.ramosTiempo = double.parse(
                listaRamos[0][DatabaseCreator.ramosHasta].toString()) -
            double.parse(listaRamos[0][DatabaseCreator.ramosDesde].toString());
        itemRamo.ramosFecha = listaRamos[0][DatabaseCreator.ramosFecha];
        itemRamo.ramosTallos = listaRamos[0][DatabaseCreator.ramosTallos];
        itemRamo.ramosDespachar = listaRamos[0][DatabaseCreator.ramosDespachar];
        itemRamo.ramosElaborados =
            listaRamos[0][DatabaseCreator.ramosElaborados];
        itemRamo.ramosTotal = listaRamos[0][DatabaseCreator.ramosTotal];
        itemRamo.productoId = listaRamos[0][DatabaseCreator.productoId];
        itemRamo.postcosechaId = listaRamos[0][DatabaseCreator.postcosechaId];
        itemRamo.detalleFirmaId = listaRamos[0][DatabaseCreator.detalleFirmaId];
        itemRamo.tipoId = listaRamos[0][DatabaseCreator.tipoControlId];
        itemRamo.usuarioId = pref.userId;
        final sqlRamos = '''SELECT *
          FROM ${DatabaseCreator.bandaTable}
          WHERE ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId} = ${itemRamo.controlRamosId}
          ''';
        var ramosSQL = await db.rawQuery(sqlRamos);
        var ramos = ramosSQL.toList();
        itemRamo.bandas = [];
        while (ramos.length > 0) {
          BandaSinc ramo = BandaSinc();
          ramo.controlRamosId = ramos[0][DatabaseCreator.controlRamosId];
          ramo.numeroMesa = ramos[0][DatabaseCreator.numeroMesa];
          ramo.variedad = ramos[0][DatabaseCreator.variedad];
          ramo.linea = ramos[0][DatabaseCreator.linea];
          ramo.bandaId = ramos[0][DatabaseCreator.bandaId];
          final sqlFalencias = '''SELECT * 
          FROM ${DatabaseCreator.falenciaBandaTable} 
          WHERE ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.bandaId} = ${ramo.bandaId}
          ''';
          var falenciasSQL = await db.rawQuery(sqlFalencias);
          ramo.falencias = [];
          var falencias = falenciasSQL.toList();
          while (falencias.length > 0) {
            BandaFalencia ramoFalencia = BandaFalencia();
            ramoFalencia.falenciaRamoId =
                falencias[0][DatabaseCreator.falenciaRamosId];
            ramoFalencia.falenciaBandaId =
                falencias[0][DatabaseCreator.falenciaBandaId];
            ramoFalencia.falenciaBandaRamos =
                falencias[0][DatabaseCreator.falenciaBandaRamos];
            if (ramoFalencia.falenciaRamoId > 0) {
              ramo.falencias.add(ramoFalencia);
            }
            falencias.removeWhere((element) {
              return element[DatabaseCreator.falenciaBandaId] ==
                  ramoFalencia.falenciaBandaId;
            });
          }
          itemRamo.bandas.add(ramo);
          ramos.removeWhere((element) {
            return element[DatabaseCreator.bandaId] == ramo.bandaId;
          });
        }
        try {
          jsonEncode(itemRamo);
          listaFinalBanda.listaRamo.add(itemRamo);
        } catch (e) {
          ErrorT error = ErrorT();
          error.errorDetalle = e.toString();
          await DatabaseError.addError(error);
        }
        listaRamos.removeWhere((element) {
          return element[DatabaseCreator.controlRamosId] ==
              itemRamo.controlRamosId;
        });
      }
    } catch (ex) {
      ErrorT error = ErrorT();
      error.errorDetalle = ex.toString();
      await DatabaseError.addError(error);
      listaFinalBanda.listaRamo = [];
    }
    try{
      List<Firma> firmaRam = await DatabaseFirma.consultarFirmasFinalBanda();
      for (int firR = 0; firR < firmaRam.length; firR++) {
        listaFinalBanda.firmas.add(Firmas(
            firmaCargo: firmaRam[firR].firmaCargo,
            firmaCodigo: firmaRam[firR].firmaCodigo,
            firmaCorreo: firmaRam[firR].firmaCorreo,
            firmaNombre: firmaRam[firR].firmaNombre,
            firmaId: firmaRam[firR].firmaId,
            firmaReal: 0));
      }
    }catch(e){}
    try{
      List<DetalleFirma> detalleFirmasRam = await DatabaseDetalleFirma.consultarDetallesFirmaBanda();
      for (int dfr = 0; dfr < detalleFirmasRam.length; dfr++) {
        listaFinalBanda.detallesFirma.add(DetallesFirma(
            detalleFirmaId: detalleFirmasRam[dfr].detalleFirmaId,
            firmaCodigo: detalleFirmasRam[dfr].detalleFirmaCodigo,
            firmaId: detalleFirmasRam[dfr].firmaId,
            firmaReal: 0));
      }
    }catch(e){}
    return listaFinalBanda;
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
