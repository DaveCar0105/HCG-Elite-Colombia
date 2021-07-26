import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';
//import 'package:hcgcalidadapp/src/modelos/proceso_hidratacion.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';

////EDITAR
class DatabaseProcesoMaritimo {
  static Future<List<ProcesoMaritimo>> getAllProcesoMaritimo() async {
    final sql = 'SELECT * FROM ${DatabaseCreator.procesoMaritimoTable}';
    final data = await db.rawQuery(sql);
    List<ProcesoMaritimo> maritimo = List();
    for (final node in data) {
      // print(DatabaseCreator.procesoHidratacionPhSolucion);
      // print(node);
      maritimo.add(new ProcesoMaritimo(
        procesoMaritimoId: node[DatabaseCreator.procesoMaritimoId],
        procesoMaritimoUsuarioControlId:
            node[DatabaseCreator.procesoMaritimoUsuarioControlId],
        procesoMaritimoObservaciones:
            node[DatabaseCreator.procesoMaritimoObservaciones],
        procesoMaritimoNumeroGuia:
            node[DatabaseCreator.procesoMaritimoNumeroGuia],
        procesoMaritimoDestinoId:
            node[DatabaseCreator.procesoMaritimoDestinoId],
        procesoMaritimoRealizadoPor:
            node[DatabaseCreator.procesoMaritimoRealizadoPor],
        procesoMaritimoAcompanamiento:
            node[DatabaseCreator.procesomoMaritimoAcompanamiento],
        procesoMaritimoNombreHidratante:
            node[DatabaseCreator.procesoMaritimoNombreHidratante],
        procesoMaritimoPhSoluciones:
            node[DatabaseCreator.procesoMaritimoPhSoluciones],
        procesoMaritimoNivelSolucionTinas:
            node[DatabaseCreator.procesoMaritimoNivelSolucionTinas],
        procesoMaritimoSolucionHidratacionSinVegetal:
            node[DatabaseCreator.procesoMaritimoSolucionHidratacionSinVegetal],
        procesoMaritimoTemperaturaCuartoFrio:
            node[DatabaseCreator.procesoMaritimoTemperaturaCuartoFrio],
        procesoMaritimoTemperaturaSolucionesHidratacion: node[
            DatabaseCreator.procesoMaritimoTemperaturaSolucionesHidratacion],
        procesoMaritimoEmpaqueAmbienteTemperatura:
            node[DatabaseCreator.procesoMaritimoEmpaqueAmbienteTemperatura],
        procesoMaritimoFlorEmpacada:
            node[DatabaseCreator.procesoMaritimoFlorEmpacada],
        procesoMaritimoTransportCareEmpaque:
            node[DatabaseCreator.procesoMaritimoTransportCareEmpaque],
        procesoMaritimoCajasVisualDeformes:
            node[DatabaseCreator.procesoMaritimoCajasVisualDeformes],
        procesoMaritimoEtiquetasCajasUbicadas:
            node[DatabaseCreator.procesoMaritimoEtiquetasCajasUbicadas],
        procesoMaritimoTemperaturaCubiculoCamion:
            node[DatabaseCreator.procesoMaritimoTemperaturaCubiculoCamion],
        procesoMaritimoTemperaturaCajasTransferencia:
            node[DatabaseCreator.procesoMaritimoTemperaturaCajasTransferencia],
        procesoMaritimoAparenciaCajasTransferencia:
            node[DatabaseCreator.procesoMaritimoAparenciaCajasTransferencia],
        procesoMaritimoEstibasDebidamenteSelladas:
            node[DatabaseCreator.procesoMaritimoEstibasDebidamenteSelladas],
        procesoMaritimoPalletsEsquinerosCorrectamenteAjustados: node[
            DatabaseCreator
                .procesoMaritimoPalletsEsquinerosCorrectamenteAjustados],
        procesoMaritimoPalletsAlturaContenedor:
            node[DatabaseCreator.procesoMaritimoPalletsAlturaContenedor],
        procesoMaritimoTemperaturaPalletContenedor:
            node[DatabaseCreator.procesoMaritimoTemperaturaPalletContenedor],
        procesoMaritimoPalletIdentificadoNumero:
            node[DatabaseCreator.procesoMaritimoPalletIdentificadoNumero],
        procesoMaritimoTomaRegistroTemperaturas:
            node[DatabaseCreator.procesoMaritimoTomaRegistroTemperaturas],
        procesoMaritimoGenset: node[DatabaseCreator.procesoMaritimoGenset],
        procesoMaritimoContenedorEdadFabricacion:
            node[DatabaseCreator.procesoMaritimoContenedorEdadFabricacion],
        procesoMaritimoContenedorCumplimientoSeteo:
            node[DatabaseCreator.procesoMaritimoContenedorCumplimientoSeteo],
        procesoMaritimoContenedorPreEnfriado:
            node[DatabaseCreator.procesoMaritimoContenedorPreEnfriado],
        procesoMaritimoContenedorlavadoDesinfectado:
            node[DatabaseCreator.procesoMaritimoContenedorlavadoDesinfectado],
        procesoMartimoCarguePreviamenteHumedecidos:
            node[DatabaseCreator.procesoMaritimoCarguePreviamenteHumedecidos],
        procesoMaritimoLlegandoCierreSellado:
            node[DatabaseCreator.procesoMaritimoLlegandoCierreSellado],
        procesoMaritimoEstibasSelloICA:
            node[DatabaseCreator.procesoMaritimoEstibasSelloICA],
        procesoMaritimoPalletsTensionZunchos:
            node[DatabaseCreator.procesoMaritimoPalletsTensionZunchos],
        procesoMaritimoPalletIdentificadoEtiqueta:
            node[DatabaseCreator.procesoMaritimoPalletIdentificadoEtiqueta],
        procesoMaritimoComponentePalletDestinosEtiquetas: node[
            DatabaseCreator.procesoMaritimoComponentePalletDestinosEtiquetas],
        procesoMaritimoCamionSelloSeguridadContenedor:
            node[DatabaseCreator.procesoMaritimoCamionSelloSeguridadContenedor],
        clienteNombre: node[DatabaseCreator.clienteNombre],
        clienteId: node[DatabaseCreator.clienteId],
        postcosechaId: node[DatabaseCreator.postcosechaId],
        postcosechaNombre: node[DatabaseCreator.postcosechaNombre],
        procesoMaritimoObservacionesHidratacion:
            node[DatabaseCreator.procesoMaritimoObservacionesHidratacion],
        procesoMaritimoObservacionesEmpaque:
            node[DatabaseCreator.procesoMaritimoObservacionesEmpaque],
        procesoMaritimoObservacionesTransferencias:
            node[DatabaseCreator.procesoMaritimoObservacionesTransferencias],
        procesoMaritimoObservacionesPalletizado:
            node[DatabaseCreator.procesoMaritimoObservacionesPalletizado],
        procesoMaritimoObservacionesLlenadoContenedor:
            node[DatabaseCreator.procesoMaritimoObservacionesLlenadoContenedor],
        procesoMaritimoObservacionesRequerimientosCriticos: node[
            DatabaseCreator.procesoMaritimoObservacionesRequerimientosCriticos],
        procesoMaritimoFecha:
            DateTime.parse(node[DatabaseCreator.procesoMaritimoFecha]),
      ));
    }
    return maritimo;
  }

  static Future<int> getCountProcesoMaritimo() async {
    final sql =
        'SELECT COUNT(*) AS CANTIDAD FROM ${DatabaseCreator.procesoMaritimoTable}';
    final data = await db.rawQuery(sql);

    return data.isNotEmpty ? data.first['CANTIDAD'] : 0;
  }

  static Future<int> addProcesoMaritimo(ProcesoMaritimo procesoMaritimo) async {
    final sql = '''INSERT INTO ${DatabaseCreator.procesoMaritimoTable}
    (${DatabaseCreator.procesoMaritimoUsuarioControlId},${DatabaseCreator.procesoMaritimoObservaciones},${DatabaseCreator.procesoMaritimoNumeroGuia},
    ${DatabaseCreator.procesoMaritimoDestinoId},${DatabaseCreator.procesoMaritimoRealizadoPor},${DatabaseCreator.procesomoMaritimoAcompanamiento},${DatabaseCreator.procesoMaritimoNombreHidratante},${DatabaseCreator.procesoMaritimoPhSoluciones},
     ${DatabaseCreator.procesoMaritimoNivelSolucionTinas},${DatabaseCreator.procesoMaritimoSolucionHidratacionSinVegetal},${DatabaseCreator.procesoMaritimoTemperaturaCuartoFrio},${DatabaseCreator.procesoMaritimoTemperaturaSolucionesHidratacion},${DatabaseCreator.procesoMaritimoEmpaqueAmbienteTemperatura},
     ${DatabaseCreator.procesoMaritimoFlorEmpacada},${DatabaseCreator.procesoMaritimoTransportCareEmpaque},${DatabaseCreator.procesoMaritimoCajasVisualDeformes},${DatabaseCreator.procesoMaritimoEtiquetasCajasUbicadas},${DatabaseCreator.procesoMaritimoTemperaturaCubiculoCamion},
     ${DatabaseCreator.procesoMaritimoTemperaturaCajasTransferencia},${DatabaseCreator.procesoMaritimoAparenciaCajasTransferencia},${DatabaseCreator.procesoMaritimoEstibasDebidamenteSelladas},${DatabaseCreator.procesoMaritimoPalletsEsquinerosCorrectamenteAjustados},${DatabaseCreator.procesoMaritimoPalletsAlturaContenedor},
     ${DatabaseCreator.procesoMaritimoTemperaturaPalletContenedor},${DatabaseCreator.procesoMaritimoPalletIdentificadoNumero},${DatabaseCreator.procesoMaritimoTomaRegistroTemperaturas},${DatabaseCreator.procesoMaritimoGenset},${DatabaseCreator.procesoMaritimoContenedorEdadFabricacion},
     ${DatabaseCreator.procesoMaritimoContenedorCumplimientoSeteo},${DatabaseCreator.procesoMaritimoContenedorPreEnfriado},${DatabaseCreator.procesoMaritimoContenedorlavadoDesinfectado},${DatabaseCreator.procesoMaritimoCarguePreviamenteHumedecidos},${DatabaseCreator.procesoMaritimoLlegandoCierreSellado},
     ${DatabaseCreator.procesoMaritimoEstibasSelloICA},${DatabaseCreator.procesoMaritimoPalletsTensionZunchos},${DatabaseCreator.procesoMaritimoPalletIdentificadoEtiqueta},${DatabaseCreator.procesoMaritimoComponentePalletDestinosEtiquetas},${DatabaseCreator.procesoMaritimoCamionSelloSeguridadContenedor},
     ${DatabaseCreator.procesoMaritimoObservacionesHidratacion},${DatabaseCreator.procesoMaritimoObservacionesEmpaque},${DatabaseCreator.procesoMaritimoObservacionesTransferencias},${DatabaseCreator.procesoMaritimoObservacionesPalletizado},${DatabaseCreator.procesoMaritimoObservacionesLlenadoContenedor},
     ${DatabaseCreator.procesoMaritimoObservacionesRequerimientosCriticos},
     ${DatabaseCreator.clienteId},${DatabaseCreator.clienteNombre},${DatabaseCreator.postcosechaId}
     )
    VALUES
    (${procesoMaritimo.procesoMaritimoUsuarioControlId},'${procesoMaritimo.procesoMaritimoObservaciones}',${procesoMaritimo.procesoMaritimoNumeroGuia},
    ${procesoMaritimo.procesoMaritimoDestinoId},'${procesoMaritimo.procesoMaritimoRealizadoPor}','${procesoMaritimo.procesoMaritimoAcompanamiento}',${procesoMaritimo.procesoMaritimoNombreHidratante},${procesoMaritimo.procesoMaritimoPhSoluciones},
     ${procesoMaritimo.procesoMaritimoNivelSolucionTinas},${procesoMaritimo.procesoMaritimoSolucionHidratacionSinVegetal},${procesoMaritimo.procesoMaritimoTemperaturaCuartoFrio},${procesoMaritimo.procesoMaritimoTemperaturaSolucionesHidratacion},${procesoMaritimo.procesoMaritimoEmpaqueAmbienteTemperatura},
     ${procesoMaritimo.procesoMaritimoFlorEmpacada},${procesoMaritimo.procesoMaritimoTransportCareEmpaque},${procesoMaritimo.procesoMaritimoCajasVisualDeformes},${procesoMaritimo.procesoMaritimoEtiquetasCajasUbicadas},${procesoMaritimo.procesoMaritimoTemperaturaCubiculoCamion},
     ${procesoMaritimo.procesoMaritimoTemperaturaCajasTransferencia},${procesoMaritimo.procesoMaritimoAparenciaCajasTransferencia},${procesoMaritimo.procesoMaritimoEstibasDebidamenteSelladas},${procesoMaritimo.procesoMaritimoPalletsEsquinerosCorrectamenteAjustados},${procesoMaritimo.procesoMaritimoPalletsAlturaContenedor},
     ${procesoMaritimo.procesoMaritimoTemperaturaPalletContenedor},${procesoMaritimo.procesoMaritimoPalletIdentificadoNumero},${procesoMaritimo.procesoMaritimoTomaRegistroTemperaturas},${procesoMaritimo.procesoMaritimoGenset},${procesoMaritimo.procesoMaritimoContenedorEdadFabricacion},
     ${procesoMaritimo.procesoMaritimoContenedorCumplimientoSeteo},${procesoMaritimo.procesoMaritimoContenedorPreEnfriado},${procesoMaritimo.procesoMaritimoContenedorlavadoDesinfectado},${procesoMaritimo.procesoMartimoCarguePreviamenteHumedecidos},${procesoMaritimo.procesoMaritimoLlegandoCierreSellado},
     ${procesoMaritimo.procesoMaritimoEstibasSelloICA},${procesoMaritimo.procesoMaritimoPalletsTensionZunchos},${procesoMaritimo.procesoMaritimoPalletIdentificadoEtiqueta},${procesoMaritimo.procesoMaritimoComponentePalletDestinosEtiquetas},${procesoMaritimo.procesoMaritimoCamionSelloSeguridadContenedor},
     ${procesoMaritimo.clienteId},${procesoMaritimo.clienteNombre},${procesoMaritimo.postcosechaId},
     '${procesoMaritimo.procesoMaritimoObservacionesHidratacion}','${procesoMaritimo.procesoMaritimoObservacionesEmpaque}','${procesoMaritimo.procesoMaritimoObservacionesTransferencias}','${procesoMaritimo.procesoMaritimoObservacionesPalletizado}','${procesoMaritimo.procesoMaritimoObservacionesLlenadoContenedor}','${procesoMaritimo.procesoMaritimoObservacionesRequerimientosCriticos}'
      )''';

    return await db.rawInsert(sql);
  }
}
