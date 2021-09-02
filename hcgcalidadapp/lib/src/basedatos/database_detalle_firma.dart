import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/detalleFirma.dart';

class DatabaseDetalleFirma {
  static Future<int> addDetalleFirma(DetalleFirma detalleFirma) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.detalleFirmaTable}(${DatabaseCreator.detalleFirmaCodigo},${DatabaseCreator.detalleFirmaIdFk}) 
    VALUES('${detalleFirma.detalleFirmaCodigo}','${detalleFirma.firmaId}')''';
    return await db.rawInsert(sql);
  }

  static Future<List<DetalleFirma>> consultarDetallesFirmaEmp() async {
    final sql = '''
      SELECT ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
      FROM ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlEmpaqueTable}
      WHERE ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.detalleFirmaId}
      AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 2
      GROUP BY ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
    ''';
    final data = await db.rawQuery(sql);
    List<DetalleFirma> detalleFirma = new List<DetalleFirma>();
    detalleFirma = data
        .map((e) => DetalleFirma(
            detalleFirmaId: e[DatabaseCreator.detalleFirmaId],
            detalleFirmaCodigo: e[DatabaseCreator.detalleFirmaCodigo],
            firmaId: e[DatabaseCreator.firmaId]))
        .toList();
    return detalleFirma;
  }

  static Future<List<DetalleFirma>> consultarDetallesFirmaRam() async {
    final sql = '''
      SELECT ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      FROM ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlRamosTable} 
      WHERE ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 2 
      GROUP BY ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
    ''';
    final data = await db.rawQuery(sql);
    List<DetalleFirma> detalleFirma = new List<DetalleFirma>();
    detalleFirma = data
        .map((e) => DetalleFirma(
            detalleFirmaId: e[DatabaseCreator.detalleFirmaId],
            detalleFirmaCodigo: e[DatabaseCreator.detalleFirmaCodigo],
            firmaId: e[DatabaseCreator.firmaId]))
        .toList();

    return detalleFirma;
  }

  static Future<List<DetalleFirma>>
      consultarDetallesFirmaProcesoMaritimo() async {
    final sql = '''
      SELECT ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      FROM ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.procesoMaritimoTable} 
      WHERE ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.procesoMaritimoTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.procesoMaritimoTable}.${DatabaseCreator.procesoMaritimoEstado} = 2 
      GROUP BY ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
    ''';
    final data = await db.rawQuery(sql);
    List<DetalleFirma> detalleFirma = new List<DetalleFirma>();
    detalleFirma = data
        .map((e) => DetalleFirma(
            detalleFirmaId: e[DatabaseCreator.detalleFirmaId],
            detalleFirmaCodigo: e[DatabaseCreator.detalleFirmaCodigo],
            firmaId: e[DatabaseCreator.firmaId]))
        .toList();
    return detalleFirma;
  }

  static Future<List<DetalleFirma>>
      consultarDetallesFirmaProcesoMaritimoAlstroemeria() async {
    final sql = '''
      SELECT ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      FROM ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.procesoMaritimoAlstroemeriaTable} 
      WHERE ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}.${DatabaseCreator.procesoMaritimoAlstroemeriaEstado} = 2 
      GROUP BY ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
    ''';
    final data = await db.rawQuery(sql);
    List<DetalleFirma> detalleFirma = new List<DetalleFirma>();
    detalleFirma = data
        .map((e) => DetalleFirma(
            detalleFirmaId: e[DatabaseCreator.detalleFirmaId],
            detalleFirmaCodigo: e[DatabaseCreator.detalleFirmaCodigo],
            firmaId: e[DatabaseCreator.firmaId]))
        .toList();
    return detalleFirma;
  }

  static Future<List<DetalleFirma>> consultarDetallesFirmaBanda() async {
    final sql = '''
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

    final data = await db.rawQuery(sql);

    List<DetalleFirma> detalleFirma = new List<DetalleFirma>();

    detalleFirma = data
        .map((e) => DetalleFirma(
            detalleFirmaId: e[DatabaseCreator.detalleFirmaId],
            detalleFirmaCodigo: e[DatabaseCreator.detalleFirmaCodigo],
            firmaId: e[DatabaseCreator.firmaId]))
        .toList();
    return detalleFirma;
  }
}
