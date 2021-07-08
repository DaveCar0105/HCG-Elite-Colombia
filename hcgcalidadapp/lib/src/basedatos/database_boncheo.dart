import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class DatabaseBoncheo{
  static Future<List<ControlRamos>> getAllBandas() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.controlBoncheoTable} ''';
    final data =  await  db.rawQuery(sql);
    List<ControlRamos> ramos = [];
    for(final node in data){
      ramos.add(new ControlRamos(
          controlRamosId: node[DatabaseCreator.controlRamosId],
          ramosNumeroOrden: node[DatabaseCreator.ramosNumeroOrden],
          ramosTotal: node[DatabaseCreator.ramosTotal],
          ramosFecha: node[DatabaseCreator.ramosFecha],
          ramosAprobado: node[DatabaseCreator.ramosAprobado]
      ));
    }
    return ramos;
  }
  static Future<void> boncheoSincronizados() async {
    final sql =
    '''UPDATE ${DatabaseCreator.controlBoncheoTable}
    SET ${DatabaseCreator.ramosAprobado} = 2
    ''';
    await db.rawInsert(sql);
  }
  static Future<List<Map<String,dynamic>>> getAllBoncheoSincro() async {
    Preferences pref = Preferences();
    List<Map<String,dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlBoncheoTable} 
    WHERE ${DatabaseCreator.ramosAprobado} = 1''';
    final data =  await  db.rawQuery(sql);

    for(final node in data){
      Map<String,dynamic> item = new Map();
      final sql1 = '''SELECT * 
      FROM ${DatabaseCreator.falenciaBoncheTable} 
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}''';
      final data1 =  await  db.rawQuery(sql1);
      List<Map<String,dynamic>> listaFalencias = [];

      for(final fal in data1){
        Map<String,dynamic> itemFal = Map();
        itemFal ={
          'falenciaRamosId':fal[DatabaseCreator.falenciaRamosId],
          'falenciaBoncheoId':fal[DatabaseCreator.falenciaBandaId],
          'falenciaBoncheoRamos':fal[DatabaseCreator.falenciaBandaRamos],
        };

        listaFalencias.add(itemFal);

      }
      item = {
        'controlBoncheoId':node[DatabaseCreator.controlRamosId],
        'boncheoFecha': node[DatabaseCreator.ramosFecha],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'clienteId': node[DatabaseCreator.clienteId],
        'usuarioId': pref.userId,
        'boncheoMesa': node[DatabaseCreator.ramosElaborados],
        'ramosRevisados': node[DatabaseCreator.ramosTotal],
        'boncheoProblemas':listaFalencias
      };

      listaBandas.add(item);
    }
    return listaBandas;
  }
  static Future<int> addBandas(ControlRamos ramos) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator
        .controlBoncheoTable}(${DatabaseCreator
        .detalleFirmaId},${DatabaseCreator
        .productoId},${DatabaseCreator
        .usuarioId},${DatabaseCreator
        .ramosFecha},${DatabaseCreator
        .ramosNumeroOrden},${DatabaseCreator
        .ramosTotal},${DatabaseCreator
        .ramosAprobado},${DatabaseCreator
        .ramosTallos},${DatabaseCreator
        .ramosDespachar},${DatabaseCreator
        .ramosElaborados},${DatabaseCreator
        .ramosDerogado},${DatabaseCreator
        .postcosechaId},${DatabaseCreator
        .ramoMarca},${DatabaseCreator
        .ramosDesde},${DatabaseCreator
        .ramosHasta},${DatabaseCreator
        .clienteId},${DatabaseCreator
        .elite
    }) 
    VALUES(${ramos
        .detalleFirmaId},${ramos
        .productoId},${ramos
        .usuarioId},'${ramos
        .ramosFecha}','',${ramos
        .ramosTotal},${ramos
        .ramosAprobado},0,0,${ramos
        .ramosElaborados},'',${ramos
        .postcosechaId},'',${ramos
        .ramosDesde},${ramos
        .ramosHasta},${ramos
        .clienteId},${ramos
        .elite})''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateBandas(ControlRamos ramos) async {

    final sql =
    '''UPDATE ${DatabaseCreator.controlBoncheoTable}
    SET ${DatabaseCreator.ramosNumeroOrden} = '',
    ${DatabaseCreator.ramosTallos} = 0,
    ${DatabaseCreator.ramosDerogado} = '',
    ${DatabaseCreator.ramosDespachar} = 0,
    ${DatabaseCreator.ramosElaborados} = ${ramos.ramosElaborados},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta},
    ${DatabaseCreator.ramosTotal} = ${ramos.ramosTotal},
    ${DatabaseCreator.clienteId} = ${ramos.clienteId},
    ${DatabaseCreator.productoId} = ${ramos.productoId},
    ${DatabaseCreator.postcosechaId} =${ramos.postcosechaId},
    ${DatabaseCreator.ramoMarca} =''
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }
  static Future<void> finBandas(ControlRamos ramos) async {

    final sql =
    '''UPDATE ${DatabaseCreator.controlBoncheoTable}
    SET ${DatabaseCreator.ramosAprobado} = ${ramos.ramosAprobado},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta}
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }
  static Future<int> addFalenciaReporteBanda(FalenciaReporteRamos falenciaReporteRamos) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.falenciaBoncheTable}(${DatabaseCreator.falenciaRamosId},${DatabaseCreator.falenciaBandaRamos},${DatabaseCreator.controlRamosId}) 
    VALUES(${falenciaReporteRamos.falenciaRamosId},${falenciaReporteRamos.falenciasReporteRamosCantidad},${falenciaReporteRamos.ramosId})''';
    return await db.rawInsert(sql);
  }

  static Future<List<FalenciaReporteRamos>> getAllFalenciasXBandaId(int id) async {
    final sql = '''SELECT ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre},
    ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId},
    ${DatabaseCreator.falenciaBoncheTable}.${DatabaseCreator.falenciaBandaRamos},
    ${DatabaseCreator.falenciaBoncheTable}.${DatabaseCreator.falenciaBandaId}
    FROM ${DatabaseCreator.falenciaBoncheTable},${DatabaseCreator.falenciaRamosTable}
    WHERE ${DatabaseCreator.falenciaBoncheTable}.${DatabaseCreator.controlRamosId} = $id
    AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciaBoncheTable}.${DatabaseCreator.falenciaRamosId}
    ''';
    final data =  await  db.rawQuery(sql);
    List<FalenciaReporteRamos> falenciaReporteRamos = [];
    for(final node in data){
      falenciaReporteRamos.add(new FalenciaReporteRamos(
        ramosId: id,
        falenciasReporteRamosCantidad: node[DatabaseCreator.falenciaBandaRamos],
        falenciasReporteRamosId: node[DatabaseCreator.falenciaBandaId],
        falenciaRamosId: node[DatabaseCreator.falenciaRamosId],
        falenciaRamosNombre :node[DatabaseCreator.falenciaRamosNombre],
      ));
    }
    return falenciaReporteRamos;
  }

  static Future deleteFalenciasBoncheo(int id) async {
    final sql = '''DELETE FROM ${DatabaseCreator.falenciaBoncheTable} 
    WHERE ${DatabaseCreator.falenciaBandaId} = $id''';
    await db.rawQuery(sql);
  }
  static Future<void> updateCantidadFalenciaReporteBanda(FalenciaReporteRamos falenciaReporteRamos) async {

    final sql =
    '''UPDATE ${DatabaseCreator.falenciaBoncheTable}
    SET ${DatabaseCreator.falenciaBandaRamos} = ${falenciaReporteRamos.falenciasReporteRamosCantidad}
    WHERE ${DatabaseCreator.falenciaBandaId} = ${falenciaReporteRamos.falenciasReporteRamosId}
    ''';

    await db.rawUpdate(sql);
  }
}