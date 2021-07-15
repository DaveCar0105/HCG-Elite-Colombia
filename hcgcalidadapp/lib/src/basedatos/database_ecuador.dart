import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/alerta.dart';
import 'package:hcgcalidadapp/src/modelos/falencia_reporte_ramos.dart';
import 'package:hcgcalidadapp/src/modelos/ramos.dart';
import 'package:hcgcalidadapp/src/modelos/tipoActividad.dart';
import 'package:hcgcalidadapp/src/modelos/tipoCliente.dart';
import 'package:hcgcalidadapp/src/modelos/tipo_control.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';

class DatabaseEcuador {
  static Future<List<ControlRamos>> getAllEcuador() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.controlEcuadorTable} ''';
    final data = await db.rawQuery(sql);
    List<ControlRamos> ramos = [];
    for (final node in data) {
      ramos.add(new ControlRamos(
          controlRamosId: node[DatabaseCreator.controlRamosId],
          ramosNumeroOrden: node[DatabaseCreator.ramosNumeroOrden],
          clienteId: node[DatabaseCreator.clienteId],
          productoId: node[DatabaseCreator.productoId],
          postcosechaId: node[DatabaseCreator.postcosechaId],
          ramosMarca: node[DatabaseCreator.ramoMarca],
          ramosDespachar: node[DatabaseCreator.ramosDespachar],
          ramosElaborados: node[DatabaseCreator.ramosElaborados],
          ramosTallos: node[DatabaseCreator.ramosTallos],
          ramosDerogado: node[DatabaseCreator.ramosDerogado],
          ramosTotal: node[DatabaseCreator.ramosTotal],
          ramosFecha: node[DatabaseCreator.ramosFecha],
          ramosAprobado: node[DatabaseCreator.ramosAprobado]));
    }
    return ramos;
  }

  static Future<List<Map<String, dynamic>>> getAllEcuadorAprobacion() async {
    Preferences pref = Preferences();
    List<Map<String, dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlEcuadorTable},${DatabaseCreator.clienteTable},${DatabaseCreator.postcosechaTable},${DatabaseCreator.productoTable}
    WHERE ${DatabaseCreator.ramosAprobado} = 1
    AND ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.clienteId}=${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.postcosechaId}=${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId}
    AND ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.productoId}=${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}
    
    ''';
    final data = await db.rawQuery(sql);

    for (final node in data) {
      Map<String, dynamic> item = new Map();
      final sql1 = '''SELECT * 
      FROM ${DatabaseCreator.falenciasReporteEcuadorTable},${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.tipoControlTable}
      WHERE ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}
      AND ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.falenciaRamosId}=${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId}
      AND ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.tipoControlId}=${DatabaseCreator.tipoControlTable}.${DatabaseCreator.tipoControlId}''';
      final data1 = await db.rawQuery(sql1);
      List<Map<String, dynamic>> listaFalencias = [];

      for (final fal in data1) {
        Map<String, dynamic> itemFal = Map();
        itemFal = {
          'falenciaRamosId': fal[DatabaseCreator.falenciaRamosId],
          'falenciaEcuadorId': fal[DatabaseCreator.falenciasReporteRamosId],
          'tipoControlId': fal[DatabaseCreator.tipoControlId],
          'falenciaRamosNombre': fal[DatabaseCreator.falenciaRamosNombre],
          'tipoControlNombre': fal[DatabaseCreator.tipoControlNombre],
          'falenciaBandaRamos':
              fal[DatabaseCreator.falenciasReporteRamosCantidad]
        };

        listaFalencias.add(itemFal);
      }
      final sql2 = '''SELECT * 
      FROM ${DatabaseCreator.alertaEcuadorTable}
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}''';
      final data2 = await db.rawQuery(sql2);
      List<Map<String, dynamic>> listaAlertas = [];

      for (final fal in data2) {
        Map<String, dynamic> itemAl = Map();
        itemAl = {
          'alertaEcuadorId': fal[DatabaseCreator.alertaEcuadorId],
          'falenciaRamosId': fal[DatabaseCreator.falenciaRamosId],
          'productoId': fal[DatabaseCreator.productoId],
          'variedadNombre': fal[DatabaseCreator.variedadNombre],
          'tallosMuestra': fal[DatabaseCreator.tallosMuestra],
          'tallosAfectados': fal[DatabaseCreator.tallosAfectados]
        };

        listaAlertas.add(itemAl);
      }
      item = {
        'controlBandaId': node[DatabaseCreator.controlRamosId],
        'controlNumeroOrden': node[DatabaseCreator.ramosNumeroOrden],
        'bandaRamos': node[DatabaseCreator.ramosTotal],
        'bandaFecha': node[DatabaseCreator.ramosFecha],
        'bandaAprobado': node[DatabaseCreator.ramosAprobado],
        'bandaTallos': node[DatabaseCreator.ramosTallos],
        'bandaDerogado': node[DatabaseCreator.ramosDerogado],
        'bandaElaborado': node[DatabaseCreator.ramosElaborados],
        'bandaDespachado': node[DatabaseCreator.ramosDespachar],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'clienteId': node[DatabaseCreator.clienteId],
        'clienteNombre': node[DatabaseCreator.clienteNombre],
        'productoNombre': node[DatabaseCreator.productoNombre],
        'postcosechaNombre': node[DatabaseCreator.postcosechaNombre],
        'productoId': node[DatabaseCreator.productoId],
        'usuarioId': pref.userId,
        'marca': node[DatabaseCreator.ramoMarca],
        'ecuadorProblemas': listaFalencias,
        'alertas': listaAlertas,
        'tipoId': node[DatabaseCreator.tipoControlId],
        'detalleFirmaId': node[DatabaseCreator.detalleFirmaId]
      };

      listaBandas.add(item);
    }
    return listaBandas;
  }

  static Future<Map<String, dynamic>> getAllEcuadorSincro() async {
    Preferences pref = Preferences();
    List<Map<String, dynamic>> listaBandas = [];
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.controlEcuadorTable} 
    WHERE ${DatabaseCreator.ramosAprobado} = 2''';
    final data = await db.rawQuery(sql);

    for (final node in data) {
      Map<String, dynamic> item = new Map();
      final sql1 = '''SELECT * 
      FROM ${DatabaseCreator.falenciasReporteEcuadorTable} 
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}''';
      final data1 = await db.rawQuery(sql1);
      List<Map<String, dynamic>> listaFalencias = [];

      for (final fal in data1) {
        Map<String, dynamic> itemFal = Map();
        itemFal = {
          'falenciaRamosId': fal[DatabaseCreator.falenciaRamosId],
          'falenciaEcuadorId': fal[DatabaseCreator.falenciasReporteRamosId],
          'tipoControlId': fal[DatabaseCreator.tipoControlId],
          'falenciaBandaRamos':
              fal[DatabaseCreator.falenciasReporteRamosCantidad]
        };

        listaFalencias.add(itemFal);
      }
      final sql2 = '''SELECT * 
      FROM ${DatabaseCreator.alertaEcuadorTable} 
      WHERE ${DatabaseCreator.controlRamosId} = ${node[DatabaseCreator.controlRamosId]}''';
      final data2 = await db.rawQuery(sql2);
      List<Map<String, dynamic>> listaAlertas = [];

      for (final fal in data2) {
        Map<String, dynamic> itemAl = Map();
        itemAl = {
          'alertaEcuadorId': fal[DatabaseCreator.alertaEcuadorId],
          'falenciaRamosId': fal[DatabaseCreator.falenciaRamosId],
          'productoId': fal[DatabaseCreator.productoId],
          'variedadNombre': fal[DatabaseCreator.variedadNombre],
          'tallosMuestra': fal[DatabaseCreator.tallosMuestra],
          'tallosAfectados': fal[DatabaseCreator.tallosAfectados]
        };

        listaAlertas.add(itemAl);
      }
      item = {
        'controlBandaId': node[DatabaseCreator.controlRamosId],
        'controlNumeroOrden': node[DatabaseCreator.ramosNumeroOrden],
        'bandaRamos': node[DatabaseCreator.ramosTotal],
        'bandaFecha': node[DatabaseCreator.ramosFecha],
        'bandaAprobado': node[DatabaseCreator.ramosAprobado],
        'bandaTallos': node[DatabaseCreator.ramosTallos],
        'bandaDerogado': node[DatabaseCreator.ramosDerogado],
        'bandaElaborado': node[DatabaseCreator.ramosElaborados],
        'bandaDespachado': node[DatabaseCreator.ramosDespachar],
        'postCosechaId': node[DatabaseCreator.postcosechaId],
        'clienteId': node[DatabaseCreator.clienteId],
        'productoId': node[DatabaseCreator.productoId],
        'usuarioId': pref.userId,
        'marca': node[DatabaseCreator.ramoMarca],
        'ecuadorProblemas': listaFalencias,
        'alertas': listaAlertas,
        'detalleFirmaId': node[DatabaseCreator.detalleFirmaId]
      };

      listaBandas.add(item);
    }

    List<Map<String, dynamic>> listaFirma = [];
    final sql1 = '''
      SELECT ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre} 
      FROM ${DatabaseCreator.firmaTable}, 
      ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlEcuadorTable} 
      WHERE ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId} = 
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      AND ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.ramosAprobado} = 2 
      GROUP BY ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaId},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCodigo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCorreo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaCargo},
      ${DatabaseCreator.firmaTable}.${DatabaseCreator.firmaNombre}
    ''';
    final data1 = await db.rawQuery(sql1);
    for (var firma in data1) {
      Map<String, dynamic> item = new Map();
      item = {
        "firmaId": firma[DatabaseCreator.firmaId],
        "firmaCodigo": firma[DatabaseCreator.firmaCodigo],
        "firmaCargo": firma[DatabaseCreator.firmaCargo],
        "firmaNombre": firma[DatabaseCreator.firmaNombre],
        "firmaCorreo": firma[DatabaseCreator.firmaCorreo]
      };
      listaFirma.add(item);
    }

    final sql2 = '''
      SELECT ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId} 
      FROM ${DatabaseCreator.detalleFirmaTable}, 
      ${DatabaseCreator.controlEcuadorTable} 
      WHERE ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId} = 
      ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.detalleFirmaId} 
      AND ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.ramosAprobado} = 2 
      GROUP BY ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaId},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.detalleFirmaCodigo},
      ${DatabaseCreator.detalleFirmaTable}.${DatabaseCreator.firmaId}
    ''';

    final data2 = await db.rawQuery(sql2);

    List<Map<String, dynamic>> detalleFirma = [];

    for (var detFirma in data2) {
      Map<String, dynamic> itemDetalle = new Map();
      itemDetalle = {
        "detalleFirmaId": detFirma[DatabaseCreator.detalleFirmaId],
        "detalleFirmaCodigo": detFirma[DatabaseCreator.detalleFirmaCodigo],
        "firmaId": detFirma[DatabaseCreator.firmaId]
      };
      detalleFirma.add(itemDetalle);
    }
    Map<String, dynamic> retorno = new Map();
    retorno = {
      "firmas": listaFirma,
      "detallesFirma": detalleFirma,
      "listaEcuador": listaBandas
    };
    return retorno;
  }

  static Future<void> ecuadorSincronizados() async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcuadorTable}
    SET ${DatabaseCreator.ramosAprobado} = 3
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> deleteAlertaReporteEcuador(
      AlertaEcuador alertaEcuador) async {
    final sql = '''DELETE FROM ${DatabaseCreator.alertaEcuadorTable} 
    WHERE ${DatabaseCreator.alertaEcuadorId} = ${alertaEcuador.alertaEcuadorId}
    ''';
    await db.rawQuery(sql);
  }

  static Future<int> addEcuador(ControlRamos ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.controlEcuadorTable}(${DatabaseCreator.detalleFirmaId},${DatabaseCreator.productoId},${DatabaseCreator.usuarioId},${DatabaseCreator.ramosFecha},${DatabaseCreator.ramosNumeroOrden},${DatabaseCreator.ramosTotal},${DatabaseCreator.ramosAprobado},${DatabaseCreator.ramosTallos},${DatabaseCreator.ramosDespachar},${DatabaseCreator.ramosElaborados},${DatabaseCreator.ramosDerogado},${DatabaseCreator.postcosechaId},${DatabaseCreator.ramoMarca},${DatabaseCreator.ramosDesde},${DatabaseCreator.ramosHasta},${DatabaseCreator.clienteId},${DatabaseCreator.elite}) 
    VALUES(${ramos.detalleFirmaId},${ramos.productoId},${ramos.usuarioId},'${ramos.ramosFecha}','${ramos.ramosNumeroOrden}',${ramos.ramosTotal},${ramos.ramosAprobado},${ramos.ramosTallos},${ramos.ramosDespachar},${ramos.ramosElaborados},'${ramos.ramosDerogado}',${ramos.postcosechaId},'${ramos.ramosMarca}',${ramos.ramosDesde},${ramos.ramosHasta},${ramos.clienteId},${ramos.elite})''';
    return await db.rawInsert(sql);
  }

  static Future<void> updateEcuador(ControlRamos ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcuadorTable}
    SET ${DatabaseCreator.ramosNumeroOrden} = '${ramos.ramosNumeroOrden}',
    ${DatabaseCreator.ramosTallos} = ${ramos.ramosTallos},
    ${DatabaseCreator.ramosDerogado} = '${ramos.ramosDerogado}',
    ${DatabaseCreator.ramosDespachar} = ${ramos.ramosDespachar},
    ${DatabaseCreator.ramosElaborados} = ${ramos.ramosElaborados},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta},
    ${DatabaseCreator.ramosTotal} = ${ramos.ramosTotal},
    ${DatabaseCreator.clienteId} = ${ramos.clienteId},
    ${DatabaseCreator.productoId} = ${ramos.productoId},
    ${DatabaseCreator.postcosechaId} =${ramos.postcosechaId},
    ${DatabaseCreator.ramoMarca} ='${ramos.ramosMarca}'
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> finEcuador(ControlRamos ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcuadorTable}
    SET ${DatabaseCreator.ramosAprobado} = ${ramos.ramosAprobado},
    ${DatabaseCreator.ramosHasta} = ${ramos.ramosHasta}
    WHERE ${DatabaseCreator.controlRamosId} = ${ramos.controlRamosId}
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> deleteEcuador(int ramos) async {
    final sql = '''UPDATE ${DatabaseCreator.controlEcuadorTable}
    SET ${DatabaseCreator.ramosAprobado} = 10
    WHERE ${DatabaseCreator.controlRamosId} = $ramos
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> addTipoControl(TipoControl ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.tipoControlTable}(${DatabaseCreator.tipoControlId},${DatabaseCreator.tipoControlNombre},${DatabaseCreator.claseId}
    ) 
    VALUES(${ramos.tipoControlId},'${ramos.tipoControlNombre}',${ramos.claseId})
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> addTipoActividad(TipoActividad ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.tipoActividadTable}(${DatabaseCreator.tipoActividadId},${DatabaseCreator.tipoActividadDescripcion}
    ) 
    VALUES(${ramos.tipoActividadId},'${ramos.tipoActividadDescripcion}')
    ''';
    await db.rawInsert(sql);
  }

  static Future<void> addTipoCliente(TipoCliente ramos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.tipoClienteTable}(${DatabaseCreator.tipoClienteId},${DatabaseCreator.tipoClienteNombre}
    ) 
    VALUES(${ramos.tipoClienteId},'${ramos.tipoClienteNombre}')
    ''';
    await db.rawInsert(sql);
  }

  static Future<List<TipoActividad>> getAllTipoActividad() async {
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.tipoActividadTable}
    ''';
    final data = await db.rawQuery(sql);
    List<TipoActividad> tipos = [];
    for (final node in data) {
      tipos.add(new TipoActividad(
          tipoActividadId: node[DatabaseCreator.tipoActividadId],
          tipoActividadDescripcion:
              node[DatabaseCreator.tipoActividadDescripcion]));
    }
    return tipos;
  }

  static Future<List<TipoCliente>> getAllTipoCliente() async {
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.tipoClienteTable}
    ''';
    final data = await db.rawQuery(sql);
    List<TipoCliente> tipos = [];
    for (final node in data) {
      tipos.add(new TipoCliente(
          tipoClienteId: node[DatabaseCreator.tipoClienteId],
          tipoClienteNombre: node[DatabaseCreator.tipoClienteNombre]));
    }
    return tipos;
  }

  static Future<List<TipoControl>> getAllTipoControl(int id) async {
    final sql = '''SELECT * 
    FROM ${DatabaseCreator.tipoControlTable} 
    WHERE ${DatabaseCreator.claseId}  = $id
    ''';
    final data = await db.rawQuery(sql);
    List<TipoControl> tipos = [];
    for (final node in data) {
      tipos.add(new TipoControl(
          tipoControlId: node[DatabaseCreator.tipoControlId],
          tipoControlNombre: node[DatabaseCreator.tipoControlNombre]));
    }
    return tipos;
  }

  static Future<int> addFalenciaReporteEcuador(
      FalenciaReporteRamos falenciaReporteRamos) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.falenciasReporteEcuadorTable}(${DatabaseCreator.falenciaRamosId},${DatabaseCreator.tipoControlId},${DatabaseCreator.falenciasReporteRamosCantidad},${DatabaseCreator.controlRamosId}) 
    VALUES(${falenciaReporteRamos.falenciaRamosId},${falenciaReporteRamos.total},${falenciaReporteRamos.falenciasReporteRamosCantidad},${falenciaReporteRamos.ramosId})''';
    print(sql);

    return await db.rawInsert(sql);
  }

  static Future<int> addAlertaReporteEcuador(
      AlertaEcuador alertaEcuador) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.alertaEcuadorTable}(${DatabaseCreator.controlRamosId},${DatabaseCreator.falenciaRamosId},${DatabaseCreator.productoId},${DatabaseCreator.variedadNombre},${DatabaseCreator.tallosMuestra},${DatabaseCreator.tallosAfectados}) 
    VALUES(${alertaEcuador.controlEcuadorId},${alertaEcuador.falenciaRamoId},${alertaEcuador.productoId},'${alertaEcuador.variedadNombre}',${alertaEcuador.tallosMuestra},${alertaEcuador.tallosAfectados})''';
    print(sql);

    return await db.rawInsert(sql);
  }

  static Future<List<FalenciaReporteRamos>> getAllFalenciasXEcuadorId(
      int id) async {
    final sql =
        '''SELECT ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre},
    ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.falenciaRamosId},
    ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.falenciasReporteRamosId},
    ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.tipoControlId},
    ${DatabaseCreator.tipoControlTable}.${DatabaseCreator.tipoControlNombre},
    ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.falenciasReporteRamosCantidad}
    FROM ${DatabaseCreator.falenciasReporteEcuadorTable},${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.tipoControlTable}
    WHERE ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.controlRamosId} = $id
    AND ${DatabaseCreator.tipoControlTable}.${DatabaseCreator.tipoControlId} = ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.tipoControlId}
    AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteEcuadorTable}.${DatabaseCreator.falenciaRamosId}
    ''';
    final data = await db.rawQuery(sql);
    List<FalenciaReporteRamos> falenciaReporteRamos = [];
    for (final node in data) {
      falenciaReporteRamos.add(new FalenciaReporteRamos(
        ramosId: id,
        falenciasReporteRamosCantidad:
            node[DatabaseCreator.falenciasReporteRamosCantidad],
        falenciasReporteRamosId: node[DatabaseCreator.falenciasReporteRamosId],
        falenciaRamosId: node[DatabaseCreator.falenciaRamosId],
        falenciaRamosNombre:
            node[DatabaseCreator.tipoControlNombre].toString() +
                ' ' +
                node[DatabaseCreator.falenciaRamosNombre].toString(),
      ));
    }
    return falenciaReporteRamos;
  }

  static Future<List<AlertaEcuador>> getAllAlertas(int id) async {
    final sql =
        '''SELECT ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.alertaEcuadorId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre},
    ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId},
    ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre},
    ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.tallosMuestra},
    ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.tallosAfectados},
    ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.variedadNombre}
    FROM ${DatabaseCreator.alertaEcuadorTable},${DatabaseCreator.productoTable},${DatabaseCreator.falenciaRamosTable}
    WHERE ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}
    AND ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId}
    AND ${DatabaseCreator.alertaEcuadorTable}.${DatabaseCreator.controlRamosId} = $id''';
    final data = await db.rawQuery(sql);
    print(data);
    List<AlertaEcuador> falenciaReporteRamos = [];
    for (final node in data) {
      falenciaReporteRamos.add(new AlertaEcuador(
          controlEcuadorId: id,
          alertaEcuadorId: node[DatabaseCreator.alertaEcuadorId],
          productoNombre: node[DatabaseCreator.productoNombre],
          productoId: node[DatabaseCreator.productoId],
          falenciaRamoNombre: node[DatabaseCreator.falenciaRamosNombre],
          falenciaRamoId: node[DatabaseCreator.falenciaRamosId],
          tallosMuestra: node[DatabaseCreator.tallosMuestra],
          tallosAfectados: node[DatabaseCreator.tallosAfectados],
          variedadNombre: node[DatabaseCreator.variedadNombre]));
    }
    return falenciaReporteRamos;
  }

  static Future<void> updateCantidadFalenciaReporteEcuador(
      FalenciaReporteRamos falenciaReporteRamos) async {
    final sql = '''UPDATE ${DatabaseCreator.falenciasReporteEcuadorTable}
    SET ${DatabaseCreator.falenciasReporteRamosCantidad} = ${falenciaReporteRamos.falenciasReporteRamosCantidad}
    WHERE ${DatabaseCreator.falenciasReporteRamosId} = ${falenciaReporteRamos.falenciasReporteRamosId}
    ''';

    await db.rawQuery(sql);
  }

  static Future<void> deleteFalenciaReporteEcuador(
      FalenciaReporteRamos falenciaReporteRamos) async {
    final sql = '''DELETE FROM ${DatabaseCreator.falenciasReporteEcuadorTable} 
    WHERE ${DatabaseCreator.falenciasReporteRamosId} = ${falenciaReporteRamos.falenciasReporteRamosId}
    ''';
    await db.rawQuery(sql);
  }
}
