
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';

class DatabaseFirma{

  static Future<int> addFirma(Firma firma) async {
    final sql =
    '''INSERT INTO ${DatabaseCreator.firmaTable}(${DatabaseCreator.firmaId},${DatabaseCreator.firmaCodigo},${DatabaseCreator.firmaNombre},${DatabaseCreator.firmaCargo},${DatabaseCreator.firmaCorreo}) 
    VALUES(${firma.firmaId},'${firma.firmaCodigo}','${firma.firmaNombre}','${firma.firmaCargo}','${firma.firmaCorreo}')''';
    return await db.rawInsert(sql);
  }
  static Future<int> updateFirma(Firma firma) async {
    final sql = '''UPDATE ${DatabaseCreator.firmaTable}
    SET ${DatabaseCreator.firmaNombre} = '${firma.firmaNombre}',
    ${DatabaseCreator.firmaCargo} = '${firma.firmaCargo}',
    ${DatabaseCreator.firmaCodigo} = '${firma.firmaCodigo}',
    ${DatabaseCreator.firmaCorreo} = '${firma.firmaCorreo}'
    WHERE ${DatabaseCreator.firmaId} == ${firma.firmaId}
    ''';

    await db.rawUpdate(sql);
  }

  static firmarReportes(int detalleFirmaId)async {
    final sql =
    '''UPDATE ${DatabaseCreator.controlRamosTable}
    SET ${DatabaseCreator.ramosAprobado} = 2,
    ${DatabaseCreator.detalleFirmaId} = $detalleFirmaId
    WHERE ${DatabaseCreator.ramosAprobado} = 1
    ''';
    await db.rawUpdate(sql);
    final sqlE =
    '''UPDATE ${DatabaseCreator.controlEmpaqueTable}
    SET ${DatabaseCreator.empaqueAprobado} = 2,
    ${DatabaseCreator.detalleFirmaId} = $detalleFirmaId
    WHERE ${DatabaseCreator.empaqueAprobado} = 1
    ''';
    await db.rawUpdate(sqlE);
    final sqlB =
    '''UPDATE ${DatabaseCreator.controlBandaTable}
    SET ${DatabaseCreator.ramosAprobado} = 2,
    ${DatabaseCreator.detalleFirmaId} = $detalleFirmaId
    WHERE ${DatabaseCreator.ramosAprobado} = 1
    ''';
    await db.rawUpdate(sqlB);
    final sqlA =
    '''UPDATE ${DatabaseCreator.controlEcuadorTable}
    SET ${DatabaseCreator.ramosAprobado} = 2,
    ${DatabaseCreator.detalleFirmaId} = $detalleFirmaId
    WHERE ${DatabaseCreator.ramosAprobado} = 1
    ''';
    await db.rawUpdate(sqlA);
  }
  static borrarReportesRamos(int reporteId)async {
    final sql =
    '''UPDATE ${DatabaseCreator.controlRamosTable}
    SET ${DatabaseCreator.ramosAprobado} = 10
    WHERE ${DatabaseCreator.controlRamosId} = $reporteId
    ''';
    await db.rawUpdate(sql);
  }

  static borrarReportesBanda(int reporteId)async {
    final sql =
    '''UPDATE ${DatabaseCreator.controlBandaTable}
    SET ${DatabaseCreator.ramosAprobado} = 10
    WHERE ${DatabaseCreator.controlRamosId} = $reporteId
    ''';
    await db.rawUpdate(sql);
  }

  static borrarReportesEmpaque(int reporteId)async {

    final sqlE =
    '''UPDATE ${DatabaseCreator.controlEmpaqueTable}
    SET ${DatabaseCreator.empaqueAprobado} = 10
    WHERE ${DatabaseCreator.controlEmpaqueId} = $reporteId
    ''';
    await db.rawUpdate(sqlE);
  }
  static reintReportesRamos(int reporteId)async {
    final sql =
    '''UPDATE ${DatabaseCreator.controlRamosTable}
    SET ${DatabaseCreator.ramosAprobado} = 2
    WHERE ${DatabaseCreator.controlRamosId} = $reporteId
    ''';
    await db.rawUpdate(sql);
  }
  static reintReportesEmpaque(int reporteId)async {

    final sqlE =
    '''UPDATE ${DatabaseCreator.controlEmpaqueTable}
    SET ${DatabaseCreator.empaqueAprobado} = 2
    WHERE ${DatabaseCreator.controlEmpaqueId} = $reporteId
    ''';
    await db.rawUpdate(sqlE);
  }
  static Future<List<Firma>> consultarFirmas() async{
    final sql =
    '''
      SELECT *
      FROM ${DatabaseCreator.firmaTable}
    ''';
    final data = await db.rawQuery(sql);
    List<Firma> firmas = new List<Firma>();
    for(var firma in data){
      Firma firmaNew = new Firma();

      firmaNew.firmaId = firma[DatabaseCreator.firmaId];
      firmaNew.firmaCodigo = firma[DatabaseCreator.firmaCodigo];
      firmaNew.firmaCargo = firma[DatabaseCreator.firmaCargo];
      firmaNew.firmaNombre = firma[DatabaseCreator.firmaNombre];
      firmaNew.firmaCorreo = firma[DatabaseCreator.firmaCorreo];
      firmas.add(firmaNew);
    }

    return firmas;
  }
  static Future<List<Firma>> consultarFirmasEmpaque() async{
    final sql = 
    '''
      SELECT ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre}
      FROM ${DatabaseCreator.firmaTable}, 
      ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlEmpaqueTable}
      WHERE ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId} = 
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
      AND ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.detalleFirmaId}
      AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 2
      GROUP BY ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre}
    ''';

    final data = await db.rawQuery(sql);
    List<Firma> firmas = new List<Firma>();
    for(var firma in data){
      Firma firmaNew = new Firma();

      firmaNew.firmaId = firma[DatabaseCreator.firmaId];
      firmaNew.firmaCodigo = firma[DatabaseCreator.firmaCodigo];
      firmaNew.firmaCargo = firma[DatabaseCreator.firmaCargo];
      firmaNew.firmaNombre = firma[DatabaseCreator.firmaNombre];
      firmaNew.firmaCorreo = firma[DatabaseCreator.firmaCorreo];
      firmas.add(firmaNew);
    }

    return firmas;
  }

  static Future<List<Firma>> consultarFirmasRamo() async{
    final sql =
    '''
      SELECT ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre} 
      FROM ${DatabaseCreator.firmaTable}, 
      ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlRamosTable} 
      WHERE ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId} = 
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      AND ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 2 
      GROUP BY ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre}
    ''';
    final data = await db.rawQuery(sql);
    List<Firma> firmas = [];
    for(var firma in data){
      Firma firmaNew = new Firma();

      firmaNew.firmaId = firma[DatabaseCreator.firmaId];
      firmaNew.firmaCodigo = firma[DatabaseCreator.firmaCodigo];
      firmaNew.firmaCargo = firma[DatabaseCreator.firmaCargo];
      firmaNew.firmaNombre = firma[DatabaseCreator.firmaNombre];
      firmaNew.firmaCorreo = firma[DatabaseCreator.firmaCorreo];
      firmas.add(firmaNew);
    }

    return firmas;
  }
}