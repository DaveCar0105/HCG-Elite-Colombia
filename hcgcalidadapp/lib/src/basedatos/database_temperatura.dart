import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/temperatura.dart';

class DatabaseTemperatura {
  static Future<List<Temperatura>> getAllTemperaturas() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.temperaturaTable}';
    final data = await db.rawQuery(sql);
    List<Temperatura> productos = [];
    for (final node in data) {
      //print(node);
      productos.add(new Temperatura(
          temperaturaId: node[DatabaseCreator.temperaturaId],
          temperaturaUsuarioControlId:
              node[DatabaseCreator.temperaturaUsuarioControlId],
          temperaturaInterna1:
              (double.parse(node[DatabaseCreator.temperaturaInterna1].toString()) ?? 0.0),
          temperaturaInterna2:
              (double.parse(node[DatabaseCreator.temperaturaInterna2].toString()) ?? 0.0),
          temperaturaInterna3:node[DatabaseCreator.temperaturaInterna3]!=null?
              double.parse(node[DatabaseCreator.temperaturaInterna3].toString()) : 0.0,
          temperaturaExterna: (double.parse(node[DatabaseCreator.temperaturaExterna].toString()) ?? 0.0),
          temperaturaFecha:
              DateTime.parse(node[DatabaseCreator.temperaturaFecha]),
          postcosechaId: node[DatabaseCreator.postcosechaId],
          clienteId: node[DatabaseCreator.clienteId])
          );
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
        '''INSERT INTO ${DatabaseCreator.temperaturaTable}(${DatabaseCreator.temperaturaUsuarioControlId},${DatabaseCreator.temperaturaExterna},${DatabaseCreator.temperaturaInterna1},${DatabaseCreator.temperaturaInterna2},${DatabaseCreator.temperaturaInterna3},${DatabaseCreator.temperaturaFecha},${DatabaseCreator.postcosechaId},${DatabaseCreator.clienteId})
    VALUES(${temperatura.temperaturaUsuarioControlId},${temperatura.temperaturaExterna},${temperatura.temperaturaInterna1},${temperatura.temperaturaInterna2},${temperatura.temperaturaInterna3},'${temperatura.temperaturaFecha}',${temperatura.postcosechaId},${temperatura.clienteId})''';
    print(sql);
    return await db.rawInsert(sql);
  }
}
