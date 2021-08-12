import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_ramos.dart';

class DatabaseFalenciaRamos {
  static Future<List<FalenciaRamos>> getAllFalenciaRamos() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.falenciaRamosTable} ''';
    final data = await db.rawQuery(sql);
    List<FalenciaRamos> falenciasRamos = List();
    for (final node in data) {
      falenciasRamos.add(new FalenciaRamos(
          falenciaRamosId: node[DatabaseCreator.falenciaRamosId],
          falenciaRamosNombre: node[DatabaseCreator.falenciaRamosNombre],
          categoriaRamosId: node[DatabaseCreator.categoriaRamosId]));
    }
    return falenciasRamos;
  }

  static Future<int> addFalenciaRamos(FalenciaRamos falenciaRamos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.falenciaRamosTable}(${DatabaseCreator.falenciaRamosId},
    ${DatabaseCreator.falenciaRamosNombre},${DatabaseCreator.categoriaRamosId},${DatabaseCreator.elite}) 
    VALUES(${falenciaRamos.falenciaRamosId},'${falenciaRamos.falenciaRamosNombre}',
    ${falenciaRamos.categoriaRamosId},${falenciaRamos.elite})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateFalenciaRamos(FalenciaRamos falenciaRamos) async {
    final sql = '''UPDATE ${DatabaseCreator.falenciaRamosTable}
    SET ${DatabaseCreator.falenciaRamosNombre} = '${falenciaRamos.falenciaRamosNombre}',
    ${DatabaseCreator.categoriaRamosId} = ${falenciaRamos.categoriaRamosId},
    ${DatabaseCreator.elite} = ${falenciaRamos.elite}
    WHERE ${DatabaseCreator.falenciaRamosId} == ${falenciaRamos.falenciaRamosId}
    ''';
    await db.rawUpdate(sql);
  }
}
