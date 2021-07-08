import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/hidratacion.dart';

class DatabaseHidratacion{
  static Future<List<Hidratacion>> getAllHidratacion() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.hidratacionTable} ''';
    final data =  await  db.rawQuery(sql);
    List<Hidratacion> hidrataciones = List();
    for(final node in data){
      hidrataciones.add(new Hidratacion(
          hidratacionId: node[DatabaseCreator.hidratacionId],
          hidratacionNombre: node[DatabaseCreator.hidratacionNombre]
      ));
    }
    return hidrataciones;
  }
  static Future<int> addHidratacion(Hidratacion hidratacion) async {

    final sql =
    '''INSERT INTO ${DatabaseCreator.hidratacionTable}(${DatabaseCreator.hidratacionId},${DatabaseCreator.hidratacionNombre}) 
    VALUES(${hidratacion.hidratacionId},'${hidratacion.hidratacionNombre}')''';
    return await db.rawInsert(sql);
  }
  static Future<void> updateHidratacion(Hidratacion hidratacion) async {
    final sql = '''UPDATE ${DatabaseCreator.hidratacionTable}
    SET ${DatabaseCreator.hidratacionNombre} = '${hidratacion.hidratacionNombre}'
    WHERE ${DatabaseCreator.hidratacionId} == ${hidratacion.hidratacionId}
    ''';
    await db.rawUpdate(sql);
  }

}