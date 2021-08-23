import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/error.dart';

class DatabaseError {
  static Future<List<ErrorT>> getAllErrores() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.errorTable} ''';
    final data = await db.rawQuery(sql);
    List<ErrorT> errores = List();
    for (final node in data) {
      errores.add(new ErrorT(
          errorId: node[DatabaseCreator.errorId],
          errorDetalle: node[DatabaseCreator.errorDetalle]));
    }
    return errores;
  }

  static Future<int> addError(ErrorT errorT) async {
    try {
      final sql =
          '''INSERT INTO ${DatabaseCreator.errorTable}(${DatabaseCreator.errorDetalle}) 
      VALUES ('${errorT.errorDetalle}')''';
      print(sql);
      return await db.rawInsert(sql);
    } catch (e) {}
    return 0;
  }
}
