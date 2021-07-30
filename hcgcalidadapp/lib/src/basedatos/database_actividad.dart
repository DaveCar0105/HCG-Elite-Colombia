import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/actividad.dart';

class DatabaseActividad {
  static Future<List<Actividad>> getAllActividad() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.actividadTable} ''';
    final data = await db.rawQuery(sql);
    List<Actividad> actividades = List();

    for (final node in data) {
      actividades.add(new Actividad(
          actividadId: node[DatabaseCreator.actividadId],
          actividadUsuarioControlId:
              node[DatabaseCreator.actividadUsuarioControlId],
          tipoActividadId: node[DatabaseCreator.actividadTipoId],
          tipoActividadDescripcion:
              node[DatabaseCreator.tipoActividadDescripcion],
          actividadDetalle: node[DatabaseCreator.actividadDetalle],
          actividadHoraInicio: node[DatabaseCreator.actividadHoraInicio],
          actividadHoraFin: node[DatabaseCreator.actividadHoraFin],
          actividadFecha: DateTime.parse(node[DatabaseCreator.actividadFecha]),
          postcosechaId: node[DatabaseCreator.postcosechaId]));
    }
    return actividades;
  }

  static Future<int> getCountActividades() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.actividadTable}';
    final data = await db.rawQuery(sql);

    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addActividad(Actividad actividad) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.actividadTable}(${DatabaseCreator.actividadUsuarioControlId},${DatabaseCreator.actividadDetalle},${DatabaseCreator.actividadHoraInicio},${DatabaseCreator.actividadHoraFin},${DatabaseCreator.actividadFecha},${DatabaseCreator.postcosechaId},${DatabaseCreator.tipoActividadId}) 
    VALUES(${actividad.actividadUsuarioControlId},'${actividad.tipoActividadDescripcion}','${actividad.actividadHoraInicio}','${actividad.actividadHoraFin}','${actividad.actividadFecha}',${actividad.postcosechaId},${actividad.tipoActividadId})''';
    return await db.rawInsert(sql);
  }
}

//TIPO ACTIVIDAD
// class DatabaseTipoActividad{
//   static Future<List<Actividad>> getAllActividad() async {
//     final sql = '''SELECT * FROM ${DatabaseCreator.actividadTable} ''';
//     final data =  await  db.rawQuery(sql);
//     List<Actividad> actividades = List();
//     for(final node in data){
//       actividades.add(new Actividad(
//           actividadId: node[DatabaseCreator.actividadId],
//           actividadUsuarioControlId: node[DatabaseCreator.actividadUsuarioControlId],
//           actividadDetalle: node[DatabaseCreator.actividadDetalle],
//           actividadHoraInicio: node[DatabaseCreator.actividadHoraInicio],
//           actividadHoraFin: node[DatabaseCreator.actividadHoraFin],
//           actividadFecha: DateTime.parse(node[DatabaseCreator.actividadFecha]),
//           postcosechaId: node[DatabaseCreator.postcosechaId]
//       ));
//     }
//     return actividades;
//   }

//   static Future<int> getCountActividades() async {
//     final sql = 'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.actividadTable}';
//     final data =  await db.rawQuery(sql);
    
//     return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
//   }

//   static Future<int> addActividad(Actividad actividad) async {

//     final sql =
//     '''INSERT INTO ${DatabaseCreator.actividadTable}(${DatabaseCreator.actividadUsuarioControlId},${DatabaseCreator.actividadDetalle},${DatabaseCreator.actividadHoraInicio},${DatabaseCreator.actividadHoraFin},${DatabaseCreator.actividadFecha},${DatabaseCreator.postcosechaId}) 
//     VALUES(${actividad.actividadUsuarioControlId},'${actividad.actividadDetalle}','${actividad.actividadHoraInicio}','${actividad.actividadHoraFin}','${actividad.actividadFecha}',${actividad.postcosechaId})''';
//     return await db.rawInsert(sql);
//   }

// }
