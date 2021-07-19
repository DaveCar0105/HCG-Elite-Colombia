import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/ramo.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';

class DatabaseCirculoCalidad {
  static Future<List<circuloCalidad>> getAllcirculoCalidad() async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.procesoCirculoCalidadTable} ''';
    final data = await db.rawQuery(sql);
    List<circuloCalidad> circulo = List();
    for (final node in data) {
      circulo.add(new circuloCalidad(
          circuloCalidadId: node[DatabaseCreator.procesoCirculoCalidadId],
          ramosRevisados:
              node[DatabaseCreator.procesoCirculoCalidadRamosRevisados],
          ramosRechazados:
              node[DatabaseCreator.procesoCirculoCalidadRamosRechazados],
          calidadReunion: node[DatabaseCreator.procesoCirculoCalidadReunion],
          problemaId1: node[DatabaseCreator.procesoCirculoCalidadProblemaId1],
          problemaId2: node[DatabaseCreator.procesoCirculoCalidadProblemaId2],
          problemaId3: node[DatabaseCreator.procesoCirculoCalidadProblemaId3],
          problemaId4: node[DatabaseCreator.procesoCirculoCalidadProblemaId4],
          problemaId5: node[DatabaseCreator.procesoCirculoCalidadProblemaId5],
          clienteId1: node[DatabaseCreator.procesoCirculoCalidadClienteId1],
          clienteId2: node[DatabaseCreator.procesoCirculoCalidadClienteId2],
          productoId1: node[DatabaseCreator.procesoCirculoCalidadProducto1],
          productoId2: node[DatabaseCreator.procesoCirculoCalidadProducto2],
          variedad1: node[DatabaseCreator.procesoCirculoCalidadVariedad1],
          variedad2: node[DatabaseCreator.procesoCirculoCalidadVariedad2],
          codigoMesa: node[DatabaseCreator.procesoCirculoCalidadCodigoMesa],
          linea: node[DatabaseCreator.procesoCirculoCalidadLinea],
          supervisor1: node[DatabaseCreator.procesoCirculoCalidadSupervisor1],
          supervisor2: node[DatabaseCreator.procesoCirculoCalidadSupervisor2],
          supervisorcheck1:
              node[DatabaseCreator.procesoCirculoCalidadCheckSuperviso1],
          supervisorcheck2:
              node[DatabaseCreator.procesoCirculoCalidadCheckSuperviso2],
          comentarios: node[DatabaseCreator.procesoCirculoCalidadComentarios]));
    }
    return circulo;
  }

  static Future<int> addcirculoCalidad(circuloCalidad circulo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.procesoCirculoCalidadTable}
        (${DatabaseCreator.procesoCirculoCalidadId},
        ${DatabaseCreator.procesoCirculoCalidadPoscosecha},
        ${DatabaseCreator.procesoCirculoCalidadClienteId1},
        ${DatabaseCreator.procesoCirculoCalidadClienteId2},
        ${DatabaseCreator.procesoCirculoCalidadProducto1},
        ${DatabaseCreator.procesoCirculoCalidadProducto2},
        ${DatabaseCreator.procesoCirculoCalidadRamosRevisados},
        ${DatabaseCreator.procesoCirculoCalidadRamosRechazados},
        ${DatabaseCreator.procesoCirculoCalidadProblemaId1},
        ${DatabaseCreator.procesoCirculoCalidadProblemaId2},
        ${DatabaseCreator.procesoCirculoCalidadProblemaId3},
        ${DatabaseCreator.procesoCirculoCalidadProblemaId4},
        ${DatabaseCreator.procesoCirculoCalidadProblemaId5},
        ${DatabaseCreator.procesoCirculoCalidadVariedad1},
        ${DatabaseCreator.procesoCirculoCalidadVariedad2},
        ${DatabaseCreator.procesoCirculoCalidadCodigoMesa},
        ${DatabaseCreator.procesoCirculoCalidadLinea},
        ${DatabaseCreator.procesoCirculoCalidadSupervisor1},
        ${DatabaseCreator.procesoCirculoCalidadSupervisor2},
        ${DatabaseCreator.procesoCirculoCalidadComentarios},
        ${DatabaseCreator.procesoCirculoCalidadCheckSuperviso1},
        ${DatabaseCreator.procesoCirculoCalidadCheckSuperviso2}) 
    VALUES(${circulo.calidadReunion},
    ${circulo.circuloCalidadId},
    ${circulo.postcosechaId},
    '${circulo.clienteId1}',
    '${circulo.clienteId2}',
    ${circulo.productoId1},
    ${circulo.productoId2},
    ${circulo.ramosRevisados},
    ${circulo.ramosRechazados},
    ${circulo.problemaId1},
    '${circulo.problemaId2}'
    ,${circulo.problemaId3},
    '${circulo.problemaId4}',
    ${circulo.problemaId5},
    ${circulo.variedad1},
    ${circulo.variedad2},
    ${circulo.codigoMesa},
    ${circulo.linea},
    ${circulo.supervisor1},
    ${circulo.supervisor2},
    ${circulo.comentarios},
    ${circulo.supervisorcheck1},
    ${circulo.supervisorcheck2}
    )''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateCirculoCalidad(circuloCalidad circulo) async {
    final sql = '''UPDATE ${DatabaseCreator.procesoCirculoCalidadTable}
    SET ${DatabaseCreator.procesoCirculoCalidadReunion} = '${circulo.calidadReunion}',
    ${DatabaseCreator.procesoCirculoCalidadPoscosecha} = '${circulo.postcosechaId}',
    ${DatabaseCreator.procesoCirculoCalidadClienteId1} = ${circulo.clienteId1},
    ${DatabaseCreator.procesoCirculoCalidadClienteId2} = ${circulo.clienteId2},
    ${DatabaseCreator.procesoCirculoCalidadProducto1} = ${circulo.productoId1},
    ${DatabaseCreator.procesoCirculoCalidadProducto2} = ${circulo.productoId2},
    ${DatabaseCreator.procesoCirculoCalidadRamosRevisados} = ${circulo.ramosRevisados},
    ${DatabaseCreator.procesoCirculoCalidadRamosRechazados} = ${circulo.ramosRechazados},
    ${DatabaseCreator.procesoCirculoCalidadProblemaId1} =${circulo.problemaId1},
    ${DatabaseCreator.procesoCirculoCalidadProblemaId2} =${circulo.problemaId2},
    ${DatabaseCreator.procesoCirculoCalidadProblemaId3} =${circulo.problemaId3},
    ${DatabaseCreator.procesoCirculoCalidadProblemaId4} =${circulo.problemaId4},
    ${DatabaseCreator.procesoCirculoCalidadProblemaId5} =${circulo.problemaId5},
    ${DatabaseCreator.procesoCirculoCalidadVariedad1} ='${circulo.variedad1}',
    ${DatabaseCreator.procesoCirculoCalidadVariedad2} ='${circulo.variedad2}',
    ${DatabaseCreator.procesoCirculoCalidadCodigoMesa} ='${circulo.codigoMesa}',
    ${DatabaseCreator.procesoCirculoCalidadLinea} ='${circulo.linea}',
    ${DatabaseCreator.procesoCirculoCalidadSupervisor1} ='${circulo.supervisor1}',
    ${DatabaseCreator.procesoCirculoCalidadSupervisor2} ='${circulo.supervisor2}',
    ${DatabaseCreator.procesoCirculoCalidadComentarios} ='${circulo.comentarios}',
    ${DatabaseCreator.procesoCirculoCalidadCheckSuperviso1} ='${circulo.supervisorcheck1}',
    ${DatabaseCreator.procesoCirculoCalidadCheckSuperviso2} ='${circulo.supervisorcheck2}'
    WHERE ${DatabaseCreator.procesoCirculoCalidadId} = ${circulo.circuloCalidadId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> deleteCirculoCalidad(int circuloCaldiadId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.procesoCirculoCalidadTable} WHERE ${DatabaseCreator.procesoCirculoCalidadId} = $circuloCaldiadId''';
    await db.rawDelete(sql0);
  }
}
