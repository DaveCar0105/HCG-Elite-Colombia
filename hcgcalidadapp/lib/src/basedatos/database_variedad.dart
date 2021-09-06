import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/variedad.dto.dart';

class DatabaseVariedad {
  static Future<List<VariedadDto>> getAllVariedades() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.variedadTable} ''';
    final data = await db.rawQuery(sql);
    List<VariedadDto> variedades = List();
    for (final node in data) {
      variedades.add(new VariedadDto(
          variedadId: node[DatabaseCreator.variedadId],
          variedadNombre: node[DatabaseCreator.variedadTableNombre]));
    }
    return variedades;
  }

  static Future<int> addVariedad(VariedadDto variedad) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.variedadTable}(${DatabaseCreator.variedadId},${DatabaseCreator.variedadTableNombre}) 
    VALUES(${variedad.variedadId},'${variedad.variedadNombre}')''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateVariedad(VariedadDto variedad) async {
    final sql = '''UPDATE ${DatabaseCreator.variedadTable}
    SET ${DatabaseCreator.variedadTableNombre} = '${variedad.variedadNombre}'
    WHERE ${DatabaseCreator.variedadId} == ${variedad.variedadId}
    ''';
    await db.rawUpdate(sql);
  }
}
