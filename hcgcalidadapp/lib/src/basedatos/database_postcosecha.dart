import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/postcosecha.dart';

class DatabasePostcosecha{
  static Future<List<PostCosecha>> getAllPostcosecha(int valor) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.postcosechaTable} WHERE ${DatabaseCreator.elite} = $valor''';
    final data =  await  db.rawQuery(sql);
    List<PostCosecha> postcosechas = List();
    for(final node in data){
      postcosechas.add(new PostCosecha(
          postCosechaId: node[DatabaseCreator.postcosechaId],
          postCosechaNombre: node[DatabaseCreator.postcosechaNombre]
      ));
    }
    return postcosechas;
  }
  static Future<int> addPostcosecha(PostCosecha postCosecha) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.postcosechaTable}(${DatabaseCreator.postcosechaId},${DatabaseCreator.postcosechaNombre},${DatabaseCreator.elite}) 
    VALUES(${postCosecha.postCosechaId},'${postCosecha.postCosechaNombre}',${postCosecha.elite})''';
    return await db.rawInsert(sql);
  }



  static Future<void> updatePostcosecha(PostCosecha postCosecha) async {
    final sql = '''UPDATE ${DatabaseCreator.postcosechaTable}
    SET ${DatabaseCreator.postcosechaNombre} = '${postCosecha.postCosechaNombre}',
    ${DatabaseCreator.elite} = ${postCosecha.elite}
    WHERE ${DatabaseCreator.postcosechaId} == ${postCosecha.postCosechaId}
    ''';

    await db.rawUpdate(sql);
  }

}