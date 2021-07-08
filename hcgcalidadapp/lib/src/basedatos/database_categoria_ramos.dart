import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_ramos.dart';

class DatabaseCategoriaRamos{
  static Future<List<CategoriaRamos>> getAllCategoriaRamos() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.categoriaRamosTable} ''';
    final data =  await  db.rawQuery(sql);
    List<CategoriaRamos> categoriasRamos = List();
    for(final node in data){
      categoriasRamos.add(new CategoriaRamos(
          categoriaRamosId: node[DatabaseCreator.categoriaRamosId],
          categoriaRamosNombre: node[DatabaseCreator.categoriaRamosNombre]
      ));
    }
    return categoriasRamos;
  }
  static Future<int> addCategoriaRamos(CategoriaRamos categoriaRamos) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.categoriaRamosTable}(${DatabaseCreator.categoriaRamosId},${DatabaseCreator.categoriaRamosNombre}) 
    VALUES(${categoriaRamos.categoriaRamosId},'${categoriaRamos.categoriaRamosNombre}')''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateCategoriaRamos(CategoriaRamos categoriaRamos) async {
    final sql = '''UPDATE ${DatabaseCreator.categoriaRamosTable}
    SET ${DatabaseCreator.categoriaRamosNombre} = '${categoriaRamos.categoriaRamosNombre}'
    WHERE ${DatabaseCreator.categoriaRamosId} == ${categoriaRamos.categoriaRamosId}
    ''';
    await db.rawUpdate(sql);
  }

}