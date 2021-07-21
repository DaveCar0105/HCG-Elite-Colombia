import 'dart:convert';

ProcesoMaritimo procesoHidratacionFromJson(String str) => ProcesoMaritimo.fromJson(json.decode(str));

String procesoHidratacionToJson(ProcesoMaritimo data) => json.encode(data.toJson());

class ProcesoMaritimo {
    ProcesoMaritimo({
        this.procesoMaritimoId,
        this.procesoMaritimoUsuarioControlId,
        this.procesoMaritimoObservaciones,
        //this.procesoMaritimoEstadoSoluciones,
        this.procesoMaritimoNumeroGuia,
        this.procesoMaritimoDestino,
        this.procesoMaritimoRealizadoPor,
        this.procesoMaritimoAcompanamiento,
        this.procesoMaritimoNombreHidratante,
        this.procesoMaritimoPhSoluciones,
        this.procesoMaritimoNivelSolucionTinas,
        this.procesoMaritimoSolucionHidratacionSinVegetal,
        this.procesoMaritimoTemperaturaCuartoFrio,
        this.procesoMaritimoTemperaturaSolucionesHidratacion,
        this.procesoMaritimoEmpaqueAmbienteTemperatura,
        this.procesoMaritimoFlorEmpacada,
        this.procesoMaritimoTransportCareEmpaque,
        this.procesoMaritimoCajasVisualDeformes,
        this.procesoMaritimoEtiquetasCajasUbicadas,
        this.procesoMaritimoTemperaturaCubiculoCamion,
        this.procesoMaritimoTemperaturaCajasTransferencia,
        this.procesoMaritimoAparenciaCajasTransferencia,
        this.procesoMaritimoEstibasDebidamenteSelladas,
        this.procesoMaritimoPalletsEsquinerosCorrectamenteAjustados,
        this.procesoMaritimoPalletsAlturaContenedor,
        this.procesoMaritimoTemperaturaPalletContenedor,
        this.procesoMaritimoPalletIdentificadoNumero,
        this.procesoMaritimoTomaRegistroTemperaturas,
        this.procesoMaritimoGenset,
        this.procesoMaritimoContenedorEdadFabricacion,
        this.procesoMaritimoContenedorCumplimientoSeteo,
        this.procesoMaritimoContenedorPreEnfriado,
        this.procesoMaritimoContenedorlavadoDesinfectado,
        this.procesoMartimoCarguePreviamenteHumedecidos,
        this.procesoMaritimoLlegandoCierreSellado,
        this.procesoMaritimoEstibasSelloICA,
        this.procesoMaritimoPalletsTensionZunchos,
        this.procesoMaritimoPalletIdentificadoEtiqueta,
        this.procesoMaritimoComponentePalletDestinosEtiquetas,
        this.procesoMaritimoCamionSelloSeguridadContenedor,
        
        this.procesoMaritimoFecha,
        this.clienteNombre,
        this.clienteId,
        this.postcosechaId,
        this.postcosechaNombre,
    });

    int procesoMaritimoId;
    int procesoMaritimoUsuarioControlId;
    String procesoMaritimoObservaciones;
   // int procesoMaritimoEstadoSoluciones;
    int procesoMaritimoNumeroGuia;
    int procesoMaritimoDestino;
    String procesoMaritimoRealizadoPor;
    String procesoMaritimoAcompanamiento;
    int procesoMaritimoNombreHidratante;
    int procesoMaritimoPhSoluciones;
    int procesoMaritimoNivelSolucionTinas;
    int procesoMaritimoSolucionHidratacionSinVegetal;
    int procesoMaritimoTemperaturaCuartoFrio;
    int procesoMaritimoTemperaturaSolucionesHidratacion;
    int procesoMaritimoEmpaqueAmbienteTemperatura;
    int procesoMaritimoFlorEmpacada;
    int procesoMaritimoTransportCareEmpaque;
    int procesoMaritimoCajasVisualDeformes;
    int procesoMaritimoEtiquetasCajasUbicadas;
    int procesoMaritimoTemperaturaCubiculoCamion;
    int procesoMaritimoTemperaturaCajasTransferencia;
    int procesoMaritimoAparenciaCajasTransferencia;
    int procesoMaritimoEstibasDebidamenteSelladas;
    int procesoMaritimoPalletsEsquinerosCorrectamenteAjustados;
    int procesoMaritimoPalletsAlturaContenedor;
    int procesoMaritimoTemperaturaPalletContenedor;
    int procesoMaritimoPalletIdentificadoNumero;
    int procesoMaritimoTomaRegistroTemperaturas;
    int procesoMaritimoGenset;
    int procesoMaritimoContenedorEdadFabricacion;
    int procesoMaritimoContenedorCumplimientoSeteo;
    int procesoMaritimoContenedorPreEnfriado;
    int procesoMaritimoContenedorlavadoDesinfectado;
    int procesoMartimoCarguePreviamenteHumedecidos;
    int procesoMaritimoLlegandoCierreSellado;

    int procesoMaritimoEstibasSelloICA;
    int procesoMaritimoPalletsTensionZunchos;
    int procesoMaritimoPalletIdentificadoEtiqueta;
    int procesoMaritimoComponentePalletDestinosEtiquetas;
    int procesoMaritimoCamionSelloSeguridadContenedor;
    
    int clienteId;
    String clienteNombre;
    DateTime procesoMaritimoFecha;
    int postcosechaId;
    String postcosechaNombre;

    factory ProcesoMaritimo.fromJson(Map<String, dynamic> json) => ProcesoMaritimo(
        procesoMaritimoId: json["procesoMaritimoId"],
        postcosechaId: json["postcosechaId"],
        postcosechaNombre: json["postcosechaNombre"],
        clienteId: json["clienteId"],
        clienteNombre: json["clienteNombre"],
        procesoMaritimoUsuarioControlId: json["procesoMaritimoUsuarioControlId"],
        //procesoMaritimoEstadoSoluciones: json["procesoHidratacionEstadoSoluciones"],
        procesoMaritimoNumeroGuia: json["procesoMaritimoNumeroGuia"],
        procesoMaritimoDestino: json["procesoMaritimoDestino"],
        procesoMaritimoRealizadoPor: json["procesoMaritimoRealizadoPor"].toString(),
        procesoMaritimoAcompanamiento: json["procesoMaritimoAcompanamiento"].toString(),
        procesoMaritimoNombreHidratante: json["procesoMaritimoNombreHidratante"],

        procesoMaritimoPhSoluciones: json["procesoMaritimoPhSoluciones"],
        procesoMaritimoNivelSolucionTinas: json["procesoMaritimoNivelSolucionTinas"],
        procesoMaritimoSolucionHidratacionSinVegetal: json["procesoMaritimoSolucionHidratacionSinVegetal"],
        procesoMaritimoTemperaturaCuartoFrio: json["procesoMaritimoTemperaturaCuartoFrio"],
        procesoMaritimoTemperaturaSolucionesHidratacion: json["procesoMaritimoTemperaturaSolucionesHidratacion"],
        procesoMaritimoEmpaqueAmbienteTemperatura: json["procesoMaritimoEmpaqueAmbienteTemperatura"],
        procesoMaritimoFlorEmpacada: json["procesoMaritimoFlorEmpacada"],
        procesoMaritimoTransportCareEmpaque: json["procesoMaritimoTransportCareEmpaque"],
        procesoMaritimoCajasVisualDeformes: json["procesoMaritimoCajasVisualDeformes"],
        procesoMaritimoEtiquetasCajasUbicadas: json["procesoMaritimoEtiquetasCajasUbicadas"],
        procesoMaritimoTemperaturaCubiculoCamion: json["procesoMaritimoTemperaturaCubiculoCamion"],
        procesoMaritimoTemperaturaCajasTransferencia : json["procesoMaritimoTemperaturaCajasTransferencia"],
        procesoMaritimoAparenciaCajasTransferencia: json["procesoMaritimoAparenciaCajasTransferencia"],
        procesoMaritimoEstibasDebidamenteSelladas: json["procesoMaritimoEstibasDebidamenteSelladas"],
        procesoMaritimoPalletsEsquinerosCorrectamenteAjustados: json["procesoMaritimoPalletsEsquinerosCorrectamenteAjustados"],
        procesoMaritimoPalletsAlturaContenedor: json["procesoMaritimoPalletsAlturaContenedor"],
        procesoMaritimoTemperaturaPalletContenedor: json["procesoMaritimoTemperaturaPalletContenedor"],
        procesoMaritimoPalletIdentificadoNumero: json["procesoMaritimoPalletIdentificadoNumero"],
        procesoMaritimoTomaRegistroTemperaturas: json["procesoMaritimoTomaRegistroTemperaturas"],
        procesoMaritimoGenset: json["procesoMaritimoGenset"],
        procesoMaritimoContenedorEdadFabricacion: json["procesoMaritimoContenedorEdadFabricacion"],
        procesoMaritimoContenedorCumplimientoSeteo: json["procesoMaritimoContenedorCumplimientoSeteo"],
        procesoMaritimoContenedorPreEnfriado: json["procesoMaritimoContenedorPreEnfriado"],
        procesoMaritimoContenedorlavadoDesinfectado: json["procesoMaritimoContenedorlavadoDesinfectado"],
        procesoMartimoCarguePreviamenteHumedecidos: json["procesoMartimoCarguePreviamenteHumedecidos"],
        procesoMaritimoLlegandoCierreSellado:json["procesoMaritimoLlegandoCierreSellado"],
        procesoMaritimoEstibasSelloICA: json["procesoMaritimoEstibasSelloICA"],
        procesoMaritimoPalletsTensionZunchos: json["procesoMaritimoPalletsTensionZunchos"],
        procesoMaritimoPalletIdentificadoEtiqueta: json["procesoMaritimoPalletIdentificadoEtiqueta"],
        procesoMaritimoComponentePalletDestinosEtiquetas: json["procesoMaritimoComponentePalletDestinosEtiquetas"],
        procesoMaritimoCamionSelloSeguridadContenedor: json["procesoMaritimoCamionSelloSeguridadContenedor"],
    


        procesoMaritimoFecha: DateTime.parse(json["procesoMaritimoFecha"]),
    );

    Map<String, dynamic> toJson() => {
        "procesoMaritimoId": procesoMaritimoId,
        "procesoMaritimoUsuarioControlId": procesoMaritimoUsuarioControlId,
        "procesoMaritimoNumeroGuia": procesoMaritimoNumeroGuia,
        "procesoMaritimoDestino": procesoMaritimoDestino,
        "procesoMaritimoRealizadoPor": procesoMaritimoRealizadoPor,
        "procesoMaritimoAcompanamiento": procesoMaritimoAcompanamiento,
        "procesoMaritimoNombreHidratante": procesoMaritimoNombreHidratante,
        "procesoMaritimoPhSoluciones": procesoMaritimoPhSoluciones,
        "procesoMaritimoNivelSolucionTinas":procesoMaritimoNivelSolucionTinas,
        "procesoMaritimoSolucionHidratacionSinVegetal":procesoMaritimoSolucionHidratacionSinVegetal,
        "procesoMaritimoTemperaturaCuartoFrio": procesoMaritimoTemperaturaCuartoFrio,
        "procesoMaritimoTemperaturaSolucionesHidratacion":procesoMaritimoTemperaturaSolucionesHidratacion,
        "procesoMaritimoEmpaqueAmbienteTemperatura":procesoMaritimoEmpaqueAmbienteTemperatura,
        "procesoMaritimoFlorEmpacada":procesoMaritimoFlorEmpacada,
        "procesoMaritimoTransportCareEmpaque": procesoMaritimoTransportCareEmpaque,
        "procesoMaritimoCajasVisualDeformes": procesoMaritimoCajasVisualDeformes,
        "procesoMaritimoEtiquetasCajasUbicadas": procesoMaritimoEtiquetasCajasUbicadas,
        "procesoMaritimoTemperaturaCubiculoCamion":procesoMaritimoTemperaturaCubiculoCamion,
        "procesoMaritimoTemperaturaCajasTransferencia": procesoMaritimoTemperaturaCajasTransferencia,
        "procesoMaritimoAparenciaCajasTransferencia": procesoMaritimoAparenciaCajasTransferencia,
        "procesoMaritimoEstibasDebidamenteSelladas": procesoMaritimoEstibasDebidamenteSelladas,
        "procesoMaritimoPalletsEsquinerosCorrectamenteAjustados" : procesoMaritimoPalletsEsquinerosCorrectamenteAjustados,
        "procesoMaritimoPalletsAlturaContenedor": procesoMaritimoPalletsAlturaContenedor,
        "procesoMaritimoTemperaturaPalletContenedor": procesoMaritimoTemperaturaPalletContenedor,
        "procesoMaritimoPalletIdentificadoNumero": procesoMaritimoPalletIdentificadoNumero,
        "procesoMaritimoTomaRegistroTemperaturas": procesoMaritimoTomaRegistroTemperaturas,
        "procesoMaritimoGenset": procesoMaritimoGenset,
        "procesoMaritimoContenedorEdadFabricacion": procesoMaritimoContenedorEdadFabricacion,
        "procesoMaritimoContenedorCumplimientoSeteo": procesoMaritimoContenedorCumplimientoSeteo,
        "procesoMaritimoContenedorPreEnfriado": procesoMaritimoContenedorPreEnfriado,
        "procesoMaritimoContenedorlavadoDesinfectado":procesoMaritimoContenedorlavadoDesinfectado,
        "procesoMartimoCarguePreviamenteHumedecidos": procesoMartimoCarguePreviamenteHumedecidos,
        "procesoMaritimoLlegandoCierreSellado": procesoMaritimoLlegandoCierreSellado,
        "procesoMaritimoEstibasSelloICA": procesoMaritimoEstibasSelloICA,
        "procesoMaritimoPalletsTensionZunchos": procesoMaritimoPalletsTensionZunchos,
        "procesoMaritimoPalletIdentificadoEtiqueta": procesoMaritimoPalletIdentificadoEtiqueta,
        "procesoMaritimoComponentePalletDestinosEtiquetas": procesoMaritimoComponentePalletDestinosEtiquetas,
        "procesoMaritimoCamionSelloSeguridadContenedor": procesoMaritimoCamionSelloSeguridadContenedor,

        "clienteId": clienteId,
        "ClienteNombre": clienteNombre,
        "postcosechaId": postcosechaId,
        "postcosechaNombre":postcosechaNombre,
        "procesoMaritimoFecha": procesoMaritimoFecha.toIso8601String(),
    };
}