import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_empaque.dart';

class DatabaseFalenciaReporteEmpaque{
  static Future<List<FalenciaReporteEmpaque>> getAllFalenciasXEmpaqueId(int id) async {
    final sql = '''SELECT ${DatabaseCreator.falenciasReporteEmpaqueTable}
    .${DatabaseCreator.falenciasReporteEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}
    .${DatabaseCreator.falenciaEmpaqueNombre}, ${DatabaseCreator.falenciaEmpaqueTable}
    .${DatabaseCreator.falenciaEmpaqueId},${DatabaseCreator.falenciasReporteEmpaqueTable}
    .${DatabaseCreator.falenciasReporteEmpaqueCantidad} 
    FROM 
    ${DatabaseCreator.falenciasReporteEmpaqueTable},
    ${DatabaseCreator.falenciaEmpaqueTable}
    WHERE 
    ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} =$id
    AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
    ''';
    final data =  await  db.rawQuery(sql);
    List<FalenciaReporteEmpaque> falenciaReporteEmpaque = List();
    for(final node in data){
      int total =0;
      if(node[DatabaseCreator.falenciaEmpaqueNombre].toString().substring(0,1)!='C'){
        total = node[DatabaseCreator.empaqueRamosRevisar];
      }
      else{
        total = node[DatabaseCreator.empaqueTotal];
      }
      falenciaReporteEmpaque.add(new FalenciaReporteEmpaque(
          empaqueId: id,
          falenciasReporteEmpaqueCantidad: node[DatabaseCreator.falenciasReporteEmpaqueCantidad],
          falenciasReporteEmpaqueId: node[DatabaseCreator.falenciasReporteEmpaqueId],
          falenciaEmpaqueId: node[DatabaseCreator.falenciaEmpaqueId],
          falenciaEmpaqueNombre :node[DatabaseCreator.falenciaEmpaqueNombre]
      ));
    }
    return falenciaReporteEmpaque;
  }
  static Future<int> addFalenciaReporteEmpaque(FalenciaReporteEmpaque falenciaReporteEmpaque) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.falenciasReporteEmpaqueTable}(${DatabaseCreator.falenciaEmpaqueId},${DatabaseCreator.empaqueId},${DatabaseCreator.falenciasReporteEmpaqueCantidad}) 
    VALUES('${falenciaReporteEmpaque.falenciaEmpaqueId}',${falenciaReporteEmpaque.empaqueId},${falenciaReporteEmpaque.falenciasReporteEmpaqueCantidad})''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateCantidadFalenciaReporteEmpaque(FalenciaReporteEmpaque falenciaReporteEmpaque) async {

    final sql =
    '''UPDATE ${DatabaseCreator.falenciasReporteEmpaqueTable}
    SET ${DatabaseCreator.falenciasReporteEmpaqueCantidad} = ${falenciaReporteEmpaque.falenciasReporteEmpaqueCantidad}
    WHERE ${DatabaseCreator.falenciasReporteEmpaqueId} = ${falenciaReporteEmpaque.falenciasReporteEmpaqueId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> deleteFalenciaReporteEmpaques(int falenciaId,int empaqueId) async {
    final sql0 =
    '''DELETE FROM ${DatabaseCreator.falenciasReporteEmpaqueTable} WHERE ${DatabaseCreator.empaqueId} = $empaqueId AND ${DatabaseCreator.falenciaEmpaqueId} = $falenciaId''';
    await db.rawDelete(sql0);
  }
}