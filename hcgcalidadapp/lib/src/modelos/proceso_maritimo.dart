import 'dart:convert';

ProcesoMaritimo procesoMaritimoFromJson(String str) =>
    ProcesoMaritimo.fromJson(json.decode(str));

String procesoMaritimoToJson(ProcesoMaritimo data) =>
    json.encode(data.toJson());

class ProcesoMaritimo {
  ProcesoMaritimo(
      {this.procesoMaritimoId,
      this.procesoMaritimoUsuarioControlId,
      this.procesoMaritimoNumeroGuia,
      this.procesoMaritimoDestinoId,
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
      this.procesoMaritimoVerificacionEncendidoTermografo,
      this.procesoMaritimoFotografiaPalletsEmpresaContenor,
      
      this.procesoMaritimoObservacionesHidratacion,
      this.procesoMaritimoObservacionesEmpaque,
      this.procesoMaritimoObservacionesPalletizado,
      this.procesoMaritimoObservacionesTransferencias,
      this.procesoMaritimoObservacionesLlenadoContenedor,
      this.procesoMaritimoObservacionesRequerimientosCriticos,
      this.procesoMaritimoFecha,
      this.clienteId,
      this.postcosechaId});

  int procesoMaritimoId;
  int procesoMaritimoUsuarioControlId;
  int procesoMaritimoNumeroGuia;
  int procesoMaritimoDestinoId;
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
  int procesoMaritimoVerificacionEncendidoTermografo;
  int procesoMaritimoFotografiaPalletsEmpresaContenor;

  String procesoMaritimoObservacionesHidratacion;
  String procesoMaritimoObservacionesEmpaque;
  String procesoMaritimoObservacionesTransferencias;
  String procesoMaritimoObservacionesPalletizado;
  String procesoMaritimoObservacionesLlenadoContenedor;
  String procesoMaritimoObservacionesRequerimientosCriticos;

  int clienteId;
  DateTime procesoMaritimoFecha;
  int postcosechaId;

  factory ProcesoMaritimo.fromJson(Map<String, dynamic> json) =>
      ProcesoMaritimo(
        procesoMaritimoId: json["procesoMaritimoId"],
        postcosechaId: json["postcosechaId"],
        clienteId: json["clienteId"],
        procesoMaritimoUsuarioControlId:
            json["procesoMaritimoUsuarioControlId"],
        //procesoMaritimoEstadoSoluciones: json["procesoHidratacionEstadoSoluciones"],
        procesoMaritimoNumeroGuia: json["procesoMaritimoNumeroGuia"],
        procesoMaritimoDestinoId: json["procesoMaritimoDestinoId"],
        procesoMaritimoRealizadoPor:
            json["procesoMaritimoRealizadoPor"].toString(),
        procesoMaritimoAcompanamiento:
            json["procesoMaritimoAcompanamiento"].toString(),
        procesoMaritimoNombreHidratante:
            json["procesoMaritimoNombreHidratante"],

        procesoMaritimoPhSoluciones: json["procesoMaritimoPhSoluciones"],
        procesoMaritimoNivelSolucionTinas:
            json["procesoMaritimoNivelSolucionTinas"],
        procesoMaritimoSolucionHidratacionSinVegetal:
            json["procesoMaritimoSolucionHidratacionSinVegetal"],
        procesoMaritimoTemperaturaCuartoFrio:
            json["procesoMaritimoTemperaturaCuartoFrio"],
        procesoMaritimoTemperaturaSolucionesHidratacion:
            json["procesoMaritimoTemperaturaSolucionesHidratacion"],
        procesoMaritimoEmpaqueAmbienteTemperatura:
            json["procesoMaritimoEmpaqueAmbienteTemperatura"],
        procesoMaritimoFlorEmpacada: json["procesoMaritimoFlorEmpacada"],
        procesoMaritimoTransportCareEmpaque:
            json["procesoMaritimoTransportCareEmpaque"],
        procesoMaritimoCajasVisualDeformes:
            json["procesoMaritimoCajasVisualDeformes"],
        procesoMaritimoEtiquetasCajasUbicadas:
            json["procesoMaritimoEtiquetasCajasUbicadas"],
        procesoMaritimoTemperaturaCubiculoCamion:
            json["procesoMaritimoTemperaturaCubiculoCamion"],
        procesoMaritimoTemperaturaCajasTransferencia:
            json["procesoMaritimoTemperaturaCajasTransferencia"],
        procesoMaritimoAparenciaCajasTransferencia:
            json["procesoMaritimoAparenciaCajasTransferencia"],
        procesoMaritimoEstibasDebidamenteSelladas:
            json["procesoMaritimoEstibasDebidamenteSelladas"],
        procesoMaritimoPalletsEsquinerosCorrectamenteAjustados:
            json["procesoMaritimoPalletsEsquinerosCorrectamenteAjustados"],
        procesoMaritimoPalletsAlturaContenedor:
            json["procesoMaritimoPalletsAlturaContenedor"],
        procesoMaritimoTemperaturaPalletContenedor:
            json["procesoMaritimoTemperaturaPalletContenedor"],
        procesoMaritimoPalletIdentificadoNumero:
            json["procesoMaritimoPalletIdentificadoNumero"],
        procesoMaritimoTomaRegistroTemperaturas:
            json["procesoMaritimoTomaRegistroTemperaturas"],
        procesoMaritimoGenset: json["procesoMaritimoGenset"],
        procesoMaritimoContenedorEdadFabricacion:
            json["procesoMaritimoContenedorEdadFabricacion"],
        procesoMaritimoContenedorCumplimientoSeteo:
            json["procesoMaritimoContenedorCumplimientoSeteo"],
        procesoMaritimoContenedorPreEnfriado:
            json["procesoMaritimoContenedorPreEnfriado"],
        procesoMaritimoContenedorlavadoDesinfectado:
            json["procesoMaritimoContenedorlavadoDesinfectado"],
        procesoMartimoCarguePreviamenteHumedecidos:
            json["procesoMartimoCarguePreviamenteHumedecidos"],
        procesoMaritimoLlegandoCierreSellado:
            json["procesoMaritimoLlegandoCierreSellado"],
        procesoMaritimoEstibasSelloICA: json["procesoMaritimoEstibasSelloICA"],
        procesoMaritimoPalletsTensionZunchos:
            json["procesoMaritimoPalletsTensionZunchos"],
        procesoMaritimoPalletIdentificadoEtiqueta:
            json["procesoMaritimoPalletIdentificadoEtiqueta"],
        procesoMaritimoComponentePalletDestinosEtiquetas:
            json["procesoMaritimoComponentePalletDestinosEtiquetas"],
        procesoMaritimoCamionSelloSeguridadContenedor:
            json["procesoMaritimoCamionSelloSeguridadContenedor"],
        procesoMaritimoVerificacionEncendidoTermografo:
            json["procesoMaritimoVerificacionEncendidoTermografo"],
        procesoMaritimoFotografiaPalletsEmpresaContenor:
            json["procesoMaritimoFotografiaPalletsEmpresaContenor"],

        procesoMaritimoObservacionesHidratacion:
            json["procesoMaritimoObservacionesHidratacion"],
        procesoMaritimoObservacionesEmpaque:
            json["procesoMaritimoObservacionesEmpaque"],
        procesoMaritimoObservacionesPalletizado:
            json["procesoMaritimoObservacionesPalletizado"],
        procesoMaritimoObservacionesTransferencias:
            json["procesoMaritimoObservacionesTransferencias"],
        procesoMaritimoObservacionesLlenadoContenedor:
            json["procesoMaritimoObservacionesLlenadoContenedor"],
        procesoMaritimoObservacionesRequerimientosCriticos:
            json["procesoMaritimoObservacionesRequerimientosCriticos"],

        procesoMaritimoFecha: DateTime.parse(json["procesoMaritimoFecha"]),
      );

  Map<String, dynamic> toJson() => {
        "procesoMaritimoId": procesoMaritimoId,
        "procesoMaritimoUsuarioControlId": procesoMaritimoUsuarioControlId,
        "procesoMaritimoNumeroGuia": procesoMaritimoNumeroGuia,
        "procesoMaritimoDestinoId": procesoMaritimoDestinoId,
        "procesoMaritimoRealizadoPor": procesoMaritimoRealizadoPor,
        "procesoMaritimoAcompanamiento": procesoMaritimoAcompanamiento,
        "procesoMaritimoNombreHidratante": procesoMaritimoNombreHidratante,
        "procesoMaritimoPhSoluciones": procesoMaritimoPhSoluciones,
        "procesoMaritimoNivelSolucionTinas": procesoMaritimoNivelSolucionTinas,
        "procesoMaritimoSolucionHidratacionSinVegetal":
            procesoMaritimoSolucionHidratacionSinVegetal,
        "procesoMaritimoTemperaturaCuartoFrio":
            procesoMaritimoTemperaturaCuartoFrio,
        "procesoMaritimoTemperaturaSolucionesHidratacion":
            procesoMaritimoTemperaturaSolucionesHidratacion,
        "procesoMaritimoEmpaqueAmbienteTemperatura":
            procesoMaritimoEmpaqueAmbienteTemperatura,
        "procesoMaritimoFlorEmpacada": procesoMaritimoFlorEmpacada,
        "procesoMaritimoTransportCareEmpaque":
            procesoMaritimoTransportCareEmpaque,
        "procesoMaritimoCajasVisualDeformes":
            procesoMaritimoCajasVisualDeformes,
        "procesoMaritimoEtiquetasCajasUbicadas":
            procesoMaritimoEtiquetasCajasUbicadas,
        "procesoMaritimoTemperaturaCubiculoCamion":
            procesoMaritimoTemperaturaCubiculoCamion,
        "procesoMaritimoTemperaturaCajasTransferencia":
            procesoMaritimoTemperaturaCajasTransferencia,
        "procesoMaritimoAparenciaCajasTransferencia":
            procesoMaritimoAparenciaCajasTransferencia,
        "procesoMaritimoEstibasDebidamenteSelladas":
            procesoMaritimoEstibasDebidamenteSelladas,
        "procesoMaritimoPalletsEsquinerosCorrectamenteAjustados":
            procesoMaritimoPalletsEsquinerosCorrectamenteAjustados,
        "procesoMaritimoPalletsAlturaContenedor":
            procesoMaritimoPalletsAlturaContenedor,
        "procesoMaritimoTemperaturaPalletContenedor":
            procesoMaritimoTemperaturaPalletContenedor,
        "procesoMaritimoPalletIdentificadoNumero":
            procesoMaritimoPalletIdentificadoNumero,
        "procesoMaritimoTomaRegistroTemperaturas":
            procesoMaritimoTomaRegistroTemperaturas,
        "procesoMaritimoGenset": procesoMaritimoGenset,
        "procesoMaritimoContenedorEdadFabricacion":
            procesoMaritimoContenedorEdadFabricacion,
        "procesoMaritimoContenedorCumplimientoSeteo":
            procesoMaritimoContenedorCumplimientoSeteo,
        "procesoMaritimoContenedorPreEnfriado":
            procesoMaritimoContenedorPreEnfriado,
        "procesoMaritimoContenedorlavadoDesinfectado":
            procesoMaritimoContenedorlavadoDesinfectado,
        "procesoMartimoCarguePreviamenteHumedecidos":
            procesoMartimoCarguePreviamenteHumedecidos,
        "procesoMaritimoLlegandoCierreSellado":
            procesoMaritimoLlegandoCierreSellado,
        "procesoMaritimoEstibasSelloICA": procesoMaritimoEstibasSelloICA,
        "procesoMaritimoPalletsTensionZunchos":
            procesoMaritimoPalletsTensionZunchos,
        "procesoMaritimoPalletIdentificadoEtiqueta":
            procesoMaritimoPalletIdentificadoEtiqueta,
        "procesoMaritimoComponentePalletDestinosEtiquetas":
            procesoMaritimoComponentePalletDestinosEtiquetas,
        "procesoMaritimoCamionSelloSeguridadContenedor":
            procesoMaritimoCamionSelloSeguridadContenedor,
        "procesoMaritimoVerificacionEncendidoTermografo":
            procesoMaritimoVerificacionEncendidoTermografo,
        "procesoMaritimoFotografiaPalletsEmpresaContenor":
            procesoMaritimoFotografiaPalletsEmpresaContenor,
        "procesoMaritimoObservacionesHidratacion":
            procesoMaritimoObservacionesHidratacion,
        "procesoMaritimoObservacionesEmpaque":
            procesoMaritimoObservacionesEmpaque,
        "procesoMaritimoObservacionesTransferencia":
            procesoMaritimoObservacionesTransferencias,
        "procesoMaritimoObservacionesPalletizado":
            procesoMaritimoObservacionesPalletizado,
        "procesoMaritimoObservacionesLlenadoContenedor":
            procesoMaritimoObservacionesLlenadoContenedor,
        "procesoMaritimoObservacionesRequerimientosCriticos":
            procesoMaritimoObservacionesRequerimientosCriticos,
        "clienteId": clienteId,
        "postcosechaId": postcosechaId,
        "procesoMaritimoFecha": procesoMaritimoFecha.toIso8601String(),
      };
}

class procesoMaritimoMultiplesClientes {
  procesoMaritimoMultiplesClientes(
      {this.procesoMaritimoMultiplesClientesId,
      this.procesoMaritimoMultipleId});
  int procesoMaritimoMultiplesClientesId;
  int procesoMaritimoMultipleId;

  factory procesoMaritimoMultiplesClientes.fromJson(
          Map<String, dynamic> json) =>
      procesoMaritimoMultiplesClientes(
          procesoMaritimoMultiplesClientesId:
              json["procesoMaritimoMultiplesClientesId"],
          procesoMaritimoMultipleId: json["procesoMaritimoMultipleId"]);

  Map<String, dynamic> toJson() => {
        "procesoMaritimoMultiplesClientesId":
            procesoMaritimoMultiplesClientesId,
        "procesoMaritimoMultipleId": procesoMaritimoMultipleId
      };
}
