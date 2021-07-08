import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';

class DatabaseFalenciaReporteRamos{
  static Future<List<FalenciaReporteRamos>> getAllFalenciasXRamosId(int id) async {
    final sql = '''SELECT ${DatabaseCreator.falenciasReporteRamosTable}
    .${DatabaseCreator.falenciasReporteRamosId}, ${DatabaseCreator.falenciaRamosTable}
    .${DatabaseCreator.falenciaRamosNombre}, ${DatabaseCreator.falenciaRamosTable}
    .${DatabaseCreator.falenciaRamosId},${DatabaseCreator.falenciasReporteRamosTable}
    .${DatabaseCreator.falenciasReporteRamosCantidad}
    FROM 
    ${DatabaseCreator.falenciasReporteRamosTable},
    ${DatabaseCreator.falenciaRamosTable}
    WHERE 
    ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} =$id
    AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
    ''';
    final data =  await  db.rawQuery(sql);
    List<FalenciaReporteRamos> falenciaReporteRamos = List();
    for(final node in data){
      falenciaReporteRamos.add(new FalenciaReporteRamos(
          ramosId: id,
          falenciasReporteRamosCantidad: node[DatabaseCreator.falenciasReporteRamosCantidad],
          falenciasReporteRamosId: node[DatabaseCreator.falenciasReporteRamosId],
          falenciaRamosId: node[DatabaseCreator.falenciaRamosId],
          falenciaRamosNombre :node[DatabaseCreator.falenciaRamosNombre],
      ));
    }
    return falenciaReporteRamos;
  }
  static Future<int> addFalenciaReporteRamos(FalenciaReporteRamos falenciaReporteRamos) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.falenciasReporteRamosTable}(${DatabaseCreator.falenciaRamosId},${DatabaseCreator.ramosId},${DatabaseCreator.falenciasReporteRamosCantidad}) 
    VALUES(${falenciaReporteRamos.falenciaRamosId},${falenciaReporteRamos.ramosId},${falenciaReporteRamos.falenciasReporteRamosCantidad})''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateCantidadFalenciaReporteRamos(FalenciaReporteRamos falenciaReporteRamos) async {

    final sql =
    '''UPDATE ${DatabaseCreator.falenciasReporteRamosTable}
    SET ${DatabaseCreator.falenciasReporteRamosCantidad} = ${falenciaReporteRamos.falenciasReporteRamosCantidad}
    WHERE ${DatabaseCreator.falenciasReporteRamosId} = ${falenciaReporteRamos.falenciasReporteRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> deleteFalenciaReporteRamos(int falenciaId,int ramoId) async {
    final sql0 =
    '''DELETE FROM ${DatabaseCreator.falenciasReporteRamosTable} WHERE ${DatabaseCreator.ramosId} = $ramoId AND ${DatabaseCreator.falenciaRamosId} = $falenciaId''';
    await db.rawDelete(sql0);
  }
}