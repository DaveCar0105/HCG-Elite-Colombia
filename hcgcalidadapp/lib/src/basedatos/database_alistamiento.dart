import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_control_alistamiento.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class DatabaseAlistamiento{
  static Future<List<ControlRamos>> getAllBandas() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.controlAlistamientoTable} ''';
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
  static Future<void> alistamientoSincronizados() async {
    final sql =
    '''UPDATE ${DatabaseCreator.controlAlistamientoTable}
    SET ${DatabaseCreator.ramosAprobado} = 2
    ''';
    await db.rawInsert(sql);
  }
  static Future<List<Map<String,dynamic>>> getAllAlistamientoSincro() async {
    Preferences pref = Preferences();
    List<Map<String,dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlAlistamientoTable} 
    WHERE ${DatabaseCreator.ramosAprobado} = 1''';
    final data =  await  db.rawQuery(sql);

    for(final node in data){
      Map<String,dynamic> item = new Map();
      final sql1 = '''SELECT * 
      FROM ${DatabaseCreator.falenciaAlistamientoTable} 
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}''';
      final data1 =  await  db.rawQuery(sql1);
      List<Map<String,dynamic>> listaFalencias = [];

      for(final fal in data1){
        Map<String,dynamic> itemFal = Map();
        itemFal ={
          'falenciaRamosId':fal[DatabaseCreator.falenciaRamosId],
          'falenciaAlistamientoId':fal[DatabaseCreator.falenciaAlistamientoId],
          'productoId':fal[DatabaseCreator.productoId],
          'variedadNombre':fal[DatabaseCreator.falenciaAlistamientoVariedad],
          'falenciaAlistamientoTallosMuestra':fal[DatabaseCreator.falenciaAlistamientoTallosMuestra],
          'falenciaAlistamientoTallosAfectados':fal[DatabaseCreator.falenciaAlistamientoTallosAfectados]
        };

        listaFalencias.add(itemFal);

      }
      item = {
        'controlAlistamientoId':node[DatabaseCreator.controlRamosId],
        'alistamientoFecha': node[DatabaseCreator.ramosFecha],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'clienteId': node[DatabaseCreator.clienteId],
        'usuarioId': pref.userId,
        'alistamientoProblemas':listaFalencias,
        'tipoId': node[DatabaseCreator.tipoControlId]
      };

      listaBandas.add(item);
    }
    return listaBandas;
  }
  static Future<int> addAlistamiento(ControlRamos ramos) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator
        .controlAlistamientoTable}(${DatabaseCreator
        .detalleFirmaId},${DatabaseCreator
        .usuarioId},${DatabaseCreator
        .ramosFecha},${DatabaseCreator
        .ramosAprobado},${DatabaseCreator
        .postcosechaId},${DatabaseCreator
        .ramosDesde},${DatabaseCreator
        .ramosHasta},${DatabaseCreator
        .clienteId},${DatabaseCreator
        .elite},${DatabaseCreator
        .tipoControlId}) 
    VALUES(${ramos
        .detalleFirmaId},${ramos
        .usuarioId},'${ramos
        .ramosFecha}',${ramos
        .ramosAprobado},${ramos
        .postcosechaId},${ramos
        .ramosDesde},${ramos
        .ramosHasta},${ramos
        .clienteId},${ramos
        .elite},${ramos
        .tipoId})''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateAlistamiento(ControlRamos ramos) async {

    final sql =
    '''UPDATE ${DatabaseCreator.controlAlistamientoTable}
    SET ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta},
    ${DatabaseCreator.clienteId} = ${ramos.clienteId},
    ${DatabaseCreator.postcosechaId} =${ramos.postcosechaId}
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }
  static Future<void> finAlistamiento(ControlRamos ramos) async {

    final sql =
    '''UPDATE ${DatabaseCreator.controlAlistamientoTable}
    SET ${DatabaseCreator.ramosAprobado} = ${ramos.ramosAprobado},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta}
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }
  static Future<int> addFalenciaReporteBanda(FalenciaControlAlistamiento falenciaReporteRamos) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.falenciaAlistamientoTable}(
    ${DatabaseCreator.falenciaAlistamientoTallosMuestra},
    ${DatabaseCreator.falenciaAlistamientoTallosAfectados},
    ${DatabaseCreator.controlRamosId},
    ${DatabaseCreator.falenciaAlistamientoVariedad},
    ${DatabaseCreator.productoId},
    ${DatabaseCreator.falenciaRamosId}
    ) 
    VALUES(${falenciaReporteRamos.falenciasReporteTallosMuestra},
    ${falenciaReporteRamos.falenciasReporteTallosAfectados},
    ${falenciaReporteRamos.controlAlistamientoId},
    '${falenciaReporteRamos.falenciasReporteVariedad}',
    ${falenciaReporteRamos.productoId},
    ${falenciaReporteRamos.falenciaRamosId})''';
    return await db.rawInsert(sql);
  }

  static Future<List<FalenciaControlAlistamiento>> getAllFalenciasXBandaId(int id) async {
    final sql = '''SELECT ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre},
    ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.falenciaAlistamientoId},
    ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.falenciaAlistamientoTallosMuestra},
    ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.falenciaAlistamientoTallosAfectados},
    ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.falenciaAlistamientoVariedad},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre}
    FROM ${DatabaseCreator.falenciaAlistamientoTable},
    ${DatabaseCreator.falenciaRamosTable},
    ${DatabaseCreator.productoTable}
    WHERE ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.controlRamosId} = $id
    AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.falenciaRamosId}
    AND ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.falenciaAlistamientoTable}.${DatabaseCreator.productoId}
    ''';
    final data =  await  db.rawQuery(sql);
    List<FalenciaControlAlistamiento> falenciaReporteRamos = [];
    for(final node in data){
      falenciaReporteRamos.add(new FalenciaControlAlistamiento(
        controlAlistamientoId: id,
        falenciasReporteTallosMuestra: node[DatabaseCreator.falenciaAlistamientoTallosMuestra],
        falenciasReporteRamosId: node[DatabaseCreator.falenciaAlistamientoId],
        falenciaRamosId: node[DatabaseCreator.falenciaRamosId],
        falenciasReporteNombre: node[DatabaseCreator.falenciaRamosNombre],
        falenciasReporteTallosAfectados :node[DatabaseCreator.falenciaAlistamientoTallosAfectados],
        productoId: node[DatabaseCreator.productoId],
        falenciasReporteVariedad: node[DatabaseCreator.falenciaAlistamientoVariedad],
      ));
    }
    return falenciaReporteRamos;
  }
}