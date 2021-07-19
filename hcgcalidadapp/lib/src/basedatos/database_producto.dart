import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/producto.dart';

class DatabaseProducto {
  static Future<List<Producto>> getAllProductos(int valor) async {
    //valor = 1;
    final sql =
        '''SELECT * FROM ${DatabaseCreator.productoTable} WHERE ${DatabaseCreator.elite} = $valor''';
    final data = await db.rawQuery(sql);
    print(sql);
    List<Producto> productos = List();
    for (final node in data) {
      print(jsonEncode(node));
      productos.add(new Producto(
          productoId: node[DatabaseCreator.productoId],
          productoNombre: node[DatabaseCreator.productoNombre]));
    }
    return productos;
  }

  static Future<int> addProducto(Producto producto) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.productoTable}(${DatabaseCreator.productoId},${DatabaseCreator.productoNombre},${DatabaseCreator.elite}) 
    VALUES(${producto.productoId},'${producto.productoNombre}',${producto.elite})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateProducto(Producto producto) async {
    final sql = '''UPDATE ${DatabaseCreator.productoTable}
    SET ${DatabaseCreator.productoNombre} = '${producto.productoNombre}',
    ${DatabaseCreator.elite} = ${producto.elite}
    WHERE ${DatabaseCreator.productoId} == ${producto.productoId}
    ''';

    await db.rawUpdate(sql);
  }
}
