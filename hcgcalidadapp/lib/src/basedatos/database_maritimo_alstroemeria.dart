import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';

////EDITAR
class DatabaseProcesoMaritimoAlstroemeria {
  static Future<List<ProcesoMaritimoAlstroemeria>>
      getAllProcesoMaritimoAlstromeriaSincronizacion() async {
    final sql =
        'SELECT * FROM ${DatabaseCreator.procesoMaritimoAlstroemeriaTable} WHERE ${DatabaseCreator.procesoMaritimoAlstroemeriaEstado}=2';
    final data = await db.rawQuery(sql);
    List<ProcesoMaritimoAlstroemeria> maritimo = List();
    for (var json in data) {
      maritimo.add(new ProcesoMaritimoAlstroemeria(
        procesoMaritimoAlstroemeriaId:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaId],
        procesoMaritimoAlstroemeriaUsuarioControlId:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaUsuarioControlId],
        procesoMaritimoAlstroemeriaNumeroGuia:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaNumeroGuia],
        procesoMaritimoAlstroemeriaDestinoId: int.parse(
            json[DatabaseCreator.procesoMaritimoAlstroemeriaDestinoId]),
        procesoMaritimoAlstroemeriaRealizadoPor:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaRealizadoPor]
                .toString(),
        procesoMaritimoAlstroemeriaAcompanamiento:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaAcompanamiento]
                .toString(),
        procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad],
        procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta],
        procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion],
        procesoMaritimoAlstroemeriaClasificacionLongitudTallos: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionLongitudTallos],
        procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal],
        procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado],
        procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood],
        procesoMaritimoAlstroemeriaClasificacionLibreMaltrato: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionLibreMaltrato],
        procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso],
        procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos],
        procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo],
        procesoMaritimoAlstroemeriaTratamientoBaldesTinas: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoBaldesTinas],
        procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion],
        procesoMaritimoAlstroemeriaTratamientoNivelSolucion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoNivelSolucion],
        procesoMaritimoAlstroemeriaTratamientoCambioSolucion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoCambioSolucion],
        procesoMaritimoAlstroemeriaTratamientoTiempoSala: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoTiempoSala],
        procesoMaritimoAlstroemeriaHidratacionNumeroRamos: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionNumeroRamos],
        procesoMaritimoAlstroemeriaHidratacionRamosHidratados: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionRamosHidratados],
        procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio],
        procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado],
        procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion],
        procesoMaritimoAlstroemeriaEmpaqueEdadFlor:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEdadFlor],
        procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos],
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos],
        procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento],
        procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo],
        procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad],
        procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas],
        procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue],
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR],
        procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto],
        procesoMaritimoAlstroemeriaEmpaqueEmpacoHB:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEmpacoHB],
        procesoMaritimoAlstroemeriaTransporteTemperauraCajas: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteTemperauraCajas],
        procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio],
        procesoMaritimoAlstroemeriaTransporteCamionTransporta: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteCamionTransporta],
        procesoMaritimoAlstroemeriaTransporteTemperaturaCamion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteTemperaturaCamion],
        procesoMaritimoAlstroemeriaTransporteBuenaConexion: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteBuenaConexion],
        procesoMaritimoAlstroemeriaTransporteThermoking: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteThermoking],
        procesoMaritimoAlstroemeriaTransporteCajasApiladas: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteCajasApiladas],
        procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado],
        procesoMaritimoAlstromeriaTransporteTemperaturaFurgon: json[
            DatabaseCreator
                .procesoMaritimoAlstromeriaTransporteTemperaturaFurgon],
        procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias],
        procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros],
        procesoMaritimoAlstroemeriaPalletizadoPalletsAltura: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoPalletsAltura],
        procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido],
        procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado],
        procesoMaritimoAlstroemeriaContenedorGenset:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaContenedorGenset],
        procesoMaritimoAlstroemeriaContenedorFechaFabricacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorFechaFabricacion],
        procesoMaritimoAlstroemeriaContenedorContenedorSeteo: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorContenedorSeteo],
        procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado],
        procesoMaritimoAlstroemeriaContenedorContenedorLavado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorContenedorLavado],
        procesoMaritimoAlstroemeriaContenedorSachetsEthiblock: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorSachetsEthiblock],
        procesoMaritimoAlstroemeriaContenedorCierreSellado: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaContenedorCierreSellado],
        procesoMaritimoAlstroemeriaContenedorControlTemperatura: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorControlTemperatura],
        procesoMaritimoAlstroemeriaContenedorObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaContenedorObservaciones],
        procesoMaritimoAlstroemeriaPalletizadoObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoObservaciones],
        procesoMaritimoAlstroemeriaTransporteObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteObservaciones],
        procesoMaritimoAlstroemeriaEmpaqueObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueObservaciones],
        procesoMaritimoAlstroemeriaHidratacionObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionObservaciones],
        procesoMaritimoAlstroemeriaTratamientoObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoObservaciones],
        procesoMaritimoAlstroemeriaClasificacionObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionObservaciones],
        procesoMaritimoAlstromeriaRecepcionObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstromeriaRecepcionObservaciones],
        clienteId: json[DatabaseCreator.clienteId],
        postcosechaId: json[DatabaseCreator.postcosechaId],
        procesoMaritimoAlstroemeriaFecha:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaFecha] != null
                ? DateTime.parse(
                    json[DatabaseCreator.procesoMaritimoAlstroemeriaFecha])
                : null,
      ));
    }
    return maritimo;
  }

  static Future<List<ProcesoMaritimoAlstroemeria>>
      getAllProcesoMaritimoAlstromeriaAprobacion() async {
    final sql =
        'SELECT * FROM ${DatabaseCreator.procesoMaritimoAlstroemeriaTable} WHERE ${DatabaseCreator.procesoMaritimoAlstroemeriaEstado}=1';
    final data = await db.rawQuery(sql);
    List<ProcesoMaritimoAlstroemeria> maritimo = List();
    for (var json in data) {
      maritimo.add(new ProcesoMaritimoAlstroemeria(
        procesoMaritimoAlstroemeriaId:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaId],
        procesoMaritimoAlstroemeriaUsuarioControlId:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaUsuarioControlId],
        procesoMaritimoAlstroemeriaNumeroGuia:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaNumeroGuia],
        procesoMaritimoAlstroemeriaDestinoId: int.parse(
            json[DatabaseCreator.procesoMaritimoAlstroemeriaDestinoId]),
        procesoMaritimoAlstroemeriaRealizadoPor:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaRealizadoPor]
                .toString(),
        procesoMaritimoAlstroemeriaAcompanamiento:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaAcompanamiento]
                .toString(),
        procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad],
        procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta],
        procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion],
        procesoMaritimoAlstroemeriaClasificacionLongitudTallos: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionLongitudTallos],
        procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal],
        procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado],
        procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood],
        procesoMaritimoAlstroemeriaClasificacionLibreMaltrato: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionLibreMaltrato],
        procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso],
        procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos],
        procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo],
        procesoMaritimoAlstroemeriaTratamientoBaldesTinas: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoBaldesTinas],
        procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion],
        procesoMaritimoAlstroemeriaTratamientoNivelSolucion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoNivelSolucion],
        procesoMaritimoAlstroemeriaTratamientoCambioSolucion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoCambioSolucion],
        procesoMaritimoAlstroemeriaTratamientoTiempoSala: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoTiempoSala],
        procesoMaritimoAlstroemeriaHidratacionNumeroRamos: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionNumeroRamos],
        procesoMaritimoAlstroemeriaHidratacionRamosHidratados: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionRamosHidratados],
        procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio],
        procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado],
        procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion],
        procesoMaritimoAlstroemeriaEmpaqueEdadFlor:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEdadFlor],
        procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos],
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos],
        procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento],
        procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo],
        procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad],
        procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas],
        procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue],
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR],
        procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto],
        procesoMaritimoAlstroemeriaEmpaqueEmpacoHB:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEmpacoHB],
        procesoMaritimoAlstroemeriaTransporteTemperauraCajas: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteTemperauraCajas],
        procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio],
        procesoMaritimoAlstroemeriaTransporteCamionTransporta: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteCamionTransporta],
        procesoMaritimoAlstroemeriaTransporteTemperaturaCamion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteTemperaturaCamion],
        procesoMaritimoAlstroemeriaTransporteBuenaConexion: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteBuenaConexion],
        procesoMaritimoAlstroemeriaTransporteThermoking: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteThermoking],
        procesoMaritimoAlstroemeriaTransporteCajasApiladas: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteCajasApiladas],
        procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado],
        procesoMaritimoAlstromeriaTransporteTemperaturaFurgon: json[
            DatabaseCreator
                .procesoMaritimoAlstromeriaTransporteTemperaturaFurgon],
        procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias],
        procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros],
        procesoMaritimoAlstroemeriaPalletizadoPalletsAltura: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoPalletsAltura],
        procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido],
        procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado],
        procesoMaritimoAlstroemeriaContenedorGenset:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaContenedorGenset],
        procesoMaritimoAlstroemeriaContenedorFechaFabricacion: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorFechaFabricacion],
        procesoMaritimoAlstroemeriaContenedorContenedorSeteo: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorContenedorSeteo],
        procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado],
        procesoMaritimoAlstroemeriaContenedorContenedorLavado: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorContenedorLavado],
        procesoMaritimoAlstroemeriaContenedorSachetsEthiblock: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorSachetsEthiblock],
        procesoMaritimoAlstroemeriaContenedorCierreSellado: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaContenedorCierreSellado],
        procesoMaritimoAlstroemeriaContenedorControlTemperatura: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaContenedorControlTemperatura],
        procesoMaritimoAlstroemeriaContenedorObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaContenedorObservaciones],
        procesoMaritimoAlstroemeriaPalletizadoObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaPalletizadoObservaciones],
        procesoMaritimoAlstroemeriaTransporteObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaTransporteObservaciones],
        procesoMaritimoAlstroemeriaEmpaqueObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueObservaciones],
        procesoMaritimoAlstroemeriaHidratacionObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaHidratacionObservaciones],
        procesoMaritimoAlstroemeriaTratamientoObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaTratamientoObservaciones],
        procesoMaritimoAlstroemeriaClasificacionObservaciones: json[
            DatabaseCreator
                .procesoMaritimoAlstroemeriaClasificacionObservaciones],
        procesoMaritimoAlstromeriaRecepcionObservaciones: json[
            DatabaseCreator.procesoMaritimoAlstromeriaRecepcionObservaciones],
        clienteId: json[DatabaseCreator.clienteId],
        postcosechaId: json[DatabaseCreator.postcosechaId],
        procesoMaritimoAlstroemeriaFecha:
            json[DatabaseCreator.procesoMaritimoAlstroemeriaFecha] != null
                ? DateTime.parse(
                    json[DatabaseCreator.procesoMaritimoAlstroemeriaFecha])
                : null,
      ));
    }
    return maritimo;
  }

  static Future<int> getCountProcesoMaritimoAlstroemeria() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.procesoMaritimoAlstroemeriaTable} WHERE ${DatabaseCreator.procesoMaritimoAlstroemeriaEstado}=1';
    final data = await db.rawQuery(sql);
    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addProcesoMaritimoAlstroemeria(
      ProcesoMaritimoAlstroemeria procesoMaritimo) async {
    final sql =
        '''INSERT INTO ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}
    (${DatabaseCreator.procesoMaritimoAlstroemeriaUsuarioControlId},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaNumeroGuia},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaDestinoId},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaRealizadoPor},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaAcompanamiento},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEstado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionLongitudTallos},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionLibreMaltrato},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoBaldesTinas},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoNivelSolucion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoCambioSolucion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoTiempoSala},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionNumeroRamos},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionRamosHidratados},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEdadFlor},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueEmpacoHB},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteTemperauraCajas},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteCamionTransporta},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteTemperaturaCamion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteBuenaConexion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteThermoking},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteCajasApiladas},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado},
        ${DatabaseCreator.procesoMaritimoAlstromeriaTransporteTemperaturaFurgon},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaPalletizadoPalletsAltura},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorGenset},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorFechaFabricacion},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorContenedorSeteo},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorContenedorLavado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorSachetsEthiblock},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorCierreSellado},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorControlTemperatura},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaContenedorObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaPalletizadoObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTransporteObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaEmpaqueObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaHidratacionObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaTratamientoObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaClasificacionObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstromeriaRecepcionObservaciones},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaFecha},
        ${DatabaseCreator.clienteId},
        ${DatabaseCreator.postcosechaId}
     )
    VALUES
    (
        ${procesoMaritimo.procesoMaritimoAlstroemeriaUsuarioControlId},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaNumeroGuia},
        '${procesoMaritimo.procesoMaritimoAlstroemeriaDestinoId}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaRealizadoPor}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaAcompanamiento}',
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEstado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionLongitudTallos},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionLibreMaltrato},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTratamientoBaldesTinas},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTratamientoNivelSolucion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTratamientoCambioSolucion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTratamientoTiempoSala},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaHidratacionNumeroRamos},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaHidratacionRamosHidratados},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueEdadFlor},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueEmpacoHB},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteTemperauraCajas},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteCamionTransporta},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteTemperaturaCamion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteBuenaConexion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteThermoking},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteCajasApiladas},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado},
        ${procesoMaritimo.procesoMaritimoAlstromeriaTransporteTemperaturaFurgon},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaPalletizadoPalletsAltura},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorGenset},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorFechaFabricacion},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorContenedorSeteo},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorContenedorLavado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorSachetsEthiblock},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorCierreSellado},
        ${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorControlTemperatura},
        '${procesoMaritimo.procesoMaritimoAlstroemeriaContenedorObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaPalletizadoObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaTransporteObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaEmpaqueObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaHidratacionObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaTratamientoObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaClasificacionObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstromeriaRecepcionObservaciones}',
        '${procesoMaritimo.procesoMaritimoAlstroemeriaFecha}',
        ${procesoMaritimo.clienteId},
        ${procesoMaritimo.postcosechaId}
      )''';
    return await db.rawInsert(sql);
  }

  static Future<void> deleteProcesoMaritimoAlstroemeria(int id) async {
    final sql = '''UPDATE ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}
    SET ${DatabaseCreator.procesoMaritimoAlstroemeriaEstado} = 10
    WHERE ${DatabaseCreator.procesoMaritimoAlstroemeriaId} = $id
    ''';
    await db.rawInsert(sql);
  }
}
