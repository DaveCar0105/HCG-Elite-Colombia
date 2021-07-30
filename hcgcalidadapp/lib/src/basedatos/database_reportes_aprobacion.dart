import 'dart:convert';
import 'package:hcgcalidadapp/src/basedatos/database_actividad.dart';
import 'package:hcgcalidadapp/src/basedatos/database_banda.dart';
import 'package:hcgcalidadapp/src/basedatos/database_circulo_calidad.dart';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/basedatos/database_detalle_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_ecuador.dart';
import 'package:hcgcalidadapp/src/basedatos/database_error.dart';
import 'package:hcgcalidadapp/src/basedatos/database_firma.dart';
import 'package:hcgcalidadapp/src/basedatos/database_maritimo.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_empaque.dart';
import 'package:hcgcalidadapp/src/basedatos/database_proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/basedatos/database_temperatura.dart';
import 'package:hcgcalidadapp/src/modelos/actividad.dart';
import 'package:hcgcalidadapp/src/modelos/cantidad.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/control.dart';
import 'package:hcgcalidadapp/src/modelos/detalleFirma.dart';
import 'package:hcgcalidadapp/src/modelos/error.dart';
import 'package:hcgcalidadapp/src/modelos/firma.dart';
import 'package:hcgcalidadapp/src/modelos/historial.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_aprobar.dart';
import 'package:hcgcalidadapp/src/modelos/procesoEmpaque.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_sincronizacion.dart';
import 'package:hcgcalidadapp/src/modelos/temperatura.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';
import 'package:hcgcalidadapp/src/servicios/sincronizar_services.dart';

class DatabaseReportesAprobacion {
  static Future<List<ReporteAprobacion>> getAllReportes() async {
    List<ReporteAprobacion> retorno = new List();
    final sql =
        '''SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.ramosTotal}) As ${DatabaseCreator.ramosTotal} , COUNT(*) AS NUMERO 
    FROM ${DatabaseCreator.controlRamosTable},${DatabaseCreator.clienteTable}
    WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
    GROUP BY ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    ''';
    final datas = await db.rawQuery(sql);

    final sqlE =
        '''SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.empaqueTotal}) As ${DatabaseCreator.empaqueTotal}, SUM(${DatabaseCreator.empaqueRamosRevisar}) As ${DatabaseCreator.empaqueRamosRevisar} , COUNT(*) AS NUMERO 
    FROM ${DatabaseCreator.controlEmpaqueTable},${DatabaseCreator.clienteTable}
    WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
    GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    ''';
    final datasE = await db.rawQuery(sqlE);

    var data = datas.toList();
    data.addAll(datasE);
    while (data.length > 0) {
      ReporteAprobacion item = new ReporteAprobacion();
      int clienteId = data[0][DatabaseCreator.clienteId];
      String clienteNombre = data[0][DatabaseCreator.clienteNombre];
      int total = 0;
      int totalEC = 0;
      int totalER = 0;
      int totalProblemas = 0;

      int numero = 0;
      int numeroE = 0;
      item.inconformidadP = 0;
      item.totalRamosRamos = 0;
      item.inconformidadEmpaqueRamosP = 0;
      item.totalEmpaqueRamos = 0;
      item.totalEmpaqueCajas = 0;
      item.falenciaPrincipal = '';
      item.falenciaSegundaria = '';
      item.inconformidadEmpaqueCajasP = 0;
      item.totalEmpaqueCajasRevisadas = 0;
      item.totalEmpaqueRamosRevisados = 0;
      item.totalRamosRevisados = 0;

      var subCliente =
          data.where((e) => e[DatabaseCreator.clienteId] == clienteId).toList();
      while (subCliente.length > 0) {
        if (subCliente[0].containsKey('ramosTotal')) {
          numero += subCliente[0]['NUMERO'];
          total += subCliente[0][DatabaseCreator.ramosTotal];
          final sql2 =
              '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.falenciasReporteRamosTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.ramosId}
          AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          GROUP BY ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
          var data2 = await db.rawQuery(sql2);

          try {
            item.falenciaPrincipal = data2[0]['falenciaRamosNombre'];
          } catch (e) {
            item.falenciaSegundaria = '';
          }
          try {
            item.falenciaSegundaria = data2[1]['falenciaRamosNombre'];
          } catch (e) {
            item.falenciaSegundaria = '';
          }

          final sql1 = '''SELECT COUNT(*) AS AFECTADOS
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
          var data1 = await db.rawQuery(sql1);
          var variable =
              double.parse(data1[0]['AFECTADOS'].toString()) * 100 / total;
          item.inconformidadP = variable;
          item.totalRamosRamos = data1[0]['AFECTADOS'];
          item.totalRamosRevisados = total;

          subCliente.removeWhere((element) {
            return element[DatabaseCreator.clienteId] == clienteId &&
                element.containsKey('ramosTotal');
          });
        } else {
          numeroE += subCliente[0]['NUMERO'];
          totalEC += subCliente[0][DatabaseCreator.empaqueTotal];
          totalER += subCliente[0][DatabaseCreator.empaqueRamosRevisar];
          final sql2 =
              '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
          var data2 = await db.rawQuery(sql2);
          try {
            item.falenciaPrincipalEmpaque = data2[0]['falenciaEmpaqueNombre'];
          } catch (e) {
            item.falenciaPrincipalEmpaque = '';
          }
          try {
            item.falenciaSegundariaEmpaque = data2[1]['falenciaEmpaqueNombre'];
          } catch (e) {
            item.falenciaSegundariaEmpaque = '';
          }

          final sql1 =
              '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS CAJAS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
          var data1 = await db.rawQuery(sql1);
          final sql3 =
              '''SELECT COUNT(DISTINCT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS RAMOS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
          var data3 = await db.rawQuery(sql3);
          try {
            item.totalEmpaqueRamos = data3[0]['RAMOS'];
          } catch (e) {
            item.totalEmpaqueRamos = 0;
          }
          try {
            item.totalEmpaqueCajas = data1[0]['CAJAS'];
          } catch (e) {
            item.totalEmpaqueCajas = 0;
          }

          item.inconformidadEmpaqueRamosP =
              (item.totalEmpaqueRamos / totalER) * 100;
          item.totalEmpaqueRamos = item.totalEmpaqueRamos;
          item.totalEmpaqueRamosRevisados = totalER;
          item.inconformidadEmpaqueCajasP =
              (item.totalEmpaqueCajas / totalEC) * 100;
          item.totalEmpaqueCajasRevisadas = totalEC;
          item.totalEmpaqueCajas = item.totalEmpaqueCajas;

          subCliente.removeWhere((element) {
            return element[DatabaseCreator.clienteId] == clienteId &&
                element.containsKey('empaqueTotal');
          });
        }
      }
      ;
      item.clienteId = clienteId;
      item.clienteNombre = clienteNombre;
      item.inconformidadP = item.inconformidadP;
      item.inconformidadEmpaqueCajasP = item.inconformidadEmpaqueCajasP;
      item.inconformidadEmpaqueRamosP = item.inconformidadEmpaqueRamosP;
      data.removeWhere((element1) {
        return element1[DatabaseCreator.clienteId] == clienteId;
      });
      retorno.add(item);
    }

    return retorno;
  }

  static Future<List<ReporteAprobacionBanda>> getAllReportesBanda() async {
    List<ReporteAprobacionBanda> retorno = new List();
    final sql =
        '''SELECT ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.ramosTotal}) As ${DatabaseCreator.ramosTotal} , COUNT(*) AS NUMERO 
    FROM ${DatabaseCreator.controlBandaTable},${DatabaseCreator.clienteTable}
    WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
    GROUP BY ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    ''';
    final datas = await db.rawQuery(sql);

    // final sqlE =
    //     '''SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.empaqueTotal}) As ${DatabaseCreator.empaqueTotal}, SUM(${DatabaseCreator.empaqueRamosRevisar}) As ${DatabaseCreator.empaqueRamosRevisar} , COUNT(*) AS NUMERO
    // FROM ${DatabaseCreator.controlEmpaqueTable},${DatabaseCreator.clienteTable}
    // WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    // AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
    // GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    // ''';
    // final datasE = await db.rawQuery(sqlE);

    var data = datas.toList();
    //data.addAll(datasE);
    while (data.length > 0) {
      ReporteAprobacionBanda item = new ReporteAprobacionBanda();
      int clienteId = data[0][DatabaseCreator.clienteId];
      String clienteNombre = data[0][DatabaseCreator.clienteNombre];
      int total = 0;
      int totalEC = 0;
      int totalER = 0;
      int totalProblemas = 0;

      int numero = 0;
      int numeroE = 0;
      item.inconformidadBandaP = 0;
      item.totalRamosRamosBanda = 0;
      item.inconformidadEmpaqueRamosBandaP = 0;
      item.totalEmpaqueRamosBanda = 0;
      item.totalEmpaqueCajasBanda = 0;
      item.falenciaPrincipalBanda = '';
      item.falenciaSegundariaBanda = '';
      item.inconformidadEmpaqueCajasBandaP = 0;
      item.totalEmpaqueCajasRevisadasBanda = 0;
      item.totalEmpaqueRamosRevisadosBanda = 0;
      item.totalRamosRevisadosBanda = 0;

      var subCliente =
          data.where((e) => e[DatabaseCreator.clienteId] == clienteId).toList();
      while (subCliente.length > 0) {
        if (subCliente[0].containsKey('ramosTotal')) {
          numero += subCliente[0]['NUMERO'];
          total += subCliente[0][DatabaseCreator.ramosTotal];
          final sql2 =
              '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
          FROM ${DatabaseCreator.controlBandaTable}, ${DatabaseCreator.falenciasReporteRamosTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.ramosId}
          AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          GROUP BY ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
          var data2 = await db.rawQuery(sql2);

          try {
            item.falenciaPrincipalBanda = data2[0]['falenciaRamosNombre'];
          } catch (e) {
            item.falenciaSegundariaBanda = '';
          }
          try {
            item.falenciaSegundariaBanda = data2[1]['falenciaRamosNombre'];
          } catch (e) {
            item.falenciaSegundariaBanda = '';
          }

          final sql1 = '''SELECT COUNT(*) AS AFECTADOS
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
          var data1 = await db.rawQuery(sql1);
          var variable =
              double.parse(data1[0]['AFECTADOS'].toString()) * 100 / total;
          item.inconformidadBandaP = variable;
          item.totalRamosRamosBanda = data1[0]['AFECTADOS'];
          item.totalRamosRevisadosBanda = total;

          subCliente.removeWhere((element) {
            return element[DatabaseCreator.clienteId] == clienteId &&
                element.containsKey('ramosTotal');
          });
        } else {
          numeroE += subCliente[0]['NUMERO'];
          totalEC += subCliente[0][DatabaseCreator.empaqueTotal];
          totalER += subCliente[0][DatabaseCreator.empaqueRamosRevisar];
          final sql2 =
              '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
          var data2 = await db.rawQuery(sql2);
          try {
            item.falenciaPrincipalEmpaqueBanda =
                data2[0]['falenciaEmpaqueNombre'];
          } catch (e) {
            item.falenciaPrincipalEmpaqueBanda = '';
          }
          try {
            item.falenciaSegundariaEmpaqueBanda =
                data2[1]['falenciaEmpaqueNombre'];
          } catch (e) {
            item.falenciaSegundariaEmpaqueBanda = '';
          }

          final sql1 =
              '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS CAJAS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
          var data1 = await db.rawQuery(sql1);
          final sql3 =
              '''SELECT COUNT(DISTINCT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS RAMOS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${subCliente[0][DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
          var data3 = await db.rawQuery(sql3);
          try {
            item.totalEmpaqueRamosBanda = data3[0]['RAMOS'];
          } catch (e) {
            item.totalEmpaqueRamosBanda = 0;
          }
          try {
            item.totalEmpaqueCajasBanda = data1[0]['CAJAS'];
          } catch (e) {
            item.totalEmpaqueCajasBanda = 0;
          }

          item.inconformidadEmpaqueRamosBandaP =
              (item.totalEmpaqueRamosBanda / totalER) * 100;
          item.totalEmpaqueRamosBanda = item.totalEmpaqueRamosBanda;
          item.totalEmpaqueRamosRevisadosBanda = totalER;
          item.inconformidadEmpaqueCajasBandaP =
              (item.totalEmpaqueCajasBanda / totalEC) * 100;
          item.totalEmpaqueCajasRevisadasBanda = totalEC;
          item.totalEmpaqueCajasBanda = item.totalEmpaqueCajasBanda;

          subCliente.removeWhere((element) {
            return element[DatabaseCreator.clienteId] == clienteId &&
                element.containsKey('empaqueTotal');
          });
        }
      }
      ;
      item.clienteBandaId = clienteId;
      item.clienteBandaNombre = clienteNombre;
      item.inconformidadBandaP = item.inconformidadBandaP;
      item.inconformidadEmpaqueCajasBandaP =
          item.inconformidadEmpaqueCajasBandaP;
      item.inconformidadEmpaqueRamosBandaP =
          item.inconformidadEmpaqueRamosBandaP;
      data.removeWhere((element1) {
        return element1[DatabaseCreator.clienteId] == clienteId;
      });
      retorno.add(item);
    }

    return retorno;
  }

  static Future<ReporteGeneralDto> getReporteGeneral() async {
    ReporteGeneralDto reporteGeneral = new ReporteGeneralDto();
    List<ReporteAprobacion> retorno = new List();
    List<FalenciaReporteGeneralDto> listaFalencias =
        new List<FalenciaReporteGeneralDto>();
    reporteGeneral.ramosNoConformes = 0;
    reporteGeneral.ramosRevisados = 0;
    reporteGeneral.totalFalencias = 0;
    final sql =
        '''SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.ramosTotal}) As ${DatabaseCreator.ramosTotal} , COUNT(*) AS NUMERO 
    FROM ${DatabaseCreator.controlRamosTable},${DatabaseCreator.clienteTable}
    WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
    GROUP BY ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    ''';
    final datas = await db.rawQuery(sql);
    final sqlE =
        '''SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.empaqueTotal}) As ${DatabaseCreator.empaqueTotal}, SUM(${DatabaseCreator.empaqueRamosRevisar}) As ${DatabaseCreator.empaqueRamosRevisar} , COUNT(*) AS NUMERO 
    FROM ${DatabaseCreator.controlEmpaqueTable},${DatabaseCreator.clienteTable}
    WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
    GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    ''';
    final datasE = await db.rawQuery(sqlE);
    var data = datas.toList();
    data.addAll(datasE);
    for (dynamic elementoQuery in data) {
      int clienteId = elementoQuery[DatabaseCreator.clienteId];
      var subCliente =
          data.where((e) => e[DatabaseCreator.clienteId] == clienteId).toList();

      for (dynamic client in subCliente) {
        if (client.containsKey('ramosTotal')) {
          reporteGeneral.ramosRevisados += client[DatabaseCreator.ramosTotal];
          final sql2 =
              '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.falenciasReporteRamosTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.ramosId}
          AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${client[DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          GROUP BY ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          ORDER BY REPETIDOS DESC
          ''';
          var data2 = await db.rawQuery(sql2);
          for (dynamic falen in data2) {
            if (listaFalencias
                .any((element) => element.id == falen['falenciaRamosId'])) {
              var indice = listaFalencias.indexWhere(
                  (element) => element.id == falen['falenciaRamosId']);
              listaFalencias[indice].cantidad += falen['REPETIDOS'];
              reporteGeneral.totalFalencias += falen['REPETIDOS'];
            } else {
              FalenciaReporteGeneralDto newFalencia =
                  new FalenciaReporteGeneralDto();
              newFalencia.cantidad = falen['REPETIDOS'];
              newFalencia.id = falen['falenciaRamosId'];
              newFalencia.nombreFalencia = falen['falenciaRamosNombre'];
              newFalencia.porcentajeFalencia = 0;
              reporteGeneral.totalFalencias += falen['REPETIDOS'];
              listaFalencias.add(newFalencia);
            }
          }
          final sql1 = '''SELECT COUNT(*) AS AFECTADOS
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = ${client[DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
          var data1 = await db.rawQuery(sql1);
          for (dynamic afectad in data1) {
            reporteGeneral.ramosNoConformes += afectad['AFECTADOS'];
          }
        } else {
          reporteGeneral.ramosRevisados +=
              client[DatabaseCreator.empaqueRamosRevisar];
          final sql2 =
              '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${client[DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          ''';
          var data2 = await db.rawQuery(sql2);
          for (dynamic falen in data2) {
            if (listaFalencias
                .any((element) => element.id == falen['falenciaEmpaqueId'])) {
              var indice = listaFalencias.indexWhere(
                  (element) => element.id == falen['falenciaEmpaqueId']);
              listaFalencias[indice].cantidad += falen['REPETIDOS'];
              reporteGeneral.totalFalencias += falen['REPETIDOS'];
            } else {
              FalenciaReporteGeneralDto newFalencia =
                  new FalenciaReporteGeneralDto();
              newFalencia.cantidad = falen['REPETIDOS'];
              newFalencia.id = falen['falenciaEmpaqueId'];
              newFalencia.nombreFalencia = falen['falenciaEmpaqueNombre'];
              newFalencia.porcentajeFalencia = 0;
              reporteGeneral.totalFalencias += falen['REPETIDOS'];
              listaFalencias.add(newFalencia);
            }
          }
          final sql1 =
              '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS CAJAS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${client[DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
          var data1 = await db.rawQuery(sql1);
          final sql3 =
              '''SELECT COUNT(DISTINCT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS RAMOS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = ${client[DatabaseCreator.clienteId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
          var data3 = await db.rawQuery(sql3);
          for (dynamic afectad in data3) {
            reporteGeneral.ramosNoConformes += afectad['RAMOS'];
          }
        }
      }
    }
    if (reporteGeneral.ramosRevisados > 0) {
      reporteGeneral.porRamosNoConformes =
          ((reporteGeneral.ramosNoConformes * 100) /
              reporteGeneral.ramosRevisados);
    }
    listaFalencias.sort((a, b) => b.cantidad.compareTo(a.cantidad));
    for (FalenciaReporteGeneralDto falen in listaFalencias) {
      falen.porcentajeFalencia = reporteGeneral.totalFalencias > 0
          ? ((falen.cantidad * 100) / reporteGeneral.totalFalencias)
          : 0;
    }
    reporteGeneral.falencias = listaFalencias;
    return reporteGeneral;
  }

  static Future<List<OrdenEmpaque>> getAllOrdenes(int clienteId) async {
    List<OrdenEmpaque> listaEmpaques = List();
    final sql =
        '''SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre},
    ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},
    ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueMarca},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueTotal},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueRamosRevisar},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueNumeroOrden},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueDespachar}
          FROM ${DatabaseCreator.controlEmpaqueTable}, ${DatabaseCreator.postcosechaTable}, ${DatabaseCreator.clienteTable}, ${DatabaseCreator.productoTable}  
          WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = $clienteId
          AND ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          AND ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.postcosechaId}
          AND ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          ''';
    var data = await db.rawQuery(sql);
    for (var i = 0; i < data.length; i++) {
      OrdenEmpaque item = new OrdenEmpaque();
      int totalC = 0;
      int totalR = 0;
      item.ordenEmpaqueId = data[i][DatabaseCreator.controlEmpaqueId];
      item.numeroOrden = data[i][DatabaseCreator.empaqueNumeroOrden];
      item.clienteNombre = data[i][DatabaseCreator.clienteNombre];
      item.postCosechaNombre = data[i][DatabaseCreator.postcosechaNombre];
      item.productoNombre = data[i][DatabaseCreator.productoNombre];
      item.marca = data[i][DatabaseCreator.empaqueMarca];
      totalC = data[i][DatabaseCreator.empaqueTotal];
      totalR = data[i][DatabaseCreator.empaqueRamosRevisar];
      item.ramosRevisados = totalR;
      item.cajasRevisadas = totalC;
      item.cajasDespachar = data[i][DatabaseCreator.empaqueDespachar];

      final sql1 =
          '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS CAJAS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
      var data1 = await db.rawQuery(sql1);
      final sql2 =
          '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS RAMOS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
      var data2 = await db.rawQuery(sql2);
      try {
        item.empaqueInconformidadCajas =
            double.parse(data1[0]['CAJAS']) * 100 / totalC;
      } catch (e) {
        item.empaqueInconformidadCajas = 0;
      }

      try {
        item.empaqueInconformidadRamos =
            double.parse(data2[0]['RAMOS']) * 100 / totalR;
        item.ramosNoConformes = data2[0]['RAMOS'];
      } catch (e) {
        item.empaqueInconformidadRamos = 0;
      }
      listaEmpaques.add(item);

      final sql3 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId} 
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data3 = await db.rawQuery(sql3);
      try {
        item.falenciaPrincipalCajas = data3[0]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaPrincipalCajas = 'NO APLICA';
      }
      try {
        item.falenciaSegundariaCajas = data3[1]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaSegundariaCajas = 'NO APLICA';
      }
      final sql4 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId} 
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data4 = await db.rawQuery(sql4);
      try {
        item.falenciaPrincipalRamos = data4[0]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaPrincipalRamos = 'NO APLICA';
      }
      try {
        item.falenciaSegundariaRamos = data4[1]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaSegundariaRamos = 'NO APLICA';
      }
    }
    return listaEmpaques;
  }

  static Future<List<OrdenEmpaque>> getAllOrden() async {
    List<OrdenEmpaque> listaEmpaques = List();
    final sql =
        '''SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre},
    ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},
    ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueMarca},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueTotal},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueRamosRevisar},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueNumeroOrden},
    ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueDespachar}
          FROM ${DatabaseCreator.controlEmpaqueTable}, ${DatabaseCreator.postcosechaTable}, ${DatabaseCreator.clienteTable}, ${DatabaseCreator.productoTable}  
          WHERE ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          AND ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.postcosechaId}
          AND ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 3
          ''';
    var data = await db.rawQuery(sql);
    for (var i = 0; i < data.length; i++) {
      OrdenEmpaque item = new OrdenEmpaque();
      int totalC = 0;
      int totalR = 0;
      item.ordenEmpaqueId = data[i][DatabaseCreator.controlEmpaqueId];
      item.numeroOrden = data[i][DatabaseCreator.empaqueNumeroOrden];
      item.clienteNombre = data[i][DatabaseCreator.clienteNombre];
      item.postCosechaNombre = data[i][DatabaseCreator.postcosechaNombre];
      item.productoNombre = data[i][DatabaseCreator.productoNombre];
      item.marca = data[i][DatabaseCreator.empaqueMarca];
      totalC = data[i][DatabaseCreator.empaqueTotal];
      totalR = data[i][DatabaseCreator.empaqueRamosRevisar];
      item.ramosRevisados = totalR;
      item.cajasRevisadas = totalC;
      item.cajasDespachar = data[i][DatabaseCreator.empaqueDespachar];

      final sql1 =
          '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS CAJAS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 3
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
      var data1 = await db.rawQuery(sql1);
      final sql2 =
          '''SELECT COUNT(DISTINCT	${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS RAMOS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 3
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId}
          ''';
      var data2 = await db.rawQuery(sql2);
      try {
        item.empaqueInconformidadCajas =
            double.parse(data1[0]['CAJAS']) * 100 / totalC;
      } catch (e) {
        item.empaqueInconformidadCajas = 0;
      }

      try {
        item.empaqueInconformidadRamos =
            double.parse(data2[0]['RAMOS']) * 100 / totalR;
        item.ramosNoConformes = data2[0]['RAMOS'];
      } catch (e) {
        item.empaqueInconformidadRamos = 0;
      }
      listaEmpaques.add(item);

      final sql3 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId} 
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 3
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'C%'
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data3 = await db.rawQuery(sql3);
      try {
        item.falenciaPrincipalCajas = data3[0]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaPrincipalCajas = 'NO APLICA';
      }
      try {
        item.falenciaSegundariaCajas = data3[1]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaSegundariaCajas = 'NO APLICA';
      }
      final sql4 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}, ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre}
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${item.ordenEmpaqueId} 
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 3
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          GROUP BY ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data4 = await db.rawQuery(sql4);
      try {
        item.falenciaPrincipalRamos = data4[0]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaPrincipalRamos = 'NO APLICA';
      }
      try {
        item.falenciaSegundariaRamos = data4[1]['falenciaEmpaqueNombre'];
      } catch (e) {
        item.falenciaSegundariaRamos = 'NO APLICA';
      }
    }
    return listaEmpaques;
  }

  static Future<List<OrdenRamo>> getAllOrdenesRamos(int clienteId) async {
    List<OrdenRamo> listaRamos = List();
    final sql =
        '''SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre},
    ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},
    ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramoMarca},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosTotal},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosNumeroOrden},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosDespachar},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosElaborados}
          FROM ${DatabaseCreator.controlRamosTable}, ${DatabaseCreator.postcosechaTable}, ${DatabaseCreator.clienteTable}, ${DatabaseCreator.productoTable}  
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = $clienteId
          AND ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}
          AND ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId}
          AND ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
    var data = await db.rawQuery(sql);
    for (var i = 0; i < data.length; i++) {
      OrdenRamo item = new OrdenRamo();
      int total = 0;
      item.ordenRamoId = data[i][DatabaseCreator.controlRamosId];
      item.numeroOrden = data[i][DatabaseCreator.ramosNumeroOrden];
      item.clienteNombre = data[i][DatabaseCreator.clienteNombre];
      item.postCosechaNombre = data[i][DatabaseCreator.postcosechaNombre];
      item.productoNombre = data[i][DatabaseCreator.productoNombre];
      item.marca = data[i][DatabaseCreator.ramoMarca];
      total = data[i][DatabaseCreator.ramosTotal];
      item.ramosRevisados = total;
      item.ramosElaborados = data[i][DatabaseCreator.ramosElaborados];
      item.ramosADespachar = data[i][DatabaseCreator.ramosDespachar];
      item.inspeccion = double.parse(total.toString()) *
          100 /
          double.parse(data[i][DatabaseCreator.ramosElaborados].toString());

      final sql1 = '''SELECT COUNT(*) AS RAMOS
          FROM ${DatabaseCreator.ramosTable}
          WHERE ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId} = ${item.ordenRamoId}
          ''';
      var data1 = await db.rawQuery(sql1);
      try {
        item.ramoInconformidad = double.parse(data1[0]['RAMOS']) * 100 / total;
        item.ramosNoConformes = data1[0]['RAMOS'];
      } catch (e) {
        item.ramoInconformidad = 0;
        item.ramosNoConformes = 0;
      }
      final sql2 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.falenciasReporteRamosTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.ramosId}
          AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${item.ordenRamoId}
          GROUP BY ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data2 = await db.rawQuery(sql2);
      try {
        item.falenciaPrincipal = data2[0]['falenciaRamosNombre'];
      } catch (e) {
        item.falenciaPrincipal = 'NO APLICA';
      }
      try {
        item.falenciaSegundaria = data2[1]['falenciaRamosNombre'];
      } catch (e) {
        item.falenciaSegundaria = 'NO APLICA';
      }

      listaRamos.add(item);
    }
    return listaRamos;
  }

  static Future<List<OrdenRamo>> getAllOrdenesRamosBanda(int clienteId) async {
    List<OrdenRamo> listaRamos = List();
    final sql =
        '''SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre},
    ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},
    ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramoMarca},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosTotal},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosNumeroOrden},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosDespachar},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosElaborados}
          FROM ${DatabaseCreator.controlRamosTable}, ${DatabaseCreator.postcosechaTable}, ${DatabaseCreator.clienteTable}, ${DatabaseCreator.productoTable}  
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = $clienteId
          AND ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}
          AND ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId}
          AND ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
    var data = await db.rawQuery(sql);
    for (var i = 0; i < data.length; i++) {
      OrdenRamo item = new OrdenRamo();
      int total = 0;
      item.ordenRamoId = data[i][DatabaseCreator.controlRamosId];
      item.numeroOrden = data[i][DatabaseCreator.ramosNumeroOrden];
      item.clienteNombre = data[i][DatabaseCreator.clienteNombre];
      item.postCosechaNombre = data[i][DatabaseCreator.postcosechaNombre];
      item.productoNombre = data[i][DatabaseCreator.productoNombre];
      item.marca = data[i][DatabaseCreator.ramoMarca];
      total = data[i][DatabaseCreator.ramosTotal];
      item.ramosRevisados = total;
      item.ramosElaborados = data[i][DatabaseCreator.ramosElaborados];
      item.ramosADespachar = data[i][DatabaseCreator.ramosDespachar];
      item.inspeccion = double.parse(total.toString()) *
          100 /
          double.parse(data[i][DatabaseCreator.ramosElaborados].toString());

      final sql1 = '''SELECT COUNT(*) AS RAMOS
          FROM ${DatabaseCreator.ramosTable}
          WHERE ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId} = ${item.ordenRamoId}
          ''';
      var data1 = await db.rawQuery(sql1);
      try {
        item.ramoInconformidad = double.parse(data1[0]['RAMOS']) * 100 / total;
        item.ramosNoConformes = data1[0]['RAMOS'];
      } catch (e) {
        item.ramoInconformidad = 0;
        item.ramosNoConformes = 0;
      }
      final sql2 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.falenciasReporteRamosTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.ramosId}
          AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${item.ordenRamoId}
          GROUP BY ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data2 = await db.rawQuery(sql2);
      try {
        item.falenciaPrincipal = data2[0]['falenciaRamosNombre'];
      } catch (e) {
        item.falenciaPrincipal = 'NO APLICA';
      }
      try {
        item.falenciaSegundaria = data2[1]['falenciaRamosNombre'];
      } catch (e) {
        item.falenciaSegundaria = 'NO APLICA';
      }

      listaRamos.add(item);
    }
    return listaRamos;
  }

  static Future<List<OrdenRamo>> getAllOrdenRamos() async {
    List<OrdenRamo> listaRamos = List();
    final sql =
        '''SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId},
    ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre},
    ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},
    ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramoMarca},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosTotal},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosNumeroOrden},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosDespachar},
    ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosElaborados}
          FROM ${DatabaseCreator.controlRamosTable}, ${DatabaseCreator.postcosechaTable}, ${DatabaseCreator.clienteTable}, ${DatabaseCreator.productoTable}  
          WHERE ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId}
          AND ${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId}
          AND ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 3
          ''';
    var data = await db.rawQuery(sql);
    for (var i = 0; i < data.length; i++) {
      OrdenRamo item = new OrdenRamo();
      int total = 0;
      item.ordenRamoId = data[i][DatabaseCreator.controlRamosId];
      item.numeroOrden = data[i][DatabaseCreator.ramosNumeroOrden];
      item.clienteNombre = data[i][DatabaseCreator.clienteNombre];
      item.postCosechaNombre = data[i][DatabaseCreator.postcosechaNombre];
      item.productoNombre = data[i][DatabaseCreator.productoNombre];
      item.marca = data[i][DatabaseCreator.ramoMarca];
      total = data[i][DatabaseCreator.ramosTotal];
      item.ramosRevisados = total;
      item.ramosElaborados = data[i][DatabaseCreator.ramosElaborados];
      item.ramosADespachar = data[i][DatabaseCreator.ramosDespachar];
      item.inspeccion = double.parse(total.toString()) *
          100 /
          double.parse(data[i][DatabaseCreator.ramosElaborados].toString());

      final sql1 = '''SELECT COUNT(*) AS RAMOS
          FROM ${DatabaseCreator.ramosTable}
          WHERE ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId} = ${item.ordenRamoId}
          ''';
      var data1 = await db.rawQuery(sql1);
      try {
        item.ramoInconformidad = double.parse(data1[0]['RAMOS']) * 100 / total;
        item.ramosNoConformes = data1[0]['RAMOS'];
      } catch (e) {
        item.ramoInconformidad = 0;
        item.ramosNoConformes = 0;
      }
      final sql2 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.falenciasReporteRamosTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.ramosId}
          AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 3
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${item.ordenRamoId}
          GROUP BY ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.falenciaRamosId}
          ORDER BY REPETIDOS DESC
          LIMIT 2
          ''';
      var data2 = await db.rawQuery(sql2);
      try {
        item.falenciaPrincipal = data2[0]['falenciaRamosNombre'];
      } catch (e) {
        item.falenciaPrincipal = 'NO APLICA';
      }
      try {
        item.falenciaSegundaria = data2[1]['falenciaRamosNombre'];
      } catch (e) {
        item.falenciaSegundaria = 'NO APLICA';
      }

      listaRamos.add(item);
    }
    return listaRamos;
  }

  static Future<Cantidad> getAllReportesCantidad() async {
    Cantidad cant = new Cantidad();
    int num = 0;
    final sql = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 2
          ''';
    var data = await db.rawQuery(sql);

    final sql1 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 2
          ''';
    var data1 = await db.rawQuery(sql1);
    final sql2 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.procesoEmpaqueTable}
          ''';
    var data2 = await db.rawQuery(sql2);
    final sql3 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.procesoHidratacionTable}
          ''';
    var data3 = await db.rawQuery(sql3);
    final sql4 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.temperaturaTable}
          ''';
    var data4 = await db.rawQuery(sql4);
    final sql5 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.actividadTable}
          ''';
    var data5 = await db.rawQuery(sql5);
    final sql6 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.controlBandaTable}
          WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 2
          ''';
    var data6 = await db.rawQuery(sql6);
    final sql7 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.controlEcuadorTable}
          WHERE ${DatabaseCreator.controlEcuadorTable}.${DatabaseCreator.ramosAprobado} = 2
          ''';
    var data7 = await db.rawQuery(sql7);

     final sql8 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.procesoCirculoCalidadTable}
          ''';
    var data8 = await db.rawQuery(sql8);
     final sql9 = '''SELECT COUNT(*) AS CANTIDAD
          FROM ${DatabaseCreator.procesoMaritimoTable}
          ''';
    var data9 = await db.rawQuery(sql9);

    cant.ramos = data[0]['CANTIDAD'];
    cant.empaque = data1[0]['CANTIDAD'];
    cant.procesoEmp = data2[0]['CANTIDAD'];
    cant.procesoHid = data3[0]['CANTIDAD'];
    cant.temperaturas = data4[0]['CANTIDAD'];
    cant.actividades = data5[0]['CANTIDAD'];
    cant.banda = data6[0]['CANTIDAD'];
    cant.ecuador = data7[0]['CANTIDAD'];
    cant.circuloCalidad = data8[0]['CANTIDAD'];
    cant.procesoMaritimos = data9[0]['CANTIDAD'];
    return cant;
  }

  static Future<int> getAllReportesSinc() async {
    ReporteSincronizacionEmpaque listaEmpaque =
        new ReporteSincronizacionEmpaque();
    ReporteSincronizacionRamo listaRamo = new ReporteSincronizacionRamo();
    List<Actividad> actividades = [];
    List<ProcesoHidratacion> hidratacion = [];
    List<ProcesoEmpaques> procesoEmpaque = [];
    List<Temperatura> temperatura = [];
    List<Firma> firmaEmp = [];
    List<Firma> firmaRam = [];
    List<DetalleFirma> detalleFirmasEmp = [];
    List<DetalleFirma> detalleFirmasRam = [];
    List<Actividade> listaActividades = [];
    List<RegistroHidratacion> listaHidratacion = [];
    List<ProcesoEmpaque> listaProcesoEmpaque = [];
    List<RegistroTemperatura> listaTemperatura = [];
    List<ProcesoMaritimo> listaProcesoMaritimo = [];
    List<circuloCalidad> listaCirculoCalidad = [];


    actividades = await DatabaseActividad.getAllActividad();
    hidratacion = await DatabaseProcesoHidratacion.getAllProcesosHidratacion();
    procesoEmpaque = await DatabaseProcesoEmpaque.getAllProcesosEmpaque();
    temperatura = await DatabaseTemperatura.getAllTemperaturas();
    firmaEmp = await DatabaseFirma.consultarFirmasEmpaque();
    firmaRam = await DatabaseFirma.consultarFirmasRamo();
    detalleFirmasEmp = await DatabaseDetalleFirma.consultarDetallesFirmaEmp();
    detalleFirmasRam = await DatabaseDetalleFirma.consultarDetallesFirmaRam();
    listaProcesoMaritimo = await DatabaseProcesoMaritimo.getAllProcesoMaritimo();
    listaCirculoCalidad = await DatabaseCirculoCalidad.getAllcirculoCalidad();
    listaRamo.firmas = [];
    listaRamo.listaRamo = [];
    listaRamo.detallesFirma = [];
    listaEmpaque.firmas = [];
    listaEmpaque.detallesFirma = [];
    listaEmpaque.listaEmpaque = [];

    Preferences pref = Preferences();

    for (int act = 0; act < actividades.length; act++) {
      listaActividades.add(Actividade(
          actividadDetalle: actividades[act].actividadDetalle,
          actividadFecha: actividades[act].actividadFecha.toString(),
          actividadHoraInicio: actividades[act].actividadHoraInicio,
          actividadHoraFin: actividades[act].actividadHoraFin,
          actividadUsuarioControlId: actividades[act].actividadUsuarioControlId,
          postcosechaId: actividades[act].postcosechaId,
          usuarioId: pref.userId));
    }
    int actCode = await SincServices.postActividad(listaActividades);
    if (actCode >= 200 && actCode <= 299) {
      await actividadesSinc();
    }


    for (int act = 0; act < listaCirculoCalidad.length; act++) {
      print(jsonEncode(listaCirculoCalidad[act]));
    }
    
    for (int act = 0; act < listaProcesoMaritimo.length; act++) {
      print(jsonEncode(listaProcesoMaritimo[act]));
      //listaProcesoMaritimo[act].procesoMaritimoId = null;
    }
    int proMariCode = await SincServices.postAllProcesoMaritimo(listaProcesoMaritimo);

    for (int hid = 0; hid < hidratacion.length; hid++) {
      listaHidratacion.add(RegistroHidratacion(
          procesoHidratacionUsuarioControlId:
              hidratacion[hid].procesoHidratacionUsuarioControlId,
          procesoHidratacionCantidadRamos:
              hidratacion[hid].procesoHidratacionCantidadRamos,
          procesoHidratacionEstadoSoluciones:
              hidratacion[hid].procesoHidratacionEstadoSoluciones,
          procesoHidratacionFecha:
              hidratacion[hid].procesoHidratacionFecha.toString(),
          procesoHidratacionNivelSolucion:
              hidratacion[hid].procesoHidratacionNivelSolucion,
          procesoHidratacionPhSolucion:
              hidratacion[hid].procesoHidratacionPhSolucion,
          procesoHidratacionTiemposHidratacion:
              hidratacion[hid].procesoHidratacionTiemposHidratacion,
          postcosechaId: hidratacion[hid].postcosechaId,
          usuarioId: pref.userId));
    }
    int hidCode = await SincServices.postHidratacion(listaHidratacion);
    if (hidCode >= 200 && hidCode <= 299) {
      await hidratacionSinc();
    }

  
    for (int pemp = 0; pemp < procesoEmpaque.length; pemp++) {
      listaProcesoEmpaque.add(ProcesoEmpaque(
          procesoEmpaqueAltura: procesoEmpaque[pemp].procesoEmpaqueAltura,
          procesoEmpaqueApilamiento:
              procesoEmpaque[pemp].procesoEmpaqueApilamiento,
          procesoEmpaqueCajas: procesoEmpaque[pemp].procesoEmpaqueCajas,
          procesoEmpaqueFecha:
              procesoEmpaque[pemp].procesoEmpaqueFecha.toString(),
          procesoEmpaqueMovimientos:
              procesoEmpaque[pemp].procesoEmpaqueMovimientos,
          procesoEmpaqueSujeccion: procesoEmpaque[pemp].procesoEmpaqueSujeccion,
          procesoEmpaqueTemperaturaCajas:
              procesoEmpaque[pemp].procesoEmpaqueTemperaturaCajas,
          procesoEmpaqueTemperaturaCamion:
              procesoEmpaque[pemp].procesoEmpaqueTemperaturaCamion,
          procesoEmpaqueTemperaturaCuartoFrio:
              procesoEmpaque[pemp].procesoEmpaqueTemperaturaCuartoFrio,
          procesoEmpaqueUsuarioControlId:
              procesoEmpaque[pemp].procesoEmpaqueUsuarioControlId,
          postcosechaId: procesoEmpaque[pemp].postcosechaId,
          usuarioId: pref.userId));
    }
    int pemCode = await SincServices.postProcesoEmpaque(listaProcesoEmpaque);
    if (pemCode >= 200 && pemCode <= 299) {
      await procesoEmpaqueSinc();
    }
    for (int temp = 0; temp < temperatura.length; temp++) {
      listaTemperatura.add(RegistroTemperatura(
          temperaturaExterna: temperatura[temp].temperaturaExterna,
          temperaturaFecha: temperatura[temp].temperaturaFecha.toString(),
          temperaturaInterna1: temperatura[temp].temperaturaInterna1,
          temperaturaInterna2: temperatura[temp].temperaturaInterna2,
          temperaturaInterna3: temperatura[temp].temperaturaInterna3,
          temperaturaUsuarioControlId:
              temperatura[temp].temperaturaUsuarioControlId,
          postcosechaId: temperatura[temp].postcosechaId,
          usuarioId: pref.userId));
    }
    int temCode = await SincServices.postTemperatura(listaTemperatura);
    if (temCode >= 200 && temCode <= 299) {
      await temperaturaSinc();
    }

    try {
      for (int firE = 0; firE < firmaEmp.length; firE++) {
        listaEmpaque.firmas.add(Firmas(
            firmaCargo: firmaEmp[firE].firmaCargo,
            firmaCodigo: firmaEmp[firE].firmaCodigo,
            firmaCorreo: firmaEmp[firE].firmaCorreo,
            firmaNombre: firmaEmp[firE].firmaNombre,
            firmaId: firmaEmp[firE].firmaId,
            firmaReal: 0));
      }
      for (int dfe = 0; dfe < detalleFirmasEmp.length; dfe++) {
        listaEmpaque.detallesFirma.add(DetallesFirma(
            detalleFirmaId: detalleFirmasEmp[dfe].detalleFirmaId,
            firmaCodigo: detalleFirmasEmp[dfe].detalleFirmaCodigo,
            firmaId: detalleFirmasEmp[dfe].firmaId,
            firmaReal: 0));
      }
    } catch (e) {}
    try {
      for (int firR = 0; firR < firmaRam.length; firR++) {
        listaRamo.firmas.add(Firmas(
            firmaCargo: firmaRam[firR].firmaCargo,
            firmaCodigo: firmaRam[firR].firmaCodigo,
            firmaCorreo: firmaRam[firR].firmaCorreo,
            firmaNombre: firmaRam[firR].firmaNombre,
            firmaId: firmaRam[firR].firmaId,
            firmaReal: 0));
      }
      for (int dfr = 0; dfr < detalleFirmasRam.length; dfr++) {
        listaRamo.detallesFirma.add(DetallesFirma(
            detalleFirmaId: detalleFirmasRam[dfr].detalleFirmaId,
            firmaCodigo: detalleFirmasRam[dfr].detalleFirmaCodigo,
            firmaId: detalleFirmasRam[dfr].firmaId,
            firmaReal: 0));
      }
    } catch (e) {
      ErrorT error = ErrorT();
      error.errorDetalle = e.toString();
      await DatabaseError.addError(error);
    }

    final sql = '''SELECT * 
          FROM ${DatabaseCreator.controlRamosTable} 
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 2
          ''';
    var listaRamosSQL = await db.rawQuery(sql);

    try {
      var listaRamos = listaRamosSQL.toList();

      while (listaRamos.length > 0) {
        ListaRamo itemRamo = ListaRamo();
        itemRamo.controlRamosId = listaRamos[0][DatabaseCreator.controlRamosId];
        itemRamo.ramosNumeroOrden =
            listaRamos[0][DatabaseCreator.ramosNumeroOrden];

        itemRamo.clienteId = listaRamos[0][DatabaseCreator.clienteId];
        itemRamo.ramosDerogado = listaRamos[0][DatabaseCreator.ramosDerogado];

        itemRamo.ramosMarca = listaRamos[0][DatabaseCreator.ramoMarca];

        print(listaRamos[0][DatabaseCreator.ramosHasta]);
        print(listaRamos[0][DatabaseCreator.ramosDesde]);
        itemRamo.ramosTiempo = double.parse(
                listaRamos[0][DatabaseCreator.ramosHasta].toString()) -
            double.parse(listaRamos[0][DatabaseCreator.ramosDesde].toString());

        itemRamo.ramosFecha = listaRamos[0][DatabaseCreator.ramosFecha];
        itemRamo.ramosTallos = listaRamos[0][DatabaseCreator.ramosTallos];
        itemRamo.ramosDespachar = listaRamos[0][DatabaseCreator.ramosDespachar];
        itemRamo.ramosElaborados =
            listaRamos[0][DatabaseCreator.ramosElaborados];

        itemRamo.ramosTotal = listaRamos[0][DatabaseCreator.ramosTotal];
        itemRamo.productoId = listaRamos[0][DatabaseCreator.productoId];
        itemRamo.postcosechaId = listaRamos[0][DatabaseCreator.postcosechaId];
        itemRamo.detalleFirmaId = listaRamos[0][DatabaseCreator.detalleFirmaId];

        itemRamo.usuarioId = pref.userId;
        final sqlRamos = '''SELECT *
          FROM ${DatabaseCreator.ramosTable}
          WHERE ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId} = ${itemRamo.controlRamosId}
          ''';

        var ramosSQL = await db.rawQuery(sqlRamos);

        var ramos = ramosSQL.toList();
        itemRamo.ramos = [];
        while (ramos.length > 0) {
          Ramo ramo = Ramo();
          ramo.controlRamosId = ramos[0][DatabaseCreator.controlRamosId];
          ramo.ramoId = ramos[0][DatabaseCreator.ramosId];
          final sqlFalencias = '''SELECT * 
          FROM ${DatabaseCreator.falenciasReporteRamosTable} 
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${ramo.ramoId}
          ''';

          var falenciasSQL = await db.rawQuery(sqlFalencias);
          ramo.falencias = [];
          var falencias = falenciasSQL.toList();
          while (falencias.length > 0) {
            RamoFalencia ramoFalencia = RamoFalencia();
            ramoFalencia.falenciaRamoId =
                falencias[0][DatabaseCreator.falenciaRamosId];
            ramoFalencia.falenciaReporteRamoId =
                falencias[0][DatabaseCreator.falenciasReporteRamosId];
            ramoFalencia.cantidad =
                falencias[0][DatabaseCreator.falenciasReporteRamosCantidad];
            if (ramoFalencia.falenciaRamoId > 0) {
              ramo.falencias.add(ramoFalencia);
            }
            falencias.removeWhere((element) {
              return element[DatabaseCreator.falenciasReporteRamosId] ==
                  ramoFalencia.falenciaReporteRamoId;
            });
          }

          itemRamo.ramos.add(ramo);
          ramos.removeWhere((element) {
            return element[DatabaseCreator.ramosId] == ramo.ramoId;
          });
        }
        try {
          jsonEncode(itemRamo);
          listaRamo.listaRamo.add(itemRamo);
        } catch (e) {
          ErrorT error = ErrorT();
          error.errorDetalle = e.toString();
          await DatabaseError.addError(error);
        }

        listaRamos.removeWhere((element) {
          return element[DatabaseCreator.controlRamosId] ==
              itemRamo.controlRamosId;
        });
      }
    } catch (ex) {
      ErrorT error = ErrorT();
      error.errorDetalle = ex.toString();
      print(ex.toString());
      await DatabaseError.addError(error);
      listaRamo.listaRamo = [];
    }

    List<Control> ramoCode = await SincServices.postReportesRamo(listaRamo);
    if (ramoCode.length > 0) {
      await reporteRamoSinc(ramoCode);
    }
    final sqlE = '''SELECT * 
          FROM ${DatabaseCreator.controlEmpaqueTable} 
          WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 2
          ''';
    var listaEmpaquesSQL = await db.rawQuery(sqlE);
    try {
      var listaEmpaques = listaEmpaquesSQL.toList();
      while (listaEmpaques.length > 0) {
        ListaEmpaque itemEmpaque = ListaEmpaque();
        itemEmpaque.controlEmpaqueId =
            listaEmpaques[0][DatabaseCreator.controlEmpaqueId];
        itemEmpaque.empaqueNumeroOrden =
            listaEmpaques[0][DatabaseCreator.empaqueNumeroOrden];
        itemEmpaque.detalleFirmaId =
            listaEmpaques[0][DatabaseCreator.detalleFirmaId];
        itemEmpaque.clienteId = listaEmpaques[0][DatabaseCreator.clienteId];
        itemEmpaque.empaqueDerogado =
            listaEmpaques[0][DatabaseCreator.empaqueDerogado];
        itemEmpaque.empaqueMarca =
            listaEmpaques[0][DatabaseCreator.empaqueMarca];
        itemEmpaque.empaqueTiempo =
            double.parse(listaEmpaques[0][DatabaseCreator.empaqueHasta]) -
                double.parse(listaEmpaques[0][DatabaseCreator.empaqueDesde]);
        itemEmpaque.empaqueFecha =
            listaEmpaques[0][DatabaseCreator.empaqueFecha];
        itemEmpaque.empaqueTallos =
            listaEmpaques[0][DatabaseCreator.empaqueTallos];
        itemEmpaque.empaqueDespachar =
            listaEmpaques[0][DatabaseCreator.empaqueDespachar];
        itemEmpaque.empaqueTotal =
            listaEmpaques[0][DatabaseCreator.empaqueTotal];
        itemEmpaque.productoId = listaEmpaques[0][DatabaseCreator.productoId];
        itemEmpaque.postcosechaId =
            listaEmpaques[0][DatabaseCreator.postcosechaId];
        itemEmpaque.empaqueRamos =
            listaEmpaques[0][DatabaseCreator.empaqueRamos];
        itemEmpaque.usuarioId = pref.userId;
        itemEmpaque.empaqueRamosRevisar =
            listaEmpaques[0][DatabaseCreator.empaqueRamosRevisar];
        final sqlEmpaques = '''SELECT * 
          FROM ${DatabaseCreator.empaqueTable} 
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} =  ${itemEmpaque.controlEmpaqueId}
          ''';
        var empaquesSQL = await db.rawQuery(sqlEmpaques);
        var empaques = empaquesSQL.toList();
        itemEmpaque.empaques = [];
        while (empaques.length > 0) {
          Empaque empaque = Empaque();
          empaque.controlEmpaqueId =
              empaques[0][DatabaseCreator.controlEmpaqueId];
          empaque.empaqueId = empaques[0][DatabaseCreator.empaqueId];
          final sqlFalencias = '''SELECT * 
          FROM ${DatabaseCreator.falenciasReporteEmpaqueTable} 
          WHERE ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} =  ${empaque.empaqueId}
          ''';
          var falenciasSQL = await db.rawQuery(sqlFalencias);
          var falencias = falenciasSQL.toList();
          empaque.falencias = List();
          while (falencias.length > 0) {
            EmpaqueFalencia empaqueFalencia = EmpaqueFalencia();
            empaqueFalencia.falenciaEmpaqueId =
                falencias[0][DatabaseCreator.falenciaEmpaqueId];
            empaqueFalencia.falenciaReporteEmpaqueId =
                falencias[0][DatabaseCreator.falenciasReporteEmpaqueId];
            empaqueFalencia.cantidad =
                falencias[0][DatabaseCreator.falenciasReporteEmpaqueCantidad];
            if (empaqueFalencia.falenciaEmpaqueId > 0) {
              empaque.falencias.add(empaqueFalencia);
            }
            falencias.removeWhere((element) {
              return element[DatabaseCreator.falenciasReporteEmpaqueId] ==
                  empaqueFalencia.falenciaReporteEmpaqueId;
            });
          }
          itemEmpaque.empaques.add(empaque);
          empaques.removeWhere((element) {
            return element[DatabaseCreator.empaqueId] == empaque.empaqueId;
          });
        }
        listaEmpaque.listaEmpaque.add(itemEmpaque);
        listaEmpaques.removeWhere((element) {
          return element[DatabaseCreator.controlEmpaqueId] ==
              itemEmpaque.controlEmpaqueId;
        });
      }
    } catch (ex) {
      listaEmpaque.listaEmpaque = [];
    }

    List<Control> empaqueCode =
        await SincServices.postReportesEmpaque(listaEmpaque);
    if (empaqueCode.length > 0) {
      await reporteEmpaqueSinc(empaqueCode);
    }

    var listaBandas = await DatabaseBanda.getAllBandasSincro();
    if (await SincServices.postReporteBanda(listaBandas)) {
      await DatabaseBanda.bandaSincronizadas();
    }
    /*
    var listaAlistamiento = await DatabaseAlistamiento.getAllAlistamientoSincro();
    if(await SincServices.postReporteAlistamiento(listaAlistamiento)){
      await DatabaseAlistamiento.alistamientoSincronizados();
    }
    var listaBoncheo = await DatabaseBoncheo.getAllBoncheoSincro();
    if(await SincServices.postReporteBoncheo(listaBoncheo)){
      await DatabaseBoncheo.boncheoSincronizados();
    }
    var listaEcommerce = await DatabaseEcommerce.getAllEcommerceSincro();
    if(await SincServices.postReporteEcommerce(listaEcommerce)){
      await DatabaseEcommerce.ecommerceSincronizados();
    }*/

    var listaEcuador = await DatabaseEcuador.getAllEcuadorSincro();
    if (await SincServices.postReporteEcuador(listaEcuador)) {
      await DatabaseEcuador.ecuadorSincronizados();
    }
    return 1;
  }

  static Future<String> jsonRamos() async {
    Preferences pref = Preferences();
    ReporteSincronizacionRamo listaRamo = new ReporteSincronizacionRamo();
    listaRamo.firmas = List();
    listaRamo.listaRamo = List();
    listaRamo.detallesFirma = List();
    List<Firma> firmaRam = List();
    List<DetalleFirma> detalleFirmasRam = List();
    detalleFirmasRam = await DatabaseDetalleFirma.consultarDetallesFirmaRam();
    firmaRam = await DatabaseFirma.consultarFirmasRamo();
    try {
      for (int firR = 0; firR < firmaRam.length; firR++) {
        listaRamo.firmas.add(Firmas(
            firmaCargo: firmaRam[firR].firmaCargo,
            firmaCodigo: firmaRam[firR].firmaCodigo,
            firmaCorreo: firmaRam[firR].firmaCorreo,
            firmaNombre: firmaRam[firR].firmaNombre,
            firmaId: firmaRam[firR].firmaId,
            firmaReal: 0));
      }
      for (int dfr = 0; dfr < detalleFirmasRam.length; dfr++) {
        listaRamo.detallesFirma.add(DetallesFirma(
            detalleFirmaId: detalleFirmasRam[dfr].detalleFirmaId,
            firmaCodigo: detalleFirmasRam[dfr].detalleFirmaCodigo,
            firmaId: detalleFirmasRam[dfr].firmaId,
            firmaReal: 0));
      }
    } catch (e) {
      return e.toString();
    }
    final sql = '''SELECT * 
          FROM ${DatabaseCreator.controlRamosTable} 
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 2
          ''';
    var listaRamosSQL = await db.rawQuery(sql);

    try {
      var listaRamos = listaRamosSQL.toList();
      while (listaRamos.length > 0) {
        ListaRamo itemRamo = ListaRamo();
        itemRamo.controlRamosId = listaRamos[0][DatabaseCreator.controlRamosId];
        itemRamo.ramosNumeroOrden =
            listaRamos[0][DatabaseCreator.ramosNumeroOrden];
        itemRamo.clienteId = listaRamos[0][DatabaseCreator.clienteId];
        itemRamo.ramosDerogado = listaRamos[0][DatabaseCreator.ramosDerogado];
        itemRamo.ramosMarca = listaRamos[0][DatabaseCreator.ramoMarca];
        itemRamo.ramosTiempo = double.parse(
                listaRamos[0][DatabaseCreator.ramosDesde].toString()) -
            double.parse(listaRamos[0][DatabaseCreator.ramosHasta].toString());
        itemRamo.ramosFecha = listaRamos[0][DatabaseCreator.ramosFecha];
        itemRamo.ramosTallos = listaRamos[0][DatabaseCreator.ramosTallos];
        itemRamo.ramosDespachar = listaRamos[0][DatabaseCreator.ramosDespachar];
        itemRamo.ramosElaborados =
            listaRamos[0][DatabaseCreator.ramosElaborados];
        itemRamo.ramosTotal = listaRamos[0][DatabaseCreator.ramosTotal];
        itemRamo.productoId = listaRamos[0][DatabaseCreator.productoId];
        itemRamo.postcosechaId = listaRamos[0][DatabaseCreator.postcosechaId];
        itemRamo.detalleFirmaId = listaRamos[0][DatabaseCreator.detalleFirmaId];
        itemRamo.usuarioId = pref.userId;
        final sqlRamos = '''SELECT *
          FROM ${DatabaseCreator.ramosTable}
          WHERE ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId} = ${itemRamo.controlRamosId}
          ''';
        var ramosSQL = await db.rawQuery(sqlRamos);
        var ramos = ramosSQL.toList();
        itemRamo.ramos = List();
        while (ramos.length > 0) {
          Ramo ramo = Ramo();
          ramo.controlRamosId = ramos[0][DatabaseCreator.controlRamosId];
          ramo.ramoId = ramos[0][DatabaseCreator.ramosId];
          final sqlFalencias = '''SELECT * 
          FROM ${DatabaseCreator.falenciasReporteRamosTable} 
          WHERE ${DatabaseCreator.falenciasReporteRamosTable}.${DatabaseCreator.ramosId} = ${ramo.ramoId}
          ''';
          var falenciasSQL = await db.rawQuery(sqlFalencias);
          ramo.falencias = List();
          var falencias = falenciasSQL.toList();
          while (falencias.length > 0) {
            RamoFalencia ramoFalencia = RamoFalencia();
            ramoFalencia.falenciaRamoId =
                falencias[0][DatabaseCreator.falenciaRamosId];
            ramoFalencia.falenciaReporteRamoId =
                falencias[0][DatabaseCreator.falenciasReporteRamosId];
            ramoFalencia.cantidad =
                falencias[0][DatabaseCreator.falenciasReporteRamosCantidad];
            ramo.falencias.add(ramoFalencia);
            falencias.removeWhere((element) {
              return element[DatabaseCreator.falenciasReporteRamosId] ==
                  ramoFalencia.falenciaReporteRamoId;
            });
          }

          itemRamo.ramos.add(ramo);
          ramos.removeWhere((element) {
            return element[DatabaseCreator.ramosId] == ramo.ramoId;
          });
        }
        try {
          jsonEncode(itemRamo);
          listaRamo.listaRamo.add(itemRamo);
        } catch (e) {
          return e.toString();
        }

        listaRamos.removeWhere((element) {
          return element[DatabaseCreator.controlRamosId] ==
              itemRamo.controlRamosId;
        });
      }
    } catch (ex) {
      listaRamo.listaRamo = [];
      return ex.toString();
    }

    return jsonEncode(listaRamo).toString();
  }

  static reporteEmpaqueSinc(List<Control> list) async {
    for (int i = 0; i < list.length; i++) {
      final sql = '''
        UPDATE ${DatabaseCreator.controlEmpaqueTable} 
        SET ${DatabaseCreator.empaqueAprobado} = 3 
        WHERE ${DatabaseCreator.empaqueAprobado} = 2 
        AND ${DatabaseCreator.controlEmpaqueId} = ${list[i].id}
        ''';
      await db.rawUpdate(sql);
    }
  }

  static reporteRamoSinc(List<Control> list) async {
    for (int i = 0; i < list.length; i++) {
      final sql = '''
        UPDATE ${DatabaseCreator.controlRamosTable} 
        SET ${DatabaseCreator.ramosAprobado} = 3 
        WHERE ${DatabaseCreator.ramosAprobado} = 2 
        AND ${DatabaseCreator.controlRamosId} = ${list[i].id}
        ''';
      await db.rawUpdate(sql);
    }
  }

  static actividadesSinc() async {
    final sqlA = 'DELETE FROM ${DatabaseCreator.actividadTable}';
    await db.rawDelete(sqlA);
  }

  static hidratacionSinc() async {
    final sqlH = 'DELETE FROM ${DatabaseCreator.procesoHidratacionTable}';
    await db.rawDelete(sqlH);
  }

  static temperaturaSinc() async {
    final sqlT = 'DELETE FROM ${DatabaseCreator.temperaturaTable}';
    await db.rawDelete(sqlT);
  }

  static procesoEmpaqueSinc() async {
    final sqlPE = 'DELETE FROM ${DatabaseCreator.procesoEmpaqueTable}';
    await db.rawDelete(sqlPE);
  }

  static procesoMaritimoSinc() async {
    final sqlA = 'DELETE FROM ${DatabaseCreator.procesoMaritimoTable}';
    await db.rawDelete(sqlA);
  }

  static circuloCalidadSinz() async {
    final sqlA = 'DELETE FROM ${DatabaseCreator.procesoCirculoCalidadTable}';
    await db.rawDelete(sqlA);
  }

  static historialReportes() async {
    List<Historial> lista = List();
    List<Historial> lista1 = List();
    final sql = ''
        'SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosNumeroOrden},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosTotal},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosFecha},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.usuarioId},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosDespachar},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosTallos},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosElaborados},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosDerogado},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramoMarca},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.detalleFirmaId},'
        '${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId},'
        '${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},'
        '${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},'
        '${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre} '
        'FROM ${DatabaseCreator.controlRamosTable},${DatabaseCreator.postcosechaTable},${DatabaseCreator.clienteTable},${DatabaseCreator.productoTable} '
        'WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId} = '
        '${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} '
        'AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.clienteId} = '
        '${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} '
        'AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId} = '
        '${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}';
    final result = await db.rawQuery(sql);
    var listaResult = result.toList();
    for (var i = 0; i < listaResult.length; i++) {
      Historial item = new Historial();
      item.controlRamosId = listaResult[i][DatabaseCreator.controlRamosId];
      item.detalleFirmaId = listaResult[i][DatabaseCreator.detalleFirmaId];
      item.clienteId = listaResult[i][DatabaseCreator.clienteId];
      item.productoId = listaResult[i][DatabaseCreator.productoId];
      item.usuarioId = listaResult[i][DatabaseCreator.usuarioId];
      item.postcosechaId = listaResult[i][DatabaseCreator.postcosechaId];
      item.estado = listaResult[i][DatabaseCreator.ramosAprobado];
      item.ramosNumeroOrden =
          listaResult[i][DatabaseCreator.ramosNumeroOrden].toString();
      item.ramosTotal = listaResult[i][DatabaseCreator.ramosTotal].toString();
      item.ramosFecha = listaResult[i][DatabaseCreator.ramosFecha].toString();
      item.clienteNombre =
          listaResult[i][DatabaseCreator.clienteNombre].toString();
      item.productoNombre =
          listaResult[i][DatabaseCreator.productoNombre].toString();
      item.ramosTallos = listaResult[i][DatabaseCreator.ramosTallos].toString();
      item.ramosDespachar =
          listaResult[i][DatabaseCreator.ramosDespachar].toString();
      item.ramosElaborados =
          listaResult[i][DatabaseCreator.ramosElaborados].toString();
      item.ramosDerogado =
          listaResult[i][DatabaseCreator.ramosDerogado].toString();
      item.postcosechaNombre =
          listaResult[i][DatabaseCreator.postcosechaNombre].toString();
      item.ramosMarca = listaResult[i][DatabaseCreator.ramoMarca].toString();
      item.tipo = "RAMO";
      lista.add(item);
    }
    final sql1 = ''
        'SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueNumeroOrden},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueTotal},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueFecha},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.postcosechaId},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.usuarioId},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueDespachar},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueTallos},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueRamos},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueDerogado},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueMarca},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.detalleFirmaId},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueRamosRevisar},'
        '${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.postcosechaId},'
        '${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaNombre},'
        '${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre},'
        '${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre} '
        'FROM ${DatabaseCreator.controlEmpaqueTable},${DatabaseCreator.postcosechaTable},${DatabaseCreator.clienteTable},${DatabaseCreator.productoTable} '
        'WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.postcosechaId} = '
        '${DatabaseCreator.postcosechaTable}.${DatabaseCreator.postcosechaId} '
        'AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.clienteId} = '
        '${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId} '
        'AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId} = '
        '${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}';
    final result1 = await db.rawQuery(sql1);
    var listaResult1 = result1.toList();

    for (var i = 0; i < listaResult1.length; i++) {
      Historial item = new Historial();
      item.controlRamosId = listaResult1[i][DatabaseCreator.controlEmpaqueId];
      item.detalleFirmaId = listaResult1[i][DatabaseCreator.detalleFirmaId];
      item.clienteId = listaResult1[i][DatabaseCreator.clienteId];
      item.productoId = listaResult1[i][DatabaseCreator.productoId];
      item.usuarioId = listaResult1[i][DatabaseCreator.usuarioId];
      item.postcosechaId = listaResult1[i][DatabaseCreator.postcosechaId];
      item.estado = listaResult1[i][DatabaseCreator.empaqueAprobado];
      item.ramosNumeroOrden =
          listaResult1[i][DatabaseCreator.empaqueNumeroOrden].toString();
      item.ramosTotal =
          listaResult1[i][DatabaseCreator.empaqueRamosRevisar].toString();
      item.ramosFecha =
          listaResult1[i][DatabaseCreator.empaqueFecha].toString();
      item.clienteNombre =
          listaResult1[i][DatabaseCreator.clienteNombre].toString();
      item.productoNombre =
          listaResult1[i][DatabaseCreator.productoNombre].toString();
      item.ramosTallos =
          listaResult1[i][DatabaseCreator.empaqueTallos].toString();
      item.ramosDespachar =
          listaResult1[i][DatabaseCreator.empaqueDespachar].toString();
      item.ramosElaborados =
          listaResult1[i][DatabaseCreator.ramosElaborados].toString();
      item.ramosDerogado =
          listaResult1[i][DatabaseCreator.empaqueDerogado].toString();
      item.postcosechaNombre =
          listaResult1[i][DatabaseCreator.postcosechaNombre].toString();
      item.ramosMarca =
          listaResult1[i][DatabaseCreator.empaqueMarca].toString();
      item.cajasRevisar =
          listaResult1[i][DatabaseCreator.empaqueTotal].toString();
      item.tipo = 'EMPAQUE';
      lista1.add(item);
    }
    lista.sort((a, b) {
      return b.controlRamosId.compareTo(a.controlRamosId);
    });
    return lista;
  }
}
