import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';

class DatabaseCirculoCalidad {
  static Future<List<CirculoCalidad>> getAllcirculoCalidad() async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadTable} ''';
    final data = await db.rawQuery(sql);
    List<CirculoCalidad> circulo = List();
    for (final node in data) {
      print(jsonEncode(node));
    }
    return circulo;
  }

  static Future<int> addcirculoCalidad(CirculoCalidad circuloCalidad) async {
    int resultadoRaInsert;
    final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadTable}
        (
        ${DatabaseCreator.postcosechaId},
        ${DatabaseCreator.circuloCalidadRevisados},
        ${DatabaseCreator.circuloCalidadRechazados},
        ${DatabaseCreator.circuloCalidadPorcentajeNoConforme},
        ${DatabaseCreator.circuloCalidadNumeroReunion},
        ${DatabaseCreator.circuloCalidadComentario},
        ${DatabaseCreator.circuloCalidadSupervisor},
        ${DatabaseCreator.circuloCalidadEvaluacionSupervisor},
        ${DatabaseCreator.circuloCalidadSupervisor2},
        ${DatabaseCreator.circuloCalidadEvaluacionSupervisor2},
        ${DatabaseCreator.circuloCalidadFecha}) 
    VALUES(
    ${circuloCalidad.postcosechaId},
    ${circuloCalidad.circuloCalidadRevisados},
    ${circuloCalidad.circuloCalidadRechazados},
    ${circuloCalidad.circuloCalidadPorcentajeNoConforme},
    ${circuloCalidad.circuloCalidadNumeroReunion},
    '${circuloCalidad.circuloCalidadComentario}',
    '${circuloCalidad.circuloCalidadSupervisor}',
    '${circuloCalidad.circuloCalidadEvaluacionSupervisor}',
    '${circuloCalidad.circuloCalidadSupervisor2}',
    '${circuloCalidad.circuloCalidadEvaluacionSupervisor2}',
    '${circuloCalidad.circuloCalidadFecha}'
    )''';
    resultadoRaInsert = await db.rawInsert(sql);
    if (resultadoRaInsert!= null && resultadoRaInsert>0){
      
    }
    return resultadoRaInsert;
  }

  static Future<void> deleteCirculoCalidad(int circuloCaldiadId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.circuloCalidadTable} WHERE ${DatabaseCreator.circuloCalidadId} = $circuloCaldiadId''';
    await db.rawDelete(sql0);
  }
}
