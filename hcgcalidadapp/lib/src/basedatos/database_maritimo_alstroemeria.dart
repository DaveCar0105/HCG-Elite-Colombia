import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';

////EDITAR
class DatabaseProcesoMaritimoAlstroemeria {
  static Future<List<ProcesoMaritimoAlstroemeria>> getAllProcesoMaritimoAlstromeria() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}';
    final data = await db.rawQuery(sql);
    List<ProcesoMaritimoAlstroemeria> maritimo = data as List<ProcesoMaritimoAlstroemeria>;
    return maritimo;
  }

  static Future<int> getCountProcesoMaritimoAlstroemeria() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}';
    final data = await db.rawQuery(sql);
    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addProcesoMaritimoAlstroemeria(ProcesoMaritimoAlstroemeria procesoMaritimo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.procesoMaritimoAlstroemeriaTable}
    (${DatabaseCreator.procesoMaritimoAlstroemeriaUsuarioControlId},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaNumeroGuia},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaDestinoId},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaRealizadoPor},
        ${DatabaseCreator.procesoMaritimoAlstroemeriaAcompanamiento},
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
}
