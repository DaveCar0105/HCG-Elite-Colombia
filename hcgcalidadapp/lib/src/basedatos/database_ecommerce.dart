import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/control_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/problema_ecommerce.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class DatabaseEcommerce {
  static Future<List<Map<String, dynamic>>> getAllEcommerceSincro() async {
    Preferences pref = Preferences();
    List<Map<String, dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlEcommerceTable} 
    WHERE ${DatabaseCreator.ramosAprobado} = 1''';
    final data = await db.rawQuery(sql);

    for (final node in data) {
      Map<String, dynamic> item = new Map();
      final sql1 = '''SELECT * 
      FROM ${DatabaseCreator.checkEcommerceTable} 
      WHERE ${DatabaseCreator.controlEcommerceId} = ${node[DatabaseCreator.controlEcommerceId]}''';
      final data1 = await db.rawQuery(sql1);
      List<Map<String, dynamic>> listaFalencias = [];

      for (final fal in data1) {
        Map<String, dynamic> itemFal = Map();
        itemFal = {
          'checkEcommerceId': fal[DatabaseCreator.checkEcommerceId],
          'problemasEcommerceId': fal[DatabaseCreator.problemasEcommerceId],
          'checkEcommerceValor': fal[DatabaseCreator.checkEcommerceValor],
        };

        listaFalencias.add(itemFal);
      }
      item = {
        'controlEcommerceId': node[DatabaseCreator.controlEcommerceId],
        'ecommerceFecha': node[DatabaseCreator.ramosFecha],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'turno': node[DatabaseCreator.turno],
        'usuarioId': pref.userId,
        'ecommerceChecks': listaFalencias
      };

      listaBandas.add(item);
    }
    return listaBandas;
  }

  static Future<void> ecommerceSincronizados() async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcommerceTable}
    SET ${DatabaseCreator.ramosAprobado} = 2
    ''';
    await db.rawInsert(sql);
  }

  static Future<int> addEcommerce(ControlRamos ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.controlEcommerceTable}(${DatabaseCreator.ramosFecha},${DatabaseCreator.ramosAprobado},${DatabaseCreator.postcosechaId},${DatabaseCreator.turno}
    ) 
    VALUES('${ramos.ramosFecha}',${ramos.ramosAprobado},${ramos.postcosechaId},${ramos.elite})''';
    return await db.rawInsert(sql);
  }

  static Future<int> addProblemaEcommerce(
      ProblemaEcommerce problemaEcommerce) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.problemasEcommerceTable}(${DatabaseCreator.problemasEcommerceId},${DatabaseCreator.problemasEcommerceNombre},${DatabaseCreator.problemasEcommerceNumero},${DatabaseCreator.problemasEcommerceTipo}
    ) 
    VALUES(${problemaEcommerce.id},'${problemaEcommerce.nombre}',${problemaEcommerce.numero},${problemaEcommerce.tipo})''';
    return await db.rawInsert(sql);
  }

  static Future<int> updateProblemaEcommerce(
      ProblemaEcommerce problemaEcommerce) async {
    final sql = '''UPDATE ${DatabaseCreator.problemasEcommerceTable} SET 
        ${DatabaseCreator.problemasEcommerceNombre} = '${problemaEcommerce.nombre}',
        ${DatabaseCreator.problemasEcommerceNumero} = ${problemaEcommerce.numero},
        ${DatabaseCreator.problemasEcommerceTipo} = ${problemaEcommerce.tipo}
    WHERE ${DatabaseCreator.problemasEcommerceId} = ${problemaEcommerce.id}
    ''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateEcommerce(ControlRamos ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcommerceTable}
    SET ${DatabaseCreator.postcosechaId} =${ramos.postcosechaId}
    WHERE ${DatabaseCreator.controlEcommerceId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> finEcommerce(ControlRamos ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcommerceTable}
    SET ${DatabaseCreator.ramosAprobado} = ${ramos.ramosAprobado}
    WHERE ${DatabaseCreator.controlEcommerceId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<int> addCheckEcommerce(
      FalenciaReporteRamos falenciaReporteRamos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.checkEcommerceTable}(${DatabaseCreator.checkEcommerceValor},${DatabaseCreator.problemasEcommerceId}) 
    VALUES(${falenciaReporteRamos.falenciasReporteRamosCantidad},${falenciaReporteRamos.falenciaRamosId})''';
    return await db.rawInsert(sql);
  }

  static addProblemas(int id, int valor, problemaId) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.checkEcommerceTable}(${DatabaseCreator.checkEcommerceValor},${DatabaseCreator.problemasEcommerceId},${DatabaseCreator.controlEcommerceId}) 
    VALUES($valor,$problemaId,$id)''';
    return await db.rawInsert(sql);
  }

  static Future<List<ProblemaEcommerce>> getProblemas() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.problemasEcommerceTable}''';
    final data = await db.rawQuery(sql);
    List<ProblemaEcommerce> listaProblema = [];
    for (final node in data) {
      listaProblema.add(new ProblemaEcommerce(
          id: node[DatabaseCreator.problemasEcommerceId],
          numero: node[DatabaseCreator.problemasEcommerceNumero],
          nombre: node[DatabaseCreator.problemasEcommerceNombre]));
    }

    return listaProblema;
  }

  static Future<List<ControlEcommerce>> getAllProblemasXEcommerceId(
      int id) async {
    final sql =
        '''SELECT ${DatabaseCreator.problemasEcommerceTable}.${DatabaseCreator.problemasEcommerceId},
    ${DatabaseCreator.problemasEcommerceTable}.${DatabaseCreator.problemasEcommerceNumero},
    ${DatabaseCreator.problemasEcommerceTable}.${DatabaseCreator.problemasEcommerceNombre},
    ${DatabaseCreator.problemasEcommerceTable}.${DatabaseCreator.problemasEcommerceId},
    ${DatabaseCreator.problemasEcommerceTable}.${DatabaseCreator.problemasEcommerceTipo},
    ${DatabaseCreator.checkEcommerceTable}.${DatabaseCreator.checkEcommerceValor},
    ${DatabaseCreator.checkEcommerceTable}.${DatabaseCreator.checkEcommerceId}
    FROM ${DatabaseCreator.problemasEcommerceTable},${DatabaseCreator.checkEcommerceTable}
    WHERE ${DatabaseCreator.problemasEcommerceTable}.${DatabaseCreator.problemasEcommerceId} = ${DatabaseCreator.checkEcommerceTable}.${DatabaseCreator.problemasEcommerceId}
    AND ${DatabaseCreator.checkEcommerceTable}.${DatabaseCreator.controlEcommerceId} = $id
    ''';
    final data = await db.rawQuery(sql);
    List<ControlEcommerce> listaCheck = [];
    for (final node in data) {
      listaCheck.add(new ControlEcommerce(
          id: node[DatabaseCreator.checkEcommerceId],
          problemaId: node[DatabaseCreator.problemasEcommerceId],
          controlId: id,
          numero: node[DatabaseCreator.problemasEcommerceNumero],
          nombre: node[DatabaseCreator.problemasEcommerceNombre],
          tipo: node[DatabaseCreator.problemasEcommerceTipo],
          cumple: node[DatabaseCreator.checkEcommerceValor] == 1 ? true : false,
          noCumple:
              node[DatabaseCreator.checkEcommerceValor] == 2 ? true : false,
          noAplica:
              node[DatabaseCreator.checkEcommerceValor] == 3 ? true : false));
    }
    return listaCheck;
  }

  static Future<void> updateProblemasXEcommerce(int id, int valor) async {
    final sql = '''UPDATE ${DatabaseCreator.checkEcommerceTable}
    SET ${DatabaseCreator.checkEcommerceValor} = $valor
    WHERE ${DatabaseCreator.checkEcommerceId} = $id
    ''';

    await db.rawUpdate(sql);
  }
}
