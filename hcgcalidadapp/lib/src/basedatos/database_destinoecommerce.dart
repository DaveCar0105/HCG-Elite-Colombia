import 'package:hcgcalidadapp/src/modelos/control_destinoecommerce.dto.dart';
import 'package:hcgcalidadapp/src/modelos/destino_ecommerce.dto.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_control_destinoEcommerce.dto.dart';

import 'database_creator.dart';

class DatabaseControlDestinoEcommerce {
  static Future<int> addControlDestinoEcommerce(
      ControlDestinoEcommerceDto controlDestinoEcommerce) async {
    final sql = '''INSERT INTO ${DatabaseCreator.controlDestinoEcommerceTable}(
          ${DatabaseCreator.detalleFirmaId},
          ${DatabaseCreator.productoId},
          ${DatabaseCreator.usuarioId},
          ${DatabaseCreator.controlDestinoEcommerceFecha},
          ${DatabaseCreator.controlDestinoEcommerceRevisar},
          ${DatabaseCreator.controlDestinoEcommerceAprobado},
          ${DatabaseCreator.controlDestinoEcommerceTallos},
          ${DatabaseCreator.controlDestinoEcommerceDespachar},
          ${DatabaseCreator.controlDestinoEcommerceCorte1},
          ${DatabaseCreator.controlDestinoEcommerceCorte2},
          ${DatabaseCreator.controlDestinoEcommerceCorte3},
          ${DatabaseCreator.postcosechaId},
          ${DatabaseCreator.variedadId},
          ${DatabaseCreator.controlDestinoEcommerceAccionesTomadas},
          ${DatabaseCreator.controlDestinoEcommerceDesde},
          ${DatabaseCreator.controlDestinoEcommerceHasta},
          ${DatabaseCreator.clienteId}
        ) 
        VALUES(
          ${controlDestinoEcommerce.detalleFirmaId},
          ${controlDestinoEcommerce.productoId},
          ${controlDestinoEcommerce.usuarioId},
          '${controlDestinoEcommerce.controlDestinoEcommerceFecha}',
          ${controlDestinoEcommerce.controlDestinoEcommerceRevisar},
          ${controlDestinoEcommerce.controlDestinoEcommerceAprobado},
          ${controlDestinoEcommerce.controlDestinoEcommerceTallos},
          ${controlDestinoEcommerce.controlDestinoEcommerceDespachar},
          ${controlDestinoEcommerce.controlDestinoEcommerceCorte1},
          ${controlDestinoEcommerce.controlDestinoEcommerceCorte2},
          ${controlDestinoEcommerce.controlDestinoEcommerceCorte3},
          ${controlDestinoEcommerce.postcosechaId},
          ${controlDestinoEcommerce.variedadId},
          '${controlDestinoEcommerce.controlDestinoEcommerceAccionesTomadas}',
          ${controlDestinoEcommerce.controlDestinoEcommerceDesde},
          ${controlDestinoEcommerce.controlDestinoEcommerceHasta},
          ${controlDestinoEcommerce.clienteId}
        )''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateControlDestinoEcommerce(
      ControlDestinoEcommerceDto controlDestinoEcommerce) async {
    final sql = '''UPDATE ${DatabaseCreator.controlDestinoEcommerceTable} SET 
    ${DatabaseCreator.productoId} = ${controlDestinoEcommerce.productoId},
    ${DatabaseCreator.controlDestinoEcommerceRevisar} = ${controlDestinoEcommerce.controlDestinoEcommerceRevisar},
    ${DatabaseCreator.controlDestinoEcommerceTallos} = ${controlDestinoEcommerce.controlDestinoEcommerceTallos},
    ${DatabaseCreator.controlDestinoEcommerceDespachar} = ${controlDestinoEcommerce.controlDestinoEcommerceDespachar},
    ${DatabaseCreator.controlDestinoEcommerceCorte1} = ${controlDestinoEcommerce.controlDestinoEcommerceCorte1},
    ${DatabaseCreator.controlDestinoEcommerceCorte2} = ${controlDestinoEcommerce.controlDestinoEcommerceCorte2},
    ${DatabaseCreator.controlDestinoEcommerceCorte3} = ${controlDestinoEcommerce.controlDestinoEcommerceCorte3},
    ${DatabaseCreator.postcosechaId} = ${controlDestinoEcommerce.postcosechaId},
    ${DatabaseCreator.variedadId} = ${controlDestinoEcommerce.variedadId},
    ${DatabaseCreator.clienteId} = ${controlDestinoEcommerce.clienteId}
    WHERE ${DatabaseCreator.controlDestinoEcommerceId} = ${controlDestinoEcommerce.controlDestinoEcommerceId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<List<DestinoEcommerceDetalleFalenciaDto>>
      getAllDestinosEcommerceByControlDestinoEcommerceId(int id) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.destinoEcommerceTable} WHERE ${DatabaseCreator.controlDestinoEcommerceId} = $id''';
    final data = await db.rawQuery(sql);
    List<DestinoEcommerceDetalleFalenciaDto> destinosEcommerce = List();
    for (final node in data) {
      final sql1 =
          '''SELECT count(*) as FALENCIAS FROM ${DatabaseCreator.falenciasControlDestinoEcommerceTable} WHERE ${DatabaseCreator.destinoEcommerceId} = ${node[DatabaseCreator.destinoEcommerceId]}''';
      final data1 = await db.rawQuery(sql1);
      destinosEcommerce.add(new DestinoEcommerceDetalleFalenciaDto(
          destinoEcommerceId: node[DatabaseCreator.destinoEcommerceId],
          controlDestinoEcommerceId:
              node[DatabaseCreator.controlDestinoEcommerceId],
          cantidadFalencias: data1[0]['FALENCIAS']));
    }
    return destinosEcommerce;
  }

  static Future<int> addDestinoEcommerce(int controlDestinoEcommerceId,
      DestinoEcommerceDto destinoEcommerce) async {
    final sql = '''INSERT INTO ${DatabaseCreator.destinoEcommerceTable} (
      ${DatabaseCreator.controlDestinoEcommerceId}
    ) VALUES(
      ${controlDestinoEcommerceId}
    )''';
    return await db.rawInsert(sql);
  }

  static Future<int> addFalenciaReporteDestinoEcommerce(
      FalenciaReporteDestinoEcommerce falenciaReporteDestinoEcommerce) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.falenciasControlDestinoEcommerceTable}(
      ${DatabaseCreator.falenciaRamosId},
      ${DatabaseCreator.destinoEcommerceId},
      ${DatabaseCreator.falenciasControlDestinoEcommerceCantidad}
    ) VALUES(
      ${falenciaReporteDestinoEcommerce.falenciaRamosId},
      ${falenciaReporteDestinoEcommerce.destinoEcommerceId},
      ${falenciaReporteDestinoEcommerce.falenciasControlDestinoEcommerceCantidad}
    )''';
    return await db.rawInsert(sql);
  }

  static Future<List<FalenciaReporteDestinoEcommerce>>
      getAllFalenciasByDestinoEcommerceId(int id) async {
    final sql = '''SELECT 
    ${DatabaseCreator.falenciasControlDestinoEcommerceTable}.${DatabaseCreator.falenciasControlDestinoEcommerceId},
    ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}, 
    ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId},
    ${DatabaseCreator.falenciasControlDestinoEcommerceTable}.${DatabaseCreator.falenciasControlDestinoEcommerceCantidad}
    FROM
    ${DatabaseCreator.falenciasControlDestinoEcommerceTable},
    ${DatabaseCreator.falenciaRamosTable}
    WHERE 
    ${DatabaseCreator.falenciasControlDestinoEcommerceTable}.${DatabaseCreator.destinoEcommerceId} =$id
    AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasControlDestinoEcommerceTable}.${DatabaseCreator.falenciaRamosId}
    ''';
    final data = await db.rawQuery(sql);
    List<FalenciaReporteDestinoEcommerce> falenciaReporteDestinos = List();
    for (final node in data) {
      falenciaReporteDestinos.add(new FalenciaReporteDestinoEcommerce(
          destinoEcommerceId: id,
          falenciasControlDestinoEcommerceCantidad:
              node[DatabaseCreator.falenciasControlDestinoEcommerceCantidad],
          falenciasControlDestinoEcommerceId:
              node[DatabaseCreator.falenciasControlDestinoEcommerceId],
          falenciaRamosId: node[DatabaseCreator.falenciaRamosId],
          falenciaRamosNombre: node[DatabaseCreator.falenciaRamosNombre]));
    }
    return falenciaReporteDestinos;
  }

  static Future<void> deleteDestinoEcommerce(int destinoEcommerceId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.falenciasControlDestinoEcommerceTable} 
    WHERE ${DatabaseCreator.destinoEcommerceId} = $destinoEcommerceId''';
    await db.rawDelete(sql0);
    final sql = '''DELETE FROM ${DatabaseCreator.destinoEcommerceTable} 
    WHERE ${DatabaseCreator.destinoEcommerceId} = $destinoEcommerceId''';
    await db.rawDelete(sql);
  }

  static Future<void> deleteFalenciaDestinoEcommerceByFalenciaRamoIdDestinoId(
      int falenciaId, int destinoEcommerceId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.falenciasControlDestinoEcommerceTable} 
    WHERE ${DatabaseCreator.destinoEcommerceId} = $destinoEcommerceId AND 
    ${DatabaseCreator.falenciaRamosId} = $falenciaId''';
    await db.rawDelete(sql0);
  }

  static Future<void> updateControlDestinoEcommerceAprobado(
      ControlDestinoEcommerceDto controlDestinoEcommerce) async {
    final sql = '''UPDATE ${DatabaseCreator.controlDestinoEcommerceTable}
    SET ${DatabaseCreator.controlDestinoEcommerceAprobado} = ${controlDestinoEcommerce.controlDestinoEcommerceAprobado},
    ${DatabaseCreator.controlDestinoEcommerceHasta} = ${controlDestinoEcommerce.controlDestinoEcommerceHasta}
    WHERE ${DatabaseCreator.controlDestinoEcommerceId} = ${controlDestinoEcommerce.controlDestinoEcommerceId}
    ''';
    await db.rawInsert(sql);
  }
}
