import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_empaque.dart';

class DatabaseFalenciaEmpaque{
  static Future<List<FalenciaEmpaque>> getAllFalenciaEmpaque(String tipo) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.falenciaEmpaqueTable} ''';
    final data =  await  db.rawQuery(sql);
    List<FalenciaEmpaque> falenciasEmpaques = List();
    for(final node in data){
      if(node[DatabaseCreator.falenciaEmpaqueNombre].toString().startsWith(tipo)){
        falenciasEmpaques.add(new FalenciaEmpaque(
            falenciaEmpaqueId: node[DatabaseCreator.falenciaEmpaqueId],
            falenciaEmpaqueNombre: node[DatabaseCreator.falenciaEmpaqueNombre],
            categoriaEmpaqueId: node[DatabaseCreator.categoriaEmpaqueId]
        ));
      }

    }
    return falenciasEmpaques;
  }
  static Future<int> addFalenciaEmpaque(FalenciaEmpaque falenciaEmpaque) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.falenciaEmpaqueTable}(${DatabaseCreator.falenciaEmpaqueId},${DatabaseCreator.falenciaEmpaqueNombre},${DatabaseCreator.categoriaEmpaqueId},${DatabaseCreator.elite}) 
    VALUES(${falenciaEmpaque.falenciaEmpaqueId},'${falenciaEmpaque.falenciaEmpaqueNombre}',${falenciaEmpaque.categoriaEmpaqueId},${falenciaEmpaque.elite})''';
    return await db.rawInsert(sql);
  }



  static Future<void> updateFalenciaEmpaque(FalenciaEmpaque falenciaEmpaque) async {
    final sql = '''UPDATE ${DatabaseCreator.falenciaEmpaqueTable}
    SET ${DatabaseCreator.falenciaEmpaqueNombre} = '${falenciaEmpaque.falenciaEmpaqueNombre}',
    ${DatabaseCreator.categoriaEmpaqueId} = ${falenciaEmpaque.categoriaEmpaqueId},
    ${DatabaseCreator.elite} = ${falenciaEmpaque.elite}
    WHERE ${DatabaseCreator.falenciaEmpaqueId} == ${falenciaEmpaque.falenciaEmpaqueId}
    ''';

    await db.rawUpdate(sql);
  }

}