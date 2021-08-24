import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/destinos.dart';

class DatabaseDestino {
  static Future<List<ProcesoMaritimoDestinos>>
      getAllProcesoMaritimoDestinos() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.procesoMaritimoDestinoTable}';
    final data = await db.rawQuery(sql);
    List<ProcesoMaritimoDestinos> productos = List();
    for (final node in data) {
      productos.add(new ProcesoMaritimoDestinos(
          procesoMaritimoDestinoId:
              node[DatabaseCreator.procesoMaritimoDestinoId],
          procesoMaritimoDestinoNombre:
              node[DatabaseCreator.procesoMaritimoDestinoNombre]));
    }
    return productos;
  }

  static Future<int> getCountProcesoMaritimoDestino() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.procesoMaritimoDestinoTable}';
    final data = await db.rawQuery(sql);

    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addProcesoMaritimoDestinos(
      ProcesoMaritimoDestinos procesoMaritimoDestinos) async {
    final sql = '''INSERT INTO ${DatabaseCreator.procesoMaritimoDestinoTable}
    (${DatabaseCreator.procesoMaritimoDestinoId},${DatabaseCreator.procesoMaritimoDestinoNombre})
    VALUES(${procesoMaritimoDestinos.procesoMaritimoDestinoId},'${procesoMaritimoDestinos.procesoMaritimoDestinoNombre}')''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateProcesoMaritimoDestinos(ProcesoMaritimoDestinos procesoMaritimoDestinos) async {
    final sql = '''UPDATE ${DatabaseCreator.procesoMaritimoDestinoTable}
    SET ${DatabaseCreator.procesoMaritimoDestinoNombre} = '${procesoMaritimoDestinos.procesoMaritimoDestinoNombre}'
    WHERE ${DatabaseCreator.procesoMaritimoDestinoId} == ${procesoMaritimoDestinos.procesoMaritimoDestinoId}
    ''';
    await db.rawUpdate(sql);
  }

}
