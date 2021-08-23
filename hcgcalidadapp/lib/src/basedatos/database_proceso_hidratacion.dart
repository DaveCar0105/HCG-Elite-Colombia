import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';

class DatabaseProcesoHidratacion {
  static Future<List<ProcesoHidratacion>> getAllProcesosHidratacion() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.procesoHidratacionTable}';
    final data = await db.rawQuery(sql);
    List<ProcesoHidratacion> productos = List();
    for (final node in data) {
      productos.add(new ProcesoHidratacion(
          procesoHidratacionId: node[DatabaseCreator.procesoHidratacionId],
          procesoHidratacionUsuarioControlId:
              node[DatabaseCreator.procesoHidratacionUsuarioControlId],
          procesoHidratacionEstadoSoluciones:
              node[DatabaseCreator.procesoHidratacionEstadoSoluciones],
          procesoHidratacionTiemposHidratacion:
              node[DatabaseCreator.procesoHidratacionTiemposHidratacion],
          procesoHidratacionCantidadRamos:
              node[DatabaseCreator.procesoHidratacionCantidadRamos],
          procesoHidratacionPhSolucion: (double.parse(
                  node[DatabaseCreator.procesoHidratacionPhSolucion]
                      .toString()) ??
              0.0),
          procesoHidratacionNivelSolucion: (double.parse(
                  node[DatabaseCreator.procesoHidratacionNivelSolucion]
                      .toString()) ??
              0.0),
          procesoHidratacionFecha:
              DateTime.parse(node[DatabaseCreator.procesoHidratacionFecha]),
          postcosechaId: node[DatabaseCreator.postcosechaId]));
    }
    return productos;
  }

  static Future<int> getCountProcesosHidratacion() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.procesoHidratacionTable}';
    final data = await db.rawQuery(sql);

    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addProcesosHidratacion(
      ProcesoHidratacion procesoHidratacion) async {
    final sql = '''INSERT INTO ${DatabaseCreator.procesoHidratacionTable}
    (${DatabaseCreator.procesoHidratacionUsuarioControlId},${DatabaseCreator.procesoHidratacionEstadoSoluciones},${DatabaseCreator.procesoHidratacionTiemposHidratacion},
    ${DatabaseCreator.procesoHidratacionCantidadRamos},${DatabaseCreator.procesoHidratacionPhSolucion},${DatabaseCreator.procesoHidratacionNivelSolucion},${DatabaseCreator.procesoHidratacionFecha},${DatabaseCreator.postcosechaId})
    VALUES(${procesoHidratacion.procesoHidratacionUsuarioControlId},${procesoHidratacion.procesoHidratacionEstadoSoluciones},${procesoHidratacion.procesoHidratacionTiemposHidratacion},
    ${procesoHidratacion.procesoHidratacionCantidadRamos},${procesoHidratacion.procesoHidratacionPhSolucion},${procesoHidratacion.procesoHidratacionNivelSolucion},'${procesoHidratacion.procesoHidratacionFecha}',${procesoHidratacion.postcosechaId})''';
    return await db.rawInsert(sql);
  }
}
