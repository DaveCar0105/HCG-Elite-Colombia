import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/categoria_empaque.dart';

class DatabaseCategoriaEmpaque{
  static Future<List<CategoriaEmpaque>> getAllCategoriaEmpaque() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.categoriaEmpaqueTable} ''';
    final data =  await  db.rawQuery(sql);
    List<CategoriaEmpaque> categoriasEmpaques = List();
    for(final node in data){
      categoriasEmpaques.add(new CategoriaEmpaque(
          categoriaEmpaqueId: node[DatabaseCreator.categoriaEmpaqueId],
          categoriaEmpaqueNombre: node[DatabaseCreator.categoriaEmpaqueNombre]
      ));
    }
    return categoriasEmpaques;
  }
  static Future<int> addCategoriaEmpaque(CategoriaEmpaque categoriaEmpaque) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.categoriaEmpaqueTable}(${DatabaseCreator.categoriaEmpaqueId},${DatabaseCreator.categoriaEmpaqueNombre}) 
    VALUES(${categoriaEmpaque.categoriaEmpaqueId},'${categoriaEmpaque.categoriaEmpaqueNombre}')''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateCategoriaEmpaque(CategoriaEmpaque categoriaEmpaque) async {
    final sql = '''UPDATE ${DatabaseCreator.categoriaEmpaqueTable}
    SET ${DatabaseCreator.categoriaEmpaqueNombre} = '${categoriaEmpaque.categoriaEmpaqueNombre}'
    WHERE ${DatabaseCreator.categoriaEmpaqueId} == ${categoriaEmpaque.categoriaEmpaqueId}
    ''';
    await db.rawUpdate(sql);
  }

}