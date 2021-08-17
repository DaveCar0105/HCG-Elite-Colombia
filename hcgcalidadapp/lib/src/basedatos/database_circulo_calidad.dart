import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';

class DatabaseCirculoCalidad {
  static Future<List<CirculoCalidad>> getAllcirculoCalidad() async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadTable} ''';
    final data = await db.rawQuery(sql);
    List<CirculoCalidad> circulo = List();
    for (final node in data) {
      CirculoCalidad circuloCalidad = new CirculoCalidad();
      circuloCalidad.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
      circuloCalidad.circuloCalidadRevisados = node[DatabaseCreator.circuloCalidadRevisados];
      circuloCalidad.circuloCalidadRechazados = node[DatabaseCreator.circuloCalidadRechazados];
      circuloCalidad.circuloCalidadPorcentajeNoConforme = node[DatabaseCreator.circuloCalidadPorcentajeNoConforme];
      circuloCalidad.circuloCalidadNumeroReunion = node[DatabaseCreator.circuloCalidadNumeroReunion];
      circuloCalidad.circuloCalidadComentario = node[DatabaseCreator.circuloCalidadComentario];
      circuloCalidad.circuloCalidadSupervisor = node[DatabaseCreator.circuloCalidadSupervisor];
      circuloCalidad.circuloCalidadEvaluacionSupervisor = node[DatabaseCreator.circuloCalidadEvaluacionSupervisor];
      circuloCalidad.circuloCalidadSupervisor2 = node[DatabaseCreator.circuloCalidadSupervisor2];
      circuloCalidad.circuloCalidadEvaluacionSupervisor2 = node[DatabaseCreator.circuloCalidadEvaluacionSupervisor2];
      circuloCalidad.circuloCalidadFecha = node[DatabaseCreator.circuloCalidadFecha];
      circuloCalidad.postcosechaId = node[DatabaseCreator.postcosechaId];
      circulo.add(circuloCalidad);
    }
    return circulo;
  }

  static Future<List<CirculoCalidadInformacionGeneral>> getAllcirculoCalidadBySincronizar() async {
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadTable} ''';
    final data = await db.rawQuery(sql);
    List<CirculoCalidadInformacionGeneral> circulo = List();
    for (final node in data) {
      CirculoCalidadInformacionGeneral circuloCalidadInformacionGeneral = new CirculoCalidadInformacionGeneral();
      CirculoCalidad circuloCalidad = new CirculoCalidad();
      circuloCalidad.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
      circuloCalidad.circuloCalidadRevisados = node[DatabaseCreator.circuloCalidadRevisados];
      circuloCalidad.circuloCalidadRechazados = node[DatabaseCreator.circuloCalidadRechazados];
      circuloCalidad.circuloCalidadPorcentajeNoConforme = node[DatabaseCreator.circuloCalidadPorcentajeNoConforme];
      circuloCalidad.circuloCalidadNumeroReunion = node[DatabaseCreator.circuloCalidadNumeroReunion];
      circuloCalidad.circuloCalidadComentario = node[DatabaseCreator.circuloCalidadComentario];
      circuloCalidad.circuloCalidadSupervisor = node[DatabaseCreator.circuloCalidadSupervisor];
      circuloCalidad.circuloCalidadEvaluacionSupervisor = node[DatabaseCreator.circuloCalidadEvaluacionSupervisor];
      circuloCalidad.circuloCalidadSupervisor2 = node[DatabaseCreator.circuloCalidadSupervisor2];
      circuloCalidad.circuloCalidadEvaluacionSupervisor2 = node[DatabaseCreator.circuloCalidadEvaluacionSupervisor2];
      circuloCalidad.circuloCalidadFecha = node[DatabaseCreator.circuloCalidadFecha];
      circuloCalidad.postcosechaId = node[DatabaseCreator.postcosechaId];
      circuloCalidadInformacionGeneral.circuloCalidad = circuloCalidad;
      circuloCalidadInformacionGeneral.listaCirculoCalidadProducto = await getCirculoCalidadProductoByCirculoCalidad(circuloCalidad.circuloCalidadId);
      circuloCalidadInformacionGeneral.listaCirculoCalidadCliente = await getCirculoCalidadClienteByCirculoCalidad(circuloCalidad.circuloCalidadId);
      circuloCalidadInformacionGeneral.listaCirculoCalidadFalencia = await getCirculoCalidadFalenciaByCirculoCalidad(circuloCalidad.circuloCalidadId);
      circuloCalidadInformacionGeneral.listaCirculoCalidadVariedad = await getCirculoCalidadVariedadByCirculoCalidad(circuloCalidad.circuloCalidadId);
      circuloCalidadInformacionGeneral.listaCirculoCalidadNumeroMesa = await getCirculoCalidadNumeroMesaByCirculoCalidad(circuloCalidad.circuloCalidadId);
      circuloCalidadInformacionGeneral.listaCirculoCalidadLinea = await getCirculoCalidadLineaByCirculoCalidad(circuloCalidad.circuloCalidadId);
      print(jsonEncode(circuloCalidadInformacionGeneral));
      print("-------------------------------------------------------------------------------------------------------------------------------");
      circulo.add(circuloCalidadInformacionGeneral);
    }
    return circulo;
  }

  static Future<int> addcirculoCalidadByReporteGeneral(ReporteGeneralDto reporteGeneralDto, CirculoCalidad  circuloCalidad) async {
    circuloCalidad.circuloCalidadRevisados = reporteGeneralDto.ramosRevisados;
    circuloCalidad.circuloCalidadRechazados = reporteGeneralDto.ramosNoConformes;
    circuloCalidad.circuloCalidadPorcentajeNoConforme = reporteGeneralDto.porRamosNoConformes;
    var fecha = new DateTime.now();
    circuloCalidad.circuloCalidadFecha = fecha.toString();
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
    if(resultadoRaInsert>0){
      try{
        addcirculoCalidadProducto(reporteGeneralDto.productos, resultadoRaInsert);
        addcirculoCalidadCliente(reporteGeneralDto.clientes, resultadoRaInsert);
        addcirculoCalidadfalencia(reporteGeneralDto.falencias, circuloCalidad.circuloCalidadRevisados, resultadoRaInsert);
        addcirculoCalidadVariedad(reporteGeneralDto.variedades, circuloCalidad.circuloCalidadRevisados, resultadoRaInsert);
        addcirculoCalidadNumeroMesa(reporteGeneralDto.numerosMesa, circuloCalidad.circuloCalidadRevisados, resultadoRaInsert);
        addcirculoCalidadLinea(reporteGeneralDto.lineas, circuloCalidad.circuloCalidadRevisados, resultadoRaInsert);
      }catch(e){}
    }
    return resultadoRaInsert;
  }

  static Future<void> addcirculoCalidadCliente(List<ClienteReporteGeneralDto> listaObjecto, int circiuloCalidadID) async {
    for (ClienteReporteGeneralDto objetoSave in listaObjecto){
      try{
        final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadClienteTable}
          (
          ${DatabaseCreator.circuloCalidadSameRevisados},
          ${DatabaseCreator.circuloCalidadSameRechazados},
          ${DatabaseCreator.circuloCalidadSamePorcentaje},
          ${DatabaseCreator.circuloCalidadId},
          ${DatabaseCreator.clienteId})
          VALUES(
          ${objetoSave.totalClientes},
          ${objetoSave.cantidad},
          ${objetoSave.porcentajeCliente},
          ${circiuloCalidadID},
          ${objetoSave.id}
          )''';
        await db.rawInsert(sql);
      }catch(e){}
    }
  }

  static Future<void> addcirculoCalidadfalencia(List<FalenciaReporteGeneralDto> listaObjecto, int totalRamos, int circiuloCalidadID) async {
    for (FalenciaReporteGeneralDto objetoSave in listaObjecto){
      try{
        final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadFalenciaTable}
          (
          ${DatabaseCreator.circuloCalidadSameRevisados},
          ${DatabaseCreator.circuloCalidadSameRechazados},
          ${DatabaseCreator.circuloCalidadSamePorcentaje},
          ${DatabaseCreator.circuloCalidadId},
          ${DatabaseCreator.falenciaRamosId})
          VALUES(
          ${totalRamos},
          ${objetoSave.cantidad},
          ${objetoSave.porcentajeFalencia},
          ${circiuloCalidadID},
          ${objetoSave.id}
          )''';
        await db.rawInsert(sql);
      }catch(e){}
    }
  }

  static Future<void> addcirculoCalidadProducto(List<ProductoReporteGeneralDto> listaObjecto, int circiuloCalidadID) async {
    for (ProductoReporteGeneralDto objetoSave in listaObjecto){
      try{
        final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadProductoTable}
          (
          ${DatabaseCreator.circuloCalidadSameRevisados},
          ${DatabaseCreator.circuloCalidadSameRechazados},
          ${DatabaseCreator.circuloCalidadSamePorcentaje},
          ${DatabaseCreator.circuloCalidadId},
          ${DatabaseCreator.productoId})
          VALUES(
          ${objetoSave.totalProductos},
          ${objetoSave.cantidad},
          ${objetoSave.porcentajeProducto},
          ${circiuloCalidadID},
          ${objetoSave.id}
          )''';
        await db.rawInsert(sql);
      }catch(e){}
    }
  }

  static Future<void> addcirculoCalidadVariedad(List<VariedadReporteGeneralDto> listaObjecto, int totalRamos, int circiuloCalidadID) async {
    for (VariedadReporteGeneralDto objetoSave in listaObjecto){
      try{
        final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadVariedadTable}
          (
          ${DatabaseCreator.circuloCalidadVariedadNombre},
          ${DatabaseCreator.circuloCalidadSameRevisados},
          ${DatabaseCreator.circuloCalidadSameRechazados},
          ${DatabaseCreator.circuloCalidadSamePorcentaje},
          ${DatabaseCreator.circuloCalidadId})
          VALUES(
          '${objetoSave.nombreVariedad}',
          ${totalRamos},
          ${objetoSave.cantidad},
          ${objetoSave.porcentajeVariedad},
          ${circiuloCalidadID}
          )''';
        await db.rawInsert(sql);
      }catch(e){}
    }
  }

  static Future<void> addcirculoCalidadNumeroMesa(List<NumeroMesaReporteGeneralDto> listaObjecto, int totalRamos, int circiuloCalidadID) async {
    for (NumeroMesaReporteGeneralDto objetoSave in listaObjecto){
      try{
        final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadNumeroMesaTable}
          (
          ${DatabaseCreator.circuloCalidadNumeroMesaNombre},
          ${DatabaseCreator.circuloCalidadSameRevisados},
          ${DatabaseCreator.circuloCalidadSameRechazados},
          ${DatabaseCreator.circuloCalidadSamePorcentaje},
          ${DatabaseCreator.circuloCalidadId})
          VALUES(
          '${objetoSave.nombreNumeroMesa}',
          ${totalRamos},
          ${objetoSave.cantidad},
          ${objetoSave.porcentajeNumeroMesa},
          ${circiuloCalidadID}
          )''';
        await db.rawInsert(sql);
      }catch(e){}
    }
  }

  static Future<void> addcirculoCalidadLinea(List<LineaReporteGeneralDto> listaObjecto, int totalRamos, int circiuloCalidadID) async {
    for (LineaReporteGeneralDto objetoSave in listaObjecto){
      try{
        final sql = '''INSERT INTO ${DatabaseCreator.circuloCalidadLineaTable}
          (
          ${DatabaseCreator.circuloCalidadLineaNombre},
          ${DatabaseCreator.circuloCalidadSameRevisados},
          ${DatabaseCreator.circuloCalidadSameRechazados},
          ${DatabaseCreator.circuloCalidadSamePorcentaje},
          ${DatabaseCreator.circuloCalidadId})
          VALUES(
          '${objetoSave.nombreLinea}',
          ${totalRamos},
          ${objetoSave.cantidad},
          ${objetoSave.porcentajeLinea},
          ${circiuloCalidadID}
          )''';
        await db.rawInsert(sql);
      }catch(e){}
    }
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
    return resultadoRaInsert;
  }

  static Future<List<CirculoCalidadProducto>> getCirculoCalidadProductoByCirculoCalidad(int circuloCalidadId) async {
    List<CirculoCalidadProducto> circulo = List();
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadProductoTable} where ${DatabaseCreator.circuloCalidadId} = $circuloCalidadId ''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      try{
        CirculoCalidadProducto newObject = new CirculoCalidadProducto();
        newObject.revisados = node[DatabaseCreator.circuloCalidadSameRevisados];
        newObject.rechazados = node[DatabaseCreator.circuloCalidadSameRechazados];
        newObject.porcentaje = node[DatabaseCreator.circuloCalidadSamePorcentaje];
        newObject.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
        newObject.productoId = node[DatabaseCreator.productoId];
        circulo.add(newObject);
      }catch(e){}
    }
    return circulo;
  }

  static Future<List<CirculoCalidadCliente>> getCirculoCalidadClienteByCirculoCalidad(int circuloCalidadId) async {
    List<CirculoCalidadCliente> circulo = List();
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadClienteTable} where ${DatabaseCreator.circuloCalidadId} = $circuloCalidadId ''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      try{
        CirculoCalidadCliente newObject = new CirculoCalidadCliente();
        newObject.revisados = node[DatabaseCreator.circuloCalidadSameRevisados];
        newObject.rechazados = node[DatabaseCreator.circuloCalidadSameRechazados];
        newObject.porcentaje = node[DatabaseCreator.circuloCalidadSamePorcentaje];
        newObject.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
        newObject.clienteId = node[DatabaseCreator.clienteId];
        circulo.add(newObject);
      }catch(e){}
    }
    return circulo;
  }

  static Future<List<CirculoCalidadFalencia>> getCirculoCalidadFalenciaByCirculoCalidad(int circuloCalidadId) async {
    List<CirculoCalidadFalencia> circulo = List();
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadFalenciaTable} where ${DatabaseCreator.circuloCalidadId} = $circuloCalidadId ''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      try{
        CirculoCalidadFalencia newObject = new CirculoCalidadFalencia();
        newObject.revisados = node[DatabaseCreator.circuloCalidadSameRevisados];
        newObject.rechazados = node[DatabaseCreator.circuloCalidadSameRechazados];
        newObject.porcentaje = node[DatabaseCreator.circuloCalidadSamePorcentaje];
        newObject.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
        newObject.falenciaRamosId = node[DatabaseCreator.falenciaRamosId];
        circulo.add(newObject);
      }catch(e){}
    }
    return circulo;
  }

  static Future<List<CirculoCalidadVariedad>> getCirculoCalidadVariedadByCirculoCalidad(int circuloCalidadId) async {
    List<CirculoCalidadVariedad> circulo = List();
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadVariedadTable} where ${DatabaseCreator.circuloCalidadId} = $circuloCalidadId ''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      try{
        CirculoCalidadVariedad newObject = new CirculoCalidadVariedad();
        newObject.circuloCalidadVariedadId = node[DatabaseCreator.circuloCalidadVariedadId];
        newObject.circuloCalidadVariedadNombre = node[DatabaseCreator.circuloCalidadVariedadNombre];
        newObject.revisados = node[DatabaseCreator.circuloCalidadSameRevisados];
        newObject.rechazados = node[DatabaseCreator.circuloCalidadSameRechazados];
        newObject.porcentaje = node[DatabaseCreator.circuloCalidadSamePorcentaje];
        newObject.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
        circulo.add(newObject);
      }catch(e){}
    }
    return circulo;
  }

  static Future<List<CirculoCalidadNumeroMesa>> getCirculoCalidadNumeroMesaByCirculoCalidad(int circuloCalidadId) async {
    List<CirculoCalidadNumeroMesa> circulo = List();
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadNumeroMesaTable} where ${DatabaseCreator.circuloCalidadId} = $circuloCalidadId ''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      try{
        CirculoCalidadNumeroMesa newObject = new CirculoCalidadNumeroMesa();
        newObject.circuloCalidadNumeroMesaId = node[DatabaseCreator.circuloCalidadNumeroMesaId];
        newObject.circuloCalidadNumeroMesaNombre = node[DatabaseCreator.circuloCalidadNumeroMesaNombre];
        newObject.revisados = node[DatabaseCreator.circuloCalidadSameRevisados];
        newObject.rechazados = node[DatabaseCreator.circuloCalidadSameRechazados];
        newObject.porcentaje = node[DatabaseCreator.circuloCalidadSamePorcentaje];
        newObject.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
        circulo.add(newObject);
      }catch(e){}
    }
    return circulo;
  }

  static Future<List<CirculoCalidadLinea>> getCirculoCalidadLineaByCirculoCalidad(int circuloCalidadId) async {
    List<CirculoCalidadLinea> circulo = List();
    final sql =
        '''SELECT * FROM ${DatabaseCreator.circuloCalidadLineaTable} where ${DatabaseCreator.circuloCalidadId} = $circuloCalidadId ''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      try{
        CirculoCalidadLinea newObject = new CirculoCalidadLinea();
        newObject.circuloCalidadLineaId = node[DatabaseCreator.circuloCalidadLineaId];
        newObject.circuloCalidadLineaNombre = node[DatabaseCreator.circuloCalidadLineaNombre];
        newObject.revisados = node[DatabaseCreator.circuloCalidadSameRevisados];
        newObject.rechazados = node[DatabaseCreator.circuloCalidadSameRechazados];
        newObject.porcentaje = node[DatabaseCreator.circuloCalidadSamePorcentaje];
        newObject.circuloCalidadId = node[DatabaseCreator.circuloCalidadId];
        circulo.add(newObject);
      }catch(e){}
    }
    return circulo;
  }


  static Future<void> deleteCirculoCalidad(int circuloCaldiadId) async {
    final sql0 =
        '''DELETE FROM ${DatabaseCreator.circuloCalidadTable} WHERE ${DatabaseCreator.circuloCalidadId} = $circuloCaldiadId''';
    await db.rawDelete(sql0);
  }
}
