import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/temperatura.dart';

class DatabaseTemperatura {
  static Future<List<Temperatura>> getAllTemperaturas() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.temperaturaTable}';
    final data = await db.rawQuery(sql);
    List<Temperatura> productos = [];
    for (final node in data) {
      print(node);
      productos.add(new Temperatura(
          temperaturaId: node[DatabaseCreator.temperaturaId],
          temperaturaUsuarioControlId:
              node[DatabaseCreator.temperaturaUsuarioControlId],
          temperaturaInterna1:
              (node[DatabaseCreator.temperaturaInterna1] ?? 0.0),
          temperaturaInterna2:
              (node[DatabaseCreator.temperaturaInterna2] ?? 0.0),
          temperatiraInterna3:
              (node[DatabaseCreator.temperaturaInterna3] ?? 0.0),
          temperaturaExterna: (node[DatabaseCreator.temperaturaExterna] ?? 0.0),
          temperaturaFecha:
              DateTime.parse(node[DatabaseCreator.temperaturaFecha]),
          postcosechaId: node[DatabaseCreator.postcosechaId]));
    }
    return productos;
  }

  static Future<int> getCountTemperaturas() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.temperaturaTable}';
    final data = await db.rawQuery(sql);

    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addTemperatura(Temperatura temperatura) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.temperaturaTable}(${DatabaseCreator.temperaturaUsuarioControlId},${DatabaseCreator.temperaturaExterna},${DatabaseCreator.temperaturaInterna1},${DatabaseCreator.temperaturaInterna2},${DatabaseCreator.temperaturaInterna3},${DatabaseCreator.temperaturaFecha},${DatabaseCreator.postcosechaId})
    VALUES(${temperatura.temperaturaUsuarioControlId},${temperatura.temperaturaExterna},${temperatura.temperaturaInterna1},${temperatura.temperaturaInterna2},${temperatura.temperaturaInterna3},'${temperatura.temperaturaFecha}',${temperatura.postcosechaId})''';
    return await db.rawInsert(sql);
  }
}
