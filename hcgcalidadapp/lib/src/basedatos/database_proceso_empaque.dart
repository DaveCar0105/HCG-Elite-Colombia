import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/procesoEmpaque.dart';

class DatabaseProcesoEmpaque{

  static Future<List<ProcesoEmpaques>> getAllProcesosEmpaque() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.procesoEmpaqueTable}';
    final data =  await db.rawQuery(sql);
    List<ProcesoEmpaques> productos = List();
    for(final node in data){
      print(node);
      productos.add(new ProcesoEmpaques(
        procesoEmpaqueId: node[DatabaseCreator.procesoEmpaqueId],
        procesoEmpaqueUsuarioControlId: node[DatabaseCreator.procesoEmpaqueUsuarioControlId],
        procesoEmpaqueAltura: node[DatabaseCreator.procesoEmpaqueAltura],
        procesoEmpaqueCajas: node[DatabaseCreator.procesoEmpaqueCajas],
        procesoEmpaqueSujeccion: node[DatabaseCreator.procesoEmpaqueSujeccion],
        procesoEmpaqueMovimientos: node[DatabaseCreator.procesoEmpaqueMovimientos],
        procesoEmpaqueTemperaturaCuartoFrio: node[DatabaseCreator.procesoEmpaqueTemperaturaCuartoFrio],
        procesoEmpaqueTemperaturaCajas: node[DatabaseCreator.procesoEmpaqueTemperaturaCajas],
        procesoEmpaqueTemperaturaCamion: node[DatabaseCreator.procesoEmpaqueTemperaturaCamion],
        procesoEmpaqueApilamiento: node[DatabaseCreator.procesoEmpaqueApilamiento],
        procesoEmpaqueFecha: DateTime.parse(node[DatabaseCreator.procesoEmpaqueFecha]),
        postcosechaId: node[DatabaseCreator.postcosechaId]
      ));
    }
    return productos;
  }

  static Future<int> getCountProcesosEmpaque() async {
    final sql = 'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.procesoEmpaqueTable}';
    final data =  await db.rawQuery(sql);
    
    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addProcesosEmpaque(ProcesoEmpaques procesoEmpaque) async {
    final sql =
    '''INSERT INTO ${DatabaseCreator.procesoEmpaqueTable}
    (${DatabaseCreator.procesoEmpaqueUsuarioControlId},${DatabaseCreator.procesoEmpaqueAltura},${DatabaseCreator.procesoEmpaqueCajas},
    ${DatabaseCreator.procesoEmpaqueSujeccion},${DatabaseCreator.procesoEmpaqueMovimientos},${DatabaseCreator.procesoEmpaqueTemperaturaCuartoFrio},
    ${DatabaseCreator.procesoEmpaqueTemperaturaCajas},${DatabaseCreator.procesoEmpaqueTemperaturaCamion}, ${DatabaseCreator.procesoEmpaqueFecha},${DatabaseCreator.postcosechaId},${DatabaseCreator.procesoEmpaqueApilamiento})
    VALUES(${procesoEmpaque.procesoEmpaqueUsuarioControlId},${procesoEmpaque.procesoEmpaqueAltura},${procesoEmpaque.procesoEmpaqueCajas},
    ${procesoEmpaque.procesoEmpaqueSujeccion},${procesoEmpaque.procesoEmpaqueMovimientos},${procesoEmpaque.procesoEmpaqueTemperaturaCuartoFrio},
    ${procesoEmpaque.procesoEmpaqueTemperaturaCajas},${procesoEmpaque.procesoEmpaqueTemperaturaCamion},'${procesoEmpaque.procesoEmpaqueFecha}',${procesoEmpaque.postcosechaId},${procesoEmpaque.procesoEmpaqueApilamiento})''';
    return await db.rawInsert(sql);
  }
}