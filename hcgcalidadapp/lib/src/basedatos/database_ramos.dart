import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/ramo.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';

class DatabaseRamos {
  static Future<List<ControlRamos>> getAllRamos() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.controlRamosTable} ''';
    final data = await db.rawQuery(sql);
    List<ControlRamos> ramos = List();
    for (final node in data) {
      ramos.add(new ControlRamos(
          controlRamosId: node[DatabaseCreator.controlRamosId],
          ramosNumeroOrden: node[DatabaseCreator.ramosNumeroOrden],
          ramosTotal: node[DatabaseCreator.ramosTotal],
          ramosFecha: node[DatabaseCreator.ramosFecha],
          ramosAprobado: node[DatabaseCreator.ramosAprobado]));
    }
    return ramos;
  }

  static Future<int> addRamos(ControlRamos ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.controlRamosTable}(${DatabaseCreator.detalleFirmaId},${DatabaseCreator.productoId},${DatabaseCreator.usuarioId},${DatabaseCreator.ramosFecha},${DatabaseCreator.ramosNumeroOrden},${DatabaseCreator.ramosTotal},${DatabaseCreator.ramosAprobado},${DatabaseCreator.ramosTallos},${DatabaseCreator.ramosDespachar},${DatabaseCreator.ramosElaborados},${DatabaseCreator.ramosDerogado},${DatabaseCreator.postcosechaId},${DatabaseCreator.ramoMarca},${DatabaseCreator.ramosDesde},${DatabaseCreator.ramosHasta},${DatabaseCreator.clienteId},${DatabaseCreator.elite}) 
    VALUES(${ramos.detalleFirmaId},${ramos.productoId},${ramos.usuarioId},'${ramos.ramosFecha}','${ramos.ramosNumeroOrden}',${ramos.ramosTotal},${ramos.ramosAprobado},${ramos.ramosTallos},${ramos.ramosDespachar},${ramos.ramosElaborados},'${ramos.ramosDerogado}',${ramos.postcosechaId},'${ramos.ramosMarca}',${ramos.ramosDesde},${ramos.ramosHasta},${ramos.clienteId},${ramos.elite})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateRamos(ControlRamos ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlRamosTable}
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

  static Future<void> finRamos(ControlRamos ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlRamosTable}
    SET ${DatabaseCreator.ramosAprobado} = ${ramos.ramosAprobado},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta}
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<int> addRamo(int controlRamoId, Ramo ramo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.ramosTable} 
    (${DatabaseCreator.controlRamosId},
    ${DatabaseCreator.variedad},${DatabaseCreator.numeroMesa},${DatabaseCreator.linea})
    VALUES(${controlRamoId},'${ramo.variedad}','${ramo.numeroMesa}','${ramo.linea}')''';
    return await db.rawInsert(sql);
  }

  static Future<List<Ramo>> getAllRamo(int controlRamoId) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.ramosTable} WHERE ${DatabaseCreator.controlRamosId} = $controlRamoId''';
    final data = await db.rawQuery(sql);
    List<Ramo> ramos = List();
    for (final node in data) {
      final sql1 =
          '''SELECT count(*) as FALENCIAS FROM ${DatabaseCreator.falenciasReporteRamosTable} WHERE ${DatabaseCreator.ramosId} = ${node[DatabaseCreator.ramosId]}''';
      final data1 = await db.rawQuery(sql1);
      ramos.add(new Ramo(
          controlRamoId: node[DatabaseCreator.controlRamosId],
          ramoId: node[DatabaseCreator.ramosId],
          numeroMesa: node[DatabaseCreator.numeroMesa],
          variedad: node[DatabaseCreator.variedad],
          linea: node[DatabaseCreator.linea],
          cantidadFalencias: data1[0]['FALENCIAS']));
    }
    return ramos;
  }

  static Future<void> deleteRamo(int ramoId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.falenciasReporteRamosTable} WHERE ${DatabaseCreator.ramosId} = $ramoId''';
    await db.rawDelete(sql0);
    final sql =
        '''DELETE FROM ${DatabaseCreator.ramosTable} WHERE ${DatabaseCreator.ramosId} = $ramoId''';
    await db.rawDelete(sql);
  }
}
