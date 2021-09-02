import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/empaque.dart';
import 'package:hcgcalidadapp/src/modelos/empaque_item.dart';

class DatabaseEmpaque {
  static Future<List<ControlEmpaque>> getAllEmpaques() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.empaqueTable} ''';
    final data = await db.rawQuery(sql);
    List<ControlEmpaque> empaques = List();
    for (final node in data) {
      empaques.add(new ControlEmpaque(
          controlEmpaqueId: node[DatabaseCreator.empaqueId],
          empaqueNumeroOrden: node[DatabaseCreator.empaqueNumeroOrden],
          empaqueTotal: node[DatabaseCreator.empaqueTotal],
          empaqueFecha: node[DatabaseCreator.empaqueFecha],
          empaqueAprobado: node[DatabaseCreator.empaqueAprobado]));
    }
    return empaques;
  }

  static Future<int> addEmpaques(ControlEmpaque empaque) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.controlEmpaqueTable}(${DatabaseCreator.empaqueNumeroOrden},${DatabaseCreator.empaqueTotal},${DatabaseCreator.empaqueFecha},${DatabaseCreator.empaqueAprobado},${DatabaseCreator.empaqueRamos},${DatabaseCreator.empaqueDespachar},${DatabaseCreator.empaqueDerogado},${DatabaseCreator.empaqueTallos},${DatabaseCreator.empaqueDesde},${DatabaseCreator.empaqueHasta},${DatabaseCreator.clienteId},${DatabaseCreator.productoId},${DatabaseCreator.postcosechaId},${DatabaseCreator.empaqueMarca},${DatabaseCreator.empaqueRamosRevisar}, ${DatabaseCreator.elite}) 
    VALUES('${empaque.empaqueNumeroOrden}',${empaque.empaqueTotal},'${empaque.empaqueFecha}',${empaque.empaqueAprobado},${empaque.empaqueRamos},${empaque.empaqueDespachar},'${empaque.empaqueDerogado}',${empaque.empaqueTallos},${empaque.empaqueDesde},${empaque.empaqueHasta},${empaque.clienteId},${empaque.productoId},${empaque.postcosechaId},'${empaque.empaqueMarca}',${empaque.ramosRevisar}, ${empaque.elite})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateEmpaques(ControlEmpaque empaque) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEmpaqueTable}
    SET ${DatabaseCreator.empaqueNumeroOrden} = '${empaque.empaqueNumeroOrden}',
    ${DatabaseCreator.empaqueTallos} = ${empaque.empaqueTallos},
    ${DatabaseCreator.empaqueDerogado} = '${empaque.empaqueDerogado}',
    ${DatabaseCreator.empaqueDespachar} = ${empaque.empaqueDespachar},
    ${DatabaseCreator.empaqueRamos} = ${empaque.empaqueRamos},
    ${DatabaseCreator.empaqueHasta} = ${empaque.empaqueHasta},
    ${DatabaseCreator.empaqueTotal} = ${empaque.empaqueTotal},
    ${DatabaseCreator.clienteId} = ${empaque.clienteId},
    ${DatabaseCreator.productoId} = ${empaque.productoId},
    ${DatabaseCreator.postcosechaId} =${empaque.postcosechaId},
    ${DatabaseCreator.empaqueMarca} ='${empaque.empaqueMarca}',
    ${DatabaseCreator.empaqueRamosRevisar} = ${empaque.ramosRevisar}
    WHERE ${DatabaseCreator.controlEmpaqueId} = ${empaque.controlEmpaqueId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> finEmpaques(ControlEmpaque empaque) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEmpaqueTable}
    SET ${DatabaseCreator.empaqueAprobado} = ${empaque.empaqueAprobado},
    ${DatabaseCreator.empaqueHasta} = ${empaque.empaqueHasta}
    WHERE ${DatabaseCreator.controlEmpaqueId} = ${empaque.controlEmpaqueId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<int> addEmpaque(int controlEmpaqueId, Empaque empaque) async {
    final sql = '''INSERT INTO ${DatabaseCreator.empaqueTable} 
    (${DatabaseCreator.controlEmpaqueId},
    ${DatabaseCreator.variedad},${DatabaseCreator.numeroMesa},${DatabaseCreator.linea},${DatabaseCreator.codigoEmpacador})
    VALUES(${controlEmpaqueId},'${empaque.variedad}','${empaque.numeroMesa}','${empaque.linea}','${empaque.codigoEmpacador}')''';
    return await db.rawInsert(sql);
  }

  static Future<List<Empaque>> getAllEmpaque(int controlEmpaqueId) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.empaqueTable} WHERE ${DatabaseCreator.controlEmpaqueId} = $controlEmpaqueId''';
    final data = await db.rawQuery(sql);
    List<Empaque> empaques = List();
    for (final node in data) {
      final sql1 =
          '''SELECT count(*) as FALENCIAS,MIN(${DatabaseCreator.falenciaEmpaqueId}) AS FALENCIA_ID FROM ${DatabaseCreator.falenciasReporteEmpaqueTable} WHERE ${DatabaseCreator.empaqueId} = ${node[DatabaseCreator.empaqueId]}''';
      final data1 = await db.rawQuery(sql1);

      final sql2 =
          '''SELECT * FROM ${DatabaseCreator.falenciaEmpaqueTable} WHERE ${DatabaseCreator.falenciaEmpaqueId} = ${data1[0]['FALENCIA_ID']}''';
      final data2 = await db.rawQuery(sql2);

      empaques.add(new Empaque(
          empaqueId: node[DatabaseCreator.empaqueId],
          controlEmpaqueId: node[DatabaseCreator.controlEmpaqueId],
          cantidadFalencias: data1[0]['FALENCIAS'],
          numeroMesa: node[DatabaseCreator.numeroMesa],
          variedad: node[DatabaseCreator.variedad],
          linea: node[DatabaseCreator.linea],
          codigoEmpacador: node[DatabaseCreator.codigoEmpacador],
          tipo: data2[0][DatabaseCreator.falenciaEmpaqueNombre]
              .toString()
              .substring(0, 1)));
    }
    return empaques;
  }

  static Future<void> deleteEmpaque(int empaqueId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.falenciasReporteEmpaqueTable} WHERE ${DatabaseCreator.empaqueId} = $empaqueId''';
    await db.rawDelete(sql0);
    final sql =
        '''DELETE FROM ${DatabaseCreator.empaqueTable} WHERE ${DatabaseCreator.empaqueId} = $empaqueId''';
    await db.rawDelete(sql);
  }
}
