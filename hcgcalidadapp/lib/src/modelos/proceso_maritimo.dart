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

//------------------------ PROCESO MARITIMO ALSTROEMERIA -----------------------------------//
ProcesoMaritimoAlstroemeria procesoMaritimoAlstroemeriaFromJson(String str) =>
    ProcesoMaritimoAlstroemeria.fromJson(json.decode(str));

String procesoMaritimoAlstroemeriaToJson(ProcesoMaritimoAlstroemeria data) =>
    json.encode(data.toJson());

class ProcesoMaritimoAlstroemeria {
  ProcesoMaritimoAlstroemeria({
  this.procesoMaritimoAlstroemeriaId, 
  this.procesoMaritimoAlstroemeriaUsuarioControlId, 
  this.procesoMaritimoAlstroemeriaNumeroGuia, 
  this.procesoMaritimoAlstroemeriaDestinoId, 
  this.procesoMaritimoAlstroemeriaRealizadoPor, 
  this.procesoMaritimoAlstroemeriaAcompanamiento, 
  this.procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad, 
  this.procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta, 
  this.procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion, 
  this.procesoMaritimoAlstroemeriaClasificacionLongitudTallos, 
  this.procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal, 
  this.procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado, 
  this.procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood, 
  this.procesoMaritimoAlstroemeriaClasificacionLibreMaltrato, 
  this.procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso, 
  this.procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos, 
  this.procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo, 
  this.procesoMaritimoAlstroemeriaTratamientoBaldesTinas, 
  this.procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion, 
  this.procesoMaritimoAlstroemeriaTratamientoNivelSolucion, 
  this.procesoMaritimoAlstroemeriaTratamientoCambioSolucion, 
  this.procesoMaritimoAlstroemeriaTratamientoTiempoSala, 
  this.procesoMaritimoAlstroemeriaHidratacionNumeroRamos, 
  this.procesoMaritimoAlstroemeriaHidratacionRamosHidratados, 
  this.procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio, 
  this.procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado, 
  this.procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion, 
  this.procesoMaritimoAlstroemeriaEmpaqueEdadFlor, 
  this.procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos, 
  this.procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos, 
  this.procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento, 
  this.procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo, 
  this.procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad, 
  this.procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas, 
  this.procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue, 
  this.procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR, 
  this.procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto, 
  this.procesoMaritimoAlstroemeriaEmpaqueEmpacoHB, 
  this.procesoMaritimoAlstroemeriaTransporteTemperauraCajas, 
  this.procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio, 
  this.procesoMaritimoAlstroemeriaTransporteCamionTransporta, 
  this.procesoMaritimoAlstroemeriaTransporteTemperaturaCamion, 
  this.procesoMaritimoAlstroemeriaTransporteBuenaConexion, 
  this.procesoMaritimoAlstroemeriaTransporteThermoking, 
  this.procesoMaritimoAlstroemeriaTransporteCajasApiladas, 
  this.procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado, 
  this.procesoMaritimoAlstromeriaTransporteTemperaturaFurgon, 
  this.procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias, 
  this.procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros, 
  this.procesoMaritimoAlstroemeriaPalletizadoPalletsAltura, 
  this.procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido, 
  this.procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado, 
  this.procesoMaritimoAlstroemeriaContenedorGenset, 
  this.procesoMaritimoAlstroemeriaContenedorFechaFabricacion, 
  this.procesoMaritimoAlstroemeriaContenedorContenedorSeteo, 
  this.procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado, 
  this.procesoMaritimoAlstroemeriaContenedorContenedorLavado, 
  this.procesoMaritimoAlstroemeriaContenedorSachetsEthiblock, 
  this.procesoMaritimoAlstroemeriaContenedorCierreSellado, 
  this.procesoMaritimoAlstroemeriaContenedorControlTemperatura, 
  this.procesoMaritimoAlstroemeriaContenedorObservaciones, 
  this.procesoMaritimoAlstroemeriaPalletizadoObservaciones, 
  this.procesoMaritimoAlstroemeriaTransporteObservaciones, 
  this.procesoMaritimoAlstroemeriaEmpaqueObservaciones, 
  this.procesoMaritimoAlstroemeriaHidratacionObservaciones, 
  this.procesoMaritimoAlstroemeriaTratamientoObservaciones, 
  this.procesoMaritimoAlstroemeriaClasificacionObservaciones, 
  this.procesoMaritimoAlstromeriaRecepcionObservaciones, 
  this.clienteId, 
  this.procesoMaritimoAlstroemeriaFecha, 
  this.postcosechaId
  });

  int procesoMaritimoAlstroemeriaId;
  int procesoMaritimoAlstroemeriaUsuarioControlId;
  int procesoMaritimoAlstroemeriaNumeroGuia;
  int procesoMaritimoAlstroemeriaDestinoId;
  String procesoMaritimoAlstroemeriaRealizadoPor;
  String procesoMaritimoAlstroemeriaAcompanamiento;
  int procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad;
  int procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta;
  int procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion;
  int procesoMaritimoAlstroemeriaClasificacionLongitudTallos;
  int procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal;
  int procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado;
  int procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood;
  int procesoMaritimoAlstroemeriaClasificacionLibreMaltrato;
  int procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso;
  int procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos;
  int procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo;
  int procesoMaritimoAlstroemeriaTratamientoBaldesTinas;
  int procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion;
  int procesoMaritimoAlstroemeriaTratamientoNivelSolucion;
  int procesoMaritimoAlstroemeriaTratamientoCambioSolucion;
  int procesoMaritimoAlstroemeriaTratamientoTiempoSala;
  int procesoMaritimoAlstroemeriaHidratacionNumeroRamos;
  int procesoMaritimoAlstroemeriaHidratacionRamosHidratados;
  int procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio;
  int procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado;
  int procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion;
  int procesoMaritimoAlstroemeriaEmpaqueEdadFlor;
  int procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos;
  int procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos;
  int procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento;
  int procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo;
  int procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad;
  int procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas;
  int procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue;
  int procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR;
  int procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto;
  int procesoMaritimoAlstroemeriaEmpaqueEmpacoHB;
  int procesoMaritimoAlstroemeriaTransporteTemperauraCajas;
  int procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio;
  int procesoMaritimoAlstroemeriaTransporteCamionTransporta;
  int procesoMaritimoAlstroemeriaTransporteTemperaturaCamion;
  int procesoMaritimoAlstroemeriaTransporteBuenaConexion;
  int procesoMaritimoAlstroemeriaTransporteThermoking;
  int procesoMaritimoAlstroemeriaTransporteCajasApiladas;
  int procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado;
  int procesoMaritimoAlstromeriaTransporteTemperaturaFurgon;
  int procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias;
  int procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros;
  int procesoMaritimoAlstroemeriaPalletizadoPalletsAltura;
  int procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido;
  int procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado;
  int procesoMaritimoAlstroemeriaContenedorGenset;
  int procesoMaritimoAlstroemeriaContenedorFechaFabricacion;
  int procesoMaritimoAlstroemeriaContenedorContenedorSeteo;
  int procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado;
  int procesoMaritimoAlstroemeriaContenedorContenedorLavado;
  int procesoMaritimoAlstroemeriaContenedorSachetsEthiblock;
  int procesoMaritimoAlstroemeriaContenedorCierreSellado;
  int procesoMaritimoAlstroemeriaContenedorControlTemperatura;
  String procesoMaritimoAlstroemeriaContenedorObservaciones;
  String procesoMaritimoAlstroemeriaPalletizadoObservaciones;
  String procesoMaritimoAlstroemeriaTransporteObservaciones;
  String procesoMaritimoAlstroemeriaEmpaqueObservaciones;
  String procesoMaritimoAlstroemeriaHidratacionObservaciones;
  String procesoMaritimoAlstroemeriaTratamientoObservaciones;
  String procesoMaritimoAlstroemeriaClasificacionObservaciones;
  String procesoMaritimoAlstromeriaRecepcionObservaciones;

  int clienteId;
  DateTime procesoMaritimoAlstroemeriaFecha;
  int postcosechaId;

  factory ProcesoMaritimoAlstroemeria.fromJson(Map<String, dynamic> json) =>
      ProcesoMaritimoAlstroemeria(
       procesoMaritimoAlstroemeriaId: json["procesoMaritimoAlstroemeriaId"],
        procesoMaritimoAlstroemeriaUsuarioControlId: json["procesoMaritimoAlstroemeriaUsuarioControlId"],
        procesoMaritimoAlstroemeriaNumeroGuia: json["procesoMaritimoAlstroemeriaNumeroGuia"],
        procesoMaritimoAlstroemeriaDestinoId:
            json["procesoMaritimoAlstroemeriaDestinoId"],
        procesoMaritimoAlstroemeriaRealizadoPor: json["procesoMaritimoAlstroemeriaRealizadoPor"].toString(),
        procesoMaritimoAlstroemeriaAcompanamiento: json["procesoMaritimoAlstroemeriaAcompanamiento"].toString(),
        procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad:
            json["procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad"],
        procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta:
            json["procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta"],
        procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion:
            json["procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion"],
        procesoMaritimoAlstroemeriaClasificacionLongitudTallos: 
            json["procesoMaritimoAlstroemeriaClasificacionLongitudTallos"],
        procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal:
            json["procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal"],
        procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado:
            json["procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado"],
        procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood:
            json["procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood"],
        procesoMaritimoAlstroemeriaClasificacionLibreMaltrato:
            json["procesoMaritimoAlstroemeriaClasificacionLibreMaltrato"],
        procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso:
            json["procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso"],
        procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos: 
            json["procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos"],
        procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo:
            json["procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo"],
        procesoMaritimoAlstroemeriaTratamientoBaldesTinas:
            json["procesoMaritimoAlstroemeriaTratamientoBaldesTinas"],
        procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion:
            json["procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion"],
        procesoMaritimoAlstroemeriaTratamientoNivelSolucion:
            json["procesoMaritimoAlstroemeriaTratamientoNivelSolucion"],
        procesoMaritimoAlstroemeriaTratamientoCambioSolucion:
            json["procesoMaritimoAlstroemeriaTratamientoCambioSolucion"],
        procesoMaritimoAlstroemeriaTratamientoTiempoSala:
            json["procesoMaritimoAlstroemeriaTratamientoTiempoSala"],
        procesoMaritimoAlstroemeriaHidratacionNumeroRamos:
            json["procesoMaritimoAlstroemeriaHidratacionNumeroRamos"],
        procesoMaritimoAlstroemeriaHidratacionRamosHidratados:
            json["procesoMaritimoAlstroemeriaHidratacionRamosHidratados"],
        procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio:
            json["procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio"],
        procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado:
            json["procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado"],
        procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion:
            json["procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion"],
        procesoMaritimoAlstroemeriaEmpaqueEdadFlor:
            json["procesoMaritimoAlstroemeriaEmpaqueEdadFlor"],
        procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos: 
            json["procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos"],
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos:
            json["procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos"],
        procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento:
            json["pprocesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento"],
       procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo:
            json["procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo"],
        procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad:
            json["procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad"],
        procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas:
            json["procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas"],
        procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue:
            json["procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue"],
        procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR: 
            json["procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR"],
        procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto:
            json["procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto"],
        procesoMaritimoAlstroemeriaEmpaqueEmpacoHB:
            json["procesoMaritimoAlstroemeriaEmpaqueEmpacoHB"],
        procesoMaritimoAlstroemeriaTransporteTemperauraCajas:
            json["procesoMaritimoAlstroemeriaTransporteTemperauraCajas"],
        procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio:
            json["procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio"],
        procesoMaritimoAlstroemeriaTransporteCamionTransporta:
            json["procesoMaritimoAlstroemeriaTransporteCamionTransporta"],
        procesoMaritimoAlstroemeriaTransporteTemperaturaCamion:
            json["procesoMaritimoAlstroemeriaTransporteTemperaturaCamion"],
        procesoMaritimoAlstroemeriaTransporteBuenaConexion:
            json["procesoMaritimoAlstroemeriaTransporteBuenaConexion"],
        procesoMaritimoAlstroemeriaTransporteThermoking:
            json["procesoMaritimoAlstroemeriaTransporteThermoking"],
        procesoMaritimoAlstroemeriaTransporteCajasApiladas:
            json["procesoMaritimoAlstroemeriaTransporteCajasApiladas"],
        procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado:
            json["procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado"],
        procesoMaritimoAlstromeriaTransporteTemperaturaFurgon:
            json["procesoMaritimoAlstromeriaTransporteTemperaturaFurgon"],
        procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias:
            json["procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias"],
        procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros:
            json["procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros"],
        procesoMaritimoAlstroemeriaPalletizadoPalletsAltura:
            json["procesoMaritimoAlstroemeriaPalletizadoPalletsAltura"],
        procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido:
            json["procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido"],
        procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado:
            json["procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado"],
        procesoMaritimoAlstroemeriaContenedorGenset:
            json["procesoMaritimoAlstroemeriaContenedorGenset"],
        procesoMaritimoAlstroemeriaContenedorFechaFabricacion:
            json["procesoMaritimoAlstroemeriaContenedorFechaFabricacion"],
        procesoMaritimoAlstroemeriaContenedorContenedorSeteo:
            json["procesoMaritimoAlstroemeriaContenedorContenedorSeteo"],
        procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado:
            json["procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado"],
        procesoMaritimoAlstroemeriaContenedorContenedorLavado:
            json["procesoMaritimoAlstroemeriaContenedorContenedorLavado"],
        procesoMaritimoAlstroemeriaContenedorSachetsEthiblock:
            json["procesoMaritimoAlstroemeriaContenedorSachetsEthiblock"],
        procesoMaritimoAlstroemeriaContenedorCierreSellado:
            json["procesoMaritimoAlstroemeriaContenedorCierreSellado"],
        procesoMaritimoAlstroemeriaContenedorControlTemperatura:
            json["procesoMaritimoAlstroemeriaContenedorControlTemperatura"],
        procesoMaritimoAlstroemeriaContenedorObservaciones:
            json["procesoMaritimoAlstroemeriaContenedorObservaciones"],
        procesoMaritimoAlstroemeriaPalletizadoObservaciones:
            json["procesoMaritimoAlstroemeriaPalletizadoObservaciones"],
        procesoMaritimoAlstroemeriaTransporteObservaciones:
            json["procesoMaritimoAlstroemeriaTransporteObservaciones"],
        procesoMaritimoAlstroemeriaEmpaqueObservaciones:
            json["procesoMaritimoAlstroemeriaEmpaqueObservaciones"],
        procesoMaritimoAlstroemeriaHidratacionObservaciones:
            json["procesoMaritimoAlstroemeriaHidratacionObservaciones"],
        procesoMaritimoAlstroemeriaTratamientoObservaciones:
            json["procesoMaritimoAlstroemeriaTratamientoObservaciones"],
        procesoMaritimoAlstroemeriaClasificacionObservaciones:
            json["procesoMaritimoAlstroemeriaClasificacionObservaciones"],
        procesoMaritimoAlstromeriaRecepcionObservaciones:
            json["procesoMaritimoAlstromeriaRecepcionObservaciones"],
        clienteId: json["clienteId"],
        postcosechaId: json["postcosechaId"],
        procesoMaritimoAlstroemeriaFecha: DateTime.parse(json["procesoMaritimoAlstroemeriaFecha"]),
      );

  Map<String, dynamic> toJson() => {
        "procesoMaritimoAlstroemeriaId": procesoMaritimoAlstroemeriaId,
        "procesoMaritimoAlstroemeriaUsuarioControlId": procesoMaritimoAlstroemeriaUsuarioControlId,
        "procesoMaritimoAlstroemeriaNumeroGuia": procesoMaritimoAlstroemeriaNumeroGuia,
        "procesoMaritimoAlstroemeriaDestinoId": procesoMaritimoAlstroemeriaDestinoId,
        "procesoMaritimoAlstroemeriaRealizadoPor": procesoMaritimoAlstroemeriaRealizadoPor,
        "procesoMaritimoAlstroemeriaAcompanamiento": procesoMaritimoAlstroemeriaAcompanamiento,
        "procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad": procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad,
        "procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta": procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta,
        "procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion": procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion,
        "procesoMaritimoAlstroemeriaClasificacionLongitudTallos":
            procesoMaritimoAlstroemeriaClasificacionLongitudTallos,
        "procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal":
            procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal,
        "procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado":
            procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado,
        "procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood":
            procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood,
        "procesoMaritimoAlstroemeriaClasificacionLibreMaltrato": 
            procesoMaritimoAlstroemeriaClasificacionLibreMaltrato,
        "procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso":
            procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso,
        "procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos":
            procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos,
        "procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo":
            procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo,
        "procesoMaritimoAlstroemeriaTratamientoBaldesTinas":
            procesoMaritimoAlstroemeriaTratamientoBaldesTinas,
        "procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion":
            procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion,
        "procesoMaritimoAlstroemeriaTratamientoNivelSolucion":
            procesoMaritimoAlstroemeriaTratamientoNivelSolucion,
        "procesoMaritimoAlstroemeriaTratamientoCambioSolucion":
            procesoMaritimoAlstroemeriaTratamientoCambioSolucion,
        "procesoMaritimoAlstroemeriaTratamientoTiempoSala":
            procesoMaritimoAlstroemeriaTratamientoTiempoSala,
        "procesoMaritimoAlstroemeriaHidratacionNumeroRamos":
            procesoMaritimoAlstroemeriaHidratacionNumeroRamos,
        "procesoMaritimoAlstroemeriaHidratacionRamosHidratados":
            procesoMaritimoAlstroemeriaHidratacionRamosHidratados,
        "procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio":
            procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio,
        "procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado":
            procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado,
        "procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion": 
            procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion,
        "procesoMaritimoAlstroemeriaEmpaqueEdadFlor":
            procesoMaritimoAlstroemeriaEmpaqueEdadFlor,
        "procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos":
            procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos,
        "procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos":
            procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos,
        "procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento":
            procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento,
        "procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo":
            procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo,
        "procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad":
            procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad,
        "procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas": 
            procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas,
        "procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue":
            procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue,
        "procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR":
            procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR,
        "procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto":
            procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto,
        "procesoMaritimoAlstroemeriaEmpaqueEmpacoHB":
            procesoMaritimoAlstroemeriaEmpaqueEmpacoHB,
        "procesoMaritimoAlstroemeriaTransporteTemperauraCajas":
            procesoMaritimoAlstroemeriaTransporteTemperauraCajas,
        "procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio":
            procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio,
        "procesoMaritimoAlstroemeriaTransporteCamionTransporta":
            procesoMaritimoAlstroemeriaTransporteCamionTransporta,
        "procesoMaritimoAlstroemeriaTransporteTemperaturaCamion":
            procesoMaritimoAlstroemeriaTransporteTemperaturaCamion,
        "procesoMaritimoAlstroemeriaTransporteBuenaConexion":
            procesoMaritimoAlstroemeriaTransporteBuenaConexion,
        "procesoMaritimoAlstroemeriaTransporteThermoking":
            procesoMaritimoAlstroemeriaTransporteThermoking,
        "procesoMaritimoAlstroemeriaTransporteCajasApiladas":
            procesoMaritimoAlstroemeriaTransporteCajasApiladas,
        "procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado":
            procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado,
        "procesoMaritimoAlstromeriaTransporteTemperaturaFurgon":
            procesoMaritimoAlstromeriaTransporteTemperaturaFurgon,
        "procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias":
            procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias,
        "procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros":
            procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros,
        "procesoMaritimoAlstroemeriaPalletizadoPalletsAltura":
            procesoMaritimoAlstroemeriaPalletizadoPalletsAltura,
        "procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido":
            procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido,
        "procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado":
            procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado,
        "procesoMaritimoAlstroemeriaContenedorGenset":
            procesoMaritimoAlstroemeriaContenedorGenset,
        "procesoMaritimoAlstroemeriaContenedorFechaFabricacion":
            procesoMaritimoAlstroemeriaContenedorFechaFabricacion,
        "procesoMaritimoAlstroemeriaContenedorContenedorSeteo":
            procesoMaritimoAlstroemeriaContenedorContenedorSeteo,
        "procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado":
            procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado,
        "procesoMaritimoAlstroemeriaContenedorContenedorLavado":
            procesoMaritimoAlstroemeriaContenedorContenedorLavado,
        "procesoMaritimoAlstroemeriaContenedorSachetsEthiblock":
            procesoMaritimoAlstroemeriaContenedorSachetsEthiblock,
        "procesoMaritimoAlstroemeriaContenedorCierreSellado":
            procesoMaritimoAlstroemeriaContenedorCierreSellado,
        "procesoMaritimoAlstroemeriaContenedorControlTemperatura":
            procesoMaritimoAlstroemeriaContenedorControlTemperatura,
        "procesoMaritimoAlstroemeriaContenedorObservaciones":
            procesoMaritimoAlstroemeriaContenedorObservaciones,
        "procesoMaritimoAlstroemeriaPalletizadoObservaciones":
            procesoMaritimoAlstroemeriaPalletizadoObservaciones,
        "procesoMaritimoAlstroemeriaTransporteObservaciones":
            procesoMaritimoAlstroemeriaTransporteObservaciones,
        "procesoMaritimoAlstroemeriaEmpaqueObservaciones":
            procesoMaritimoAlstroemeriaEmpaqueObservaciones,
        "procesoMaritimoAlstroemeriaHidratacionObservaciones":
            procesoMaritimoAlstroemeriaHidratacionObservaciones,
        "procesoMaritimoAlstroemeriaTratamientoObservaciones":
            procesoMaritimoAlstroemeriaTratamientoObservaciones,
        "procesoMaritimoAlstroemeriaClasificacionObservaciones":
            procesoMaritimoAlstroemeriaClasificacionObservaciones,
        "procesoMaritimoAlstromeriaRecepcionObservaciones":
            procesoMaritimoAlstromeriaRecepcionObservaciones,
        "clienteId": clienteId,
        "postcosechaId": postcosechaId,
        "procesoMaritimoAlstroemeriaFecha": procesoMaritimoAlstroemeriaFecha.toIso8601String(),
      };
}
