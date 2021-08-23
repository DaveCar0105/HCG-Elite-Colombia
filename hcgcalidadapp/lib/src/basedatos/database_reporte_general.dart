import 'dart:convert';

import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_general_dto.dart';

class DatabaseReporteGeneral {
  
  static Future<ReporteGeneralDto> getReporteGeneral() async {
    ReporteGeneralDto reporteGeneral = new ReporteGeneralDto();
    List<FalenciaReporteGeneralDto> listaFalencias = new List<FalenciaReporteGeneralDto>();
    List<ClienteReporteGeneralDto> listaClientes = new List<ClienteReporteGeneralDto>();
    List<ProductoReporteGeneralDto> listaProductos = new List<ProductoReporteGeneralDto>();
    List<VariedadReporteGeneralDto> listaVariedades = new List<VariedadReporteGeneralDto>();
    List<NumeroMesaReporteGeneralDto> listaNumeroMesas = new List<NumeroMesaReporteGeneralDto>();
    List<LineaReporteGeneralDto> listaLineas = new List<LineaReporteGeneralDto>();
    List<int> listaIdClientesProcesador = List<int>();
    reporteGeneral.ramosNoConformes = 0;
    reporteGeneral.ramosRevisados = 0;
    reporteGeneral.totalFalencias = 0;
    //////////////////////////////////// PRODUCTOS //////////////////////////////////////////////////////////

    try {
      final sqlProductos =
          '''SELECT ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.postcosechaId},${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId}, ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre}, 
        SUM(${DatabaseCreator.ramosTotal}) As ${DatabaseCreator.ramosTotal} , COUNT(*) AS NUMERO 
        FROM ${DatabaseCreator.controlRamosTable},${DatabaseCreator.productoTable}
        WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}
        AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId}, ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre}
      ''';
      final datasProductos = await db.rawQuery(sqlProductos);
      for (dynamic elementoQuery in datasProductos) {
        reporteGeneral.postcosechaId = elementoQuery[DatabaseCreator.postcosechaId];
        ProductoReporteGeneralDto productoReporteGeneralDto =
            new ProductoReporteGeneralDto();
        productoReporteGeneralDto.id = elementoQuery["productoId"];
        productoReporteGeneralDto.nombreProducto =
            elementoQuery["productoNombre"];
        productoReporteGeneralDto.porcentajeProducto = 0;
        productoReporteGeneralDto.totalProductos = elementoQuery["ramosTotal"];
        final sqlProductosRamos = '''SELECT COUNT(*) AS AFECTADOS
          FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
          WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.productoId} = ${elementoQuery[DatabaseCreator.productoId]}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
        final datasProductosRamos = await db.rawQuery(sqlProductosRamos);
        if (datasProductosRamos.length > 0) {
          productoReporteGeneralDto.cantidad =
              datasProductosRamos[0]["AFECTADOS"];
          productoReporteGeneralDto.porcentajeProducto =
              productoReporteGeneralDto.totalProductos > 0
                  ? ((productoReporteGeneralDto.cantidad * 100) /
                      productoReporteGeneralDto.totalProductos)
                  : 0;
        } else {
          productoReporteGeneralDto.cantidad = 0;
        }
        listaProductos.add(productoReporteGeneralDto);
      }
      final sqlProductosEmpaque =
          '''SELECT ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.postcosechaId}, ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId}, ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre}, SUM(${DatabaseCreator.empaqueRamosRevisar}) As ${DatabaseCreator.empaqueRamosRevisar}
        FROM ${DatabaseCreator.controlEmpaqueTable},${DatabaseCreator.productoTable}
        WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}
        AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
        GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId}
        ''';
      final datasProductosEmpaque = await db.rawQuery(sqlProductosEmpaque);
      for (dynamic elementoQuery in datasProductosEmpaque) {
        reporteGeneral.postcosechaId = elementoQuery[DatabaseCreator.postcosechaId];
        int indice = listaProductos.lastIndexWhere(
            (element) => element.id == elementoQuery["productoId"]);
        int valorAfectados = 0;
        final sqlProductosRamosEmpaque =
            '''SELECT COUNT(DISTINCT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}) AS RAMOS
          FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.falenciasReporteEmpaqueTable}, ${DatabaseCreator.falenciaEmpaqueTable},${DatabaseCreator.controlEmpaqueTable}
          WHERE ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId}
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId} = ${elementoQuery[DatabaseCreator.productoId]}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId} = ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueId}
          AND ${DatabaseCreator.falenciasReporteEmpaqueTable}.${DatabaseCreator.empaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.empaqueId}
          AND ${DatabaseCreator.falenciaEmpaqueTable}.${DatabaseCreator.falenciaEmpaqueNombre} LIKE 'R%'
          AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
          GROUP BY ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.productoId}
          ''';
        final datasProductosREmp = await db.rawQuery(sqlProductosRamosEmpaque);
        for (dynamic afectad in datasProductosREmp) {
          valorAfectados += afectad['RAMOS'];
        }
        if (indice == -1) {
          ProductoReporteGeneralDto productoReporteGeneralDto =
              new ProductoReporteGeneralDto();
          productoReporteGeneralDto.id = elementoQuery["productoId"];
          productoReporteGeneralDto.nombreProducto =
              elementoQuery["productoNombre"];
          productoReporteGeneralDto.porcentajeProducto = 0;
          productoReporteGeneralDto.totalProductos =
              elementoQuery[DatabaseCreator.empaqueRamosRevisar];
          if (datasProductosREmp.length > 0) {
            productoReporteGeneralDto.cantidad = valorAfectados;
            productoReporteGeneralDto.porcentajeProducto =
                productoReporteGeneralDto.totalProductos > 0
                    ? ((productoReporteGeneralDto.cantidad * 100) /
                        productoReporteGeneralDto.totalProductos)
                    : 0;
          } else {
            productoReporteGeneralDto.cantidad = 0;
          }
          listaProductos.add(productoReporteGeneralDto);
        } else {
          listaProductos[indice].cantidad += valorAfectados;
          listaProductos[indice].totalProductos +=
              elementoQuery[DatabaseCreator.empaqueRamosRevisar];
          if (datasProductosREmp[0] != null) {
            listaProductos[indice].porcentajeProducto =
                listaProductos[indice].totalProductos > 0
                    ? ((listaProductos[indice].cantidad * 100) /
                        listaProductos[indice].totalProductos)
                    : 0;
          }
        }
      }

      //--------------------------------------------------
      final sqlProductosBan =
          '''SELECT ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.postcosechaId},${DatabaseCreator.controlBandaTable}.${DatabaseCreator.productoId}, ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre}, 
        SUM(${DatabaseCreator.ramosTotal}) As ${DatabaseCreator.ramosTotal} , COUNT(*) AS NUMERO 
        FROM ${DatabaseCreator.controlBandaTable},${DatabaseCreator.productoTable}
        WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.productoId} = ${DatabaseCreator.productoTable}.${DatabaseCreator.productoId}
        AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.productoId}, ${DatabaseCreator.productoTable}.${DatabaseCreator.productoNombre}
      ''';
      final datasProductosBan = await db.rawQuery(sqlProductosBan);
      for (dynamic elementoQuery in datasProductosBan) {
        reporteGeneral.postcosechaId = elementoQuery[DatabaseCreator.postcosechaId];
        int indice = listaProductos.lastIndexWhere(
            (element) => element.id == elementoQuery[DatabaseCreator.productoId]);
        int valorAfectados = 0;
        final sqlProductosRamosBan = '''SELECT COUNT(*) AS AFECTADOS
          FROM ${DatabaseCreator.bandaTable}, ${DatabaseCreator.controlBandaTable}
          WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.productoId} = ${elementoQuery[DatabaseCreator.productoId]}
          AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId}
          AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
          ''';
        final datasProductosRamosBan = await db.rawQuery(sqlProductosRamosBan);
        for (dynamic afectad in datasProductosRamosBan) {
          valorAfectados += afectad['AFECTADOS'];
        }
        if (indice == -1) {
          ProductoReporteGeneralDto productoReporteGeneralDto =
              new ProductoReporteGeneralDto();
          productoReporteGeneralDto.id = elementoQuery["productoId"];
          productoReporteGeneralDto.nombreProducto =
              elementoQuery["productoNombre"];
          productoReporteGeneralDto.porcentajeProducto = 0;
          productoReporteGeneralDto.totalProductos =
              elementoQuery[DatabaseCreator.ramosTotal];
          if (datasProductosRamosBan.length > 0) {
            productoReporteGeneralDto.cantidad = valorAfectados;
            productoReporteGeneralDto.porcentajeProducto =
                productoReporteGeneralDto.totalProductos > 0
                    ? ((productoReporteGeneralDto.cantidad * 100) /
                        productoReporteGeneralDto.totalProductos)
                    : 0;
          } else {
            productoReporteGeneralDto.cantidad = 0;
          }
          listaProductos.add(productoReporteGeneralDto);
        } else {
          listaProductos[indice].cantidad += valorAfectados;
          listaProductos[indice].totalProductos +=
              elementoQuery[DatabaseCreator.empaqueRamosRevisar];
          if (datasProductosRamosBan[0] != null) {
            listaProductos[indice].porcentajeProducto =
                listaProductos[indice].totalProductos > 0
                    ? ((listaProductos[indice].cantidad * 100) /
                        listaProductos[indice].totalProductos)
                    : 0;
          }
        }
      }
    } catch (E) {}

    ///////////////////////////// VARIEDAD - NUMERO DE MESA - LINEA /////////////////////////////////////////
    listaVariedades = await _variedadGetDatosReporteGeneral();
    listaNumeroMesas = await _numeroMesaGetDatosReporteGeneral();
    listaLineas = await _lineaGetDatosReporteGeneral();

    //////////////////////////////CLIENTES - FALENCIAS //////////////////////////////////////////////////////
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
      ClienteReporteGeneralDto clienteReporteGeneralDto =
          new ClienteReporteGeneralDto();
      clienteReporteGeneralDto.nombreCliente = elementoQuery["clienteNombre"];
      clienteReporteGeneralDto.cantidad = 0;
      clienteReporteGeneralDto.porcentajeCliente = 0;
      clienteReporteGeneralDto.id = elementoQuery["clienteId"];
      clienteReporteGeneralDto.totalClientes = 0;
      int clienteId = elementoQuery[DatabaseCreator.clienteId];
      var subCliente =
          data.where((e) => e[DatabaseCreator.clienteId] == clienteId).toList();
      if (listaIdClientesProcesador.any((idCL) => idCL == clienteId) == false) {
        for (dynamic client in subCliente) {
          if (client.containsKey('ramosTotal')) {
            clienteReporteGeneralDto.totalClientes += client["ramosTotal"];
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
              clienteReporteGeneralDto.cantidad += afectad['AFECTADOS'];
            }
          } else {
            reporteGeneral.ramosRevisados +=
                client[DatabaseCreator.empaqueRamosRevisar];
            clienteReporteGeneralDto.totalClientes +=
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
              clienteReporteGeneralDto.cantidad += afectad['RAMOS'];
            }
          }
          clienteReporteGeneralDto.porcentajeCliente =
              clienteReporteGeneralDto.totalClientes > 0
                  ? ((clienteReporteGeneralDto.cantidad * 100) /
                      clienteReporteGeneralDto.totalClientes)
                  : 0;
        }
        listaClientes.add(clienteReporteGeneralDto);
        listaIdClientesProcesador.add(clienteId);
      }
    }
    //------------------------Clientes y falencias final de banda ------------------------------//
    final sqlFinalBanda =
        '''SELECT ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}, SUM(${DatabaseCreator.ramosTotal}) As ${DatabaseCreator.ramosTotal} , COUNT(*) AS NUMERO 
    FROM ${DatabaseCreator.controlBandaTable},${DatabaseCreator.clienteTable}
    WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId} = ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteId}
    AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
    GROUP BY ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId}, ${DatabaseCreator.clienteTable}.${DatabaseCreator.clienteNombre}
    ''';
    final datosFinalBanda = await db.rawQuery(sqlFinalBanda);
    for (dynamic elementoQuery in datosFinalBanda) {
      ClienteReporteGeneralDto clienteReporteGeneralDto =
          new ClienteReporteGeneralDto();
      clienteReporteGeneralDto.nombreCliente = elementoQuery[DatabaseCreator.clienteNombre];
      clienteReporteGeneralDto.cantidad = 0;
      clienteReporteGeneralDto.porcentajeCliente = 0;
      clienteReporteGeneralDto.id = elementoQuery[DatabaseCreator.clienteId];
      clienteReporteGeneralDto.totalClientes = 0;
      int clienteId = elementoQuery[DatabaseCreator.clienteId];
      //--------------
      clienteReporteGeneralDto.totalClientes += elementoQuery[DatabaseCreator.ramosTotal];
      reporteGeneral.ramosRevisados += elementoQuery[DatabaseCreator.ramosTotal];
      final sql2 =
          '''SELECT COUNT(*) AS REPETIDOS, ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaRamosId}, ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosNombre}
      FROM ${DatabaseCreator.bandaTable}, ${DatabaseCreator.falenciaBandaTable}, ${DatabaseCreator.falenciaRamosTable},${DatabaseCreator.controlBandaTable}
      WHERE ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.bandaId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.bandaId}
      AND ${DatabaseCreator.falenciaRamosTable}.${DatabaseCreator.falenciaRamosId} = ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaRamosId}
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId}
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId} = ${elementoQuery[DatabaseCreator.clienteId]}
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
      GROUP BY ${DatabaseCreator.falenciaBandaTable}.${DatabaseCreator.falenciaRamosId}
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
      FROM ${DatabaseCreator.bandaTable}, ${DatabaseCreator.controlBandaTable}
      WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.clienteId} = ${elementoQuery[DatabaseCreator.clienteId]}
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId}
      AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
      ''';
      var data1 = await db.rawQuery(sql1);
      for (dynamic afectad in data1) {
        reporteGeneral.ramosNoConformes += afectad['AFECTADOS'];
        clienteReporteGeneralDto.cantidad += afectad['AFECTADOS'];
        clienteReporteGeneralDto.porcentajeCliente =
              clienteReporteGeneralDto.totalClientes > 0
                  ? ((clienteReporteGeneralDto.cantidad * 100) /
                      clienteReporteGeneralDto.totalClientes)
                  : 0;
      }
      int indiceClienteId = listaClientes.lastIndexWhere((element) => element.id == clienteId);
      if (indiceClienteId==-1){
        listaClientes.add(clienteReporteGeneralDto);
      } else {
        listaClientes[indiceClienteId].cantidad += clienteReporteGeneralDto.cantidad;
        listaClientes[indiceClienteId].totalClientes += clienteReporteGeneralDto.totalClientes;
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
    for (VariedadReporteGeneralDto varie in listaVariedades) {
      varie.porcentajeVariedad = reporteGeneral.ramosRevisados > 0
          ? ((varie.cantidad * 100) / reporteGeneral.ramosRevisados)
          : 0;
    }
    for (NumeroMesaReporteGeneralDto numMesa in listaNumeroMesas) {
      numMesa.porcentajeNumeroMesa = reporteGeneral.ramosRevisados > 0
          ? ((numMesa.cantidad * 100) / reporteGeneral.ramosRevisados)
          : 0;
    }
    for (LineaReporteGeneralDto linea in listaLineas) {
      linea.porcentajeLinea = reporteGeneral.ramosRevisados > 0
          ? ((linea.cantidad * 100) / reporteGeneral.ramosRevisados)
          : 0;
    }

    listaVariedades.sort((a, b) => b.porcentajeVariedad.compareTo(a.porcentajeVariedad));
    listaNumeroMesas.sort((a, b) => b.porcentajeNumeroMesa.compareTo(a.porcentajeNumeroMesa));
    listaLineas.sort((a, b) => b.porcentajeLinea.compareTo(a.porcentajeLinea));
    listaClientes.sort((a, b) => b.porcentajeCliente.compareTo(a.porcentajeCliente));
    listaProductos.sort((a, b) => b.porcentajeProducto.compareTo(a.porcentajeProducto));
    reporteGeneral.falencias = listaFalencias;
    reporteGeneral.clientes = listaClientes;
    reporteGeneral.productos = listaProductos;
    reporteGeneral.variedades = listaVariedades;
    reporteGeneral.numerosMesa = listaNumeroMesas;
    reporteGeneral.lineas = listaLineas;
    return reporteGeneral;
  }

  static Future<List<VariedadReporteGeneralDto>> _variedadGetDatosReporteGeneral() async {
    List<VariedadReporteGeneralDto> listaResultado = new List<VariedadReporteGeneralDto>();
    // Control Ramos
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.ramosTable}.${DatabaseCreator.variedad},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
        WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
        AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.ramosTable}.${DatabaseCreator.variedad}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          VariedadReporteGeneralDto objectResult = new VariedadReporteGeneralDto();
          objectResult.id = 0;
          objectResult.nombreVariedad = rawObject[DatabaseCreator.variedad];
          objectResult.cantidad = rawObject['REPETIDOS'];
          objectResult.porcentajeVariedad = 0;
          listaResultado.add(objectResult);
        }catch(e){}
      }
    } catch(e){}
    // Control Empaque
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.variedad},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.controlEmpaqueTable}
        WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
        AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
        GROUP BY ${DatabaseCreator.empaqueTable}.${DatabaseCreator.variedad}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          int indice = listaResultado.lastIndexWhere((element) => element.nombreVariedad == rawObject[DatabaseCreator.variedad]);
          if (indice == -1 ){
            VariedadReporteGeneralDto objectResult = new VariedadReporteGeneralDto();
            objectResult.id = 0;
            objectResult.nombreVariedad = rawObject[DatabaseCreator.variedad];
            objectResult.cantidad = rawObject['REPETIDOS'];
            objectResult.porcentajeVariedad = 0;
            listaResultado.add(objectResult);
          } else {
            listaResultado[indice].cantidad += rawObject['REPETIDOS'];
          }
        }catch(e){}
      }
    } catch(e){}
    // Control Final de Banda
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.bandaTable}.${DatabaseCreator.variedad},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.bandaTable}, ${DatabaseCreator.controlBandaTable}
        WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId}
        AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.bandaTable}.${DatabaseCreator.variedad}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          int indice = listaResultado.lastIndexWhere((element) => element.nombreVariedad == rawObject[DatabaseCreator.variedad]);
          if (indice == -1 ){
            VariedadReporteGeneralDto objectResult = new VariedadReporteGeneralDto();
            objectResult.id = 0;
            objectResult.nombreVariedad = rawObject[DatabaseCreator.variedad];
            objectResult.cantidad = rawObject['REPETIDOS'];
            objectResult.porcentajeVariedad = 0;
            listaResultado.add(objectResult);
          } else {
            listaResultado[indice].cantidad += rawObject['REPETIDOS'];
          }
        }catch(e){}
      }
    } catch(e){}
    return listaResultado;
  }

  static Future<List<NumeroMesaReporteGeneralDto>> _numeroMesaGetDatosReporteGeneral() async {
    List<NumeroMesaReporteGeneralDto> listaResultado = new List<NumeroMesaReporteGeneralDto>();
    // Control Ramos
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.ramosTable}.${DatabaseCreator.numeroMesa},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
        WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
        AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.ramosTable}.${DatabaseCreator.numeroMesa}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          NumeroMesaReporteGeneralDto objectResult = new NumeroMesaReporteGeneralDto();
          objectResult.id = 0;
          objectResult.nombreNumeroMesa = rawObject[DatabaseCreator.numeroMesa];
          objectResult.cantidad = rawObject['REPETIDOS'];
          objectResult.porcentajeNumeroMesa = 0;
          listaResultado.add(objectResult);
        }catch(e){}
      }
    } catch(e){}
    // Control Empaque
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.numeroMesa},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.controlEmpaqueTable}
        WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
        AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
        GROUP BY ${DatabaseCreator.empaqueTable}.${DatabaseCreator.numeroMesa}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          int indice = listaResultado.lastIndexWhere((element) => element.nombreNumeroMesa == rawObject[DatabaseCreator.numeroMesa]);
          if (indice == -1 ){
            NumeroMesaReporteGeneralDto objectResult = new NumeroMesaReporteGeneralDto();
            objectResult.id = 0;
            objectResult.nombreNumeroMesa = rawObject[DatabaseCreator.numeroMesa];
            objectResult.cantidad = rawObject['REPETIDOS'];
            objectResult.porcentajeNumeroMesa = 0;
            listaResultado.add(objectResult);
          } else {
            listaResultado[indice].cantidad += rawObject['REPETIDOS'];
          }
        }catch(e){}
      }
    } catch(e){}
    // Control Final de Banda
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.bandaTable}.${DatabaseCreator.numeroMesa},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.bandaTable}, ${DatabaseCreator.controlBandaTable}
        WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId}
        AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.bandaTable}.${DatabaseCreator.numeroMesa}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          int indice = listaResultado.lastIndexWhere((element) => element.nombreNumeroMesa == rawObject[DatabaseCreator.numeroMesa]);
          if (indice == -1 ){
            NumeroMesaReporteGeneralDto objectResult = new NumeroMesaReporteGeneralDto();
            objectResult.id = 0;
            objectResult.nombreNumeroMesa = rawObject[DatabaseCreator.numeroMesa];
            objectResult.cantidad = rawObject['REPETIDOS'];
            objectResult.porcentajeNumeroMesa = 0;
            listaResultado.add(objectResult);
          } else {
            listaResultado[indice].cantidad += rawObject['REPETIDOS'];
          }
        }catch(e){}
      }
    } catch(e){}
    return listaResultado;
  }

  static Future<List<LineaReporteGeneralDto>> _lineaGetDatosReporteGeneral() async {
    List<LineaReporteGeneralDto> listaResultado = new List<LineaReporteGeneralDto>();
    // Control Ramos
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.ramosTable}.${DatabaseCreator.linea},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.ramosTable}, ${DatabaseCreator.controlRamosTable}
        WHERE ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.ramosTable}.${DatabaseCreator.controlRamosId}
        AND ${DatabaseCreator.controlRamosTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.ramosTable}.${DatabaseCreator.linea}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          LineaReporteGeneralDto objectResult = new LineaReporteGeneralDto();
          objectResult.id = 0;
          objectResult.nombreLinea = rawObject[DatabaseCreator.linea];
          objectResult.cantidad = rawObject['REPETIDOS'];
          objectResult.porcentajeLinea = 0;
          listaResultado.add(objectResult);
        }catch(e){}
      }
    } catch(e){}
    // Control Empaque
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.empaqueTable}.${DatabaseCreator.linea},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.empaqueTable}, ${DatabaseCreator.controlEmpaqueTable}
        WHERE ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.controlEmpaqueId} = ${DatabaseCreator.empaqueTable}.${DatabaseCreator.controlEmpaqueId}
        AND ${DatabaseCreator.controlEmpaqueTable}.${DatabaseCreator.empaqueAprobado} = 1
        GROUP BY ${DatabaseCreator.empaqueTable}.${DatabaseCreator.linea}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          int indice = listaResultado.lastIndexWhere((element) => element.nombreLinea == rawObject[DatabaseCreator.linea]);
          if (indice == -1 ){
            LineaReporteGeneralDto objectResult = new LineaReporteGeneralDto();
            objectResult.id = 0;
            objectResult.nombreLinea = rawObject[DatabaseCreator.linea];
            objectResult.cantidad = rawObject['REPETIDOS'];
            objectResult.porcentajeLinea = 0;
            listaResultado.add(objectResult);
          } else {
            listaResultado[indice].cantidad += rawObject['REPETIDOS'];
          }
        }catch(e){}
      }
    } catch(e){}
    // Control Final de Banda
    try{
      final sentenciaSQL = '''
        SELECT ${DatabaseCreator.bandaTable}.${DatabaseCreator.linea},
        COUNT(*) AS REPETIDOS
        FROM ${DatabaseCreator.bandaTable}, ${DatabaseCreator.controlBandaTable}
        WHERE ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.controlRamosId} = ${DatabaseCreator.bandaTable}.${DatabaseCreator.controlRamosId}
        AND ${DatabaseCreator.controlBandaTable}.${DatabaseCreator.ramosAprobado} = 1
        GROUP BY ${DatabaseCreator.bandaTable}.${DatabaseCreator.linea}
        ''';
      final rawResult = await db.rawQuery(sentenciaSQL);
      for(dynamic rawObject in rawResult){
        try{
          int indice = listaResultado.lastIndexWhere((element) => element.nombreLinea == rawObject[DatabaseCreator.linea]);
          if (indice == -1 ){
            LineaReporteGeneralDto objectResult = new LineaReporteGeneralDto();
            objectResult.id = 0;
            objectResult.nombreLinea = rawObject[DatabaseCreator.linea];
            objectResult.cantidad = rawObject['REPETIDOS'];
            objectResult.porcentajeLinea = 0;
            listaResultado.add(objectResult);
          } else {
            listaResultado[indice].cantidad += rawObject['REPETIDOS'];
          }
        }catch(e){}
      }
    } catch(e){}
    return listaResultado;
  }

}
