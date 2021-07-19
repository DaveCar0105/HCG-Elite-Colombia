import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/cliente.dart';

class DatabaseCliente {
  static Future<List<Cliente>> getAllCliente(int valor) async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.clienteTable} WHERE ${DatabaseCreator.elite}=$valor''';
    final data = await db.rawQuery(sql);
    List<Cliente> clientes = [];
    for (final node in data) {
      clientes.add(new Cliente(
          clienteId: node[DatabaseCreator.clienteId],
          clienteNombre: node[DatabaseCreator.clienteNombre],
          elite: node[DatabaseCreator.elite],
          tipoClienteId: node[DatabaseCreator.tipoClienteId]));
    }
    return clientes;
  }

  static Future<int> addCliente(Cliente cliente) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.clienteTable}(${DatabaseCreator.clienteId},${DatabaseCreator.clienteNombre},${DatabaseCreator.elite},${DatabaseCreator.tipoClienteId}) 
    VALUES(${cliente.clienteId},'${cliente.clienteNombre}',${cliente.elite},${cliente.tipoClienteId})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateCliente(Cliente cliente) async {
    final sql = '''UPDATE ${DatabaseCreator.clienteTable}
    SET ${DatabaseCreator.clienteNombre} = '${cliente.clienteNombre}'
    WHERE ${DatabaseCreator.clienteId} == ${cliente.clienteId}
    ''';

    await db.rawUpdate(sql);
  }
}
