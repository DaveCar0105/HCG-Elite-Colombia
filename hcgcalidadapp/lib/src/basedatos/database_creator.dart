import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

Database db;

class DatabaseCreator {
  //TABLA FINAL DE BANDA
  static const bandaId = 'bandaId';
  static const bandaTable = 'bandaTable';
  static const controlBandaId = 'controlBandaId';
  static const controlBandaTable = 'controlBanda';
  static const falenciaBandaTable = 'falenciaBanda';
  static const falenciaBandaId = 'falenciaBandaId';
  static const falenciaBandaRamos = 'falenciaBandaRamos';
  static const falenciaBandaNombres = 'falenciaBandaNombres';
  static const falenciasReporteBandaTable = 'falenciasReporteBandaTable';
  static const falenciasReporteBandaId = 'falenciasReporteBandaId';
  static const falenciasReporteBandaCantidad = 'falenciasReporteBandaCantidad';

  static const controlAlistamientoTable = 'controlAlistamiento';
  static const falenciaAlistamientoTable = 'falenciaAlistamiento';
  static const falenciaAlistamientoId = 'falenciaAlistamientoId';
  static const falenciaAlistamientoTallosMuestra =
      'falenciaAlistamientoTallosMuestra';
  static const falenciaAlistamientoTallosAfectados =
      'falenciaAlistamientoTallosAfectados';
  static const falenciaAlistamientoVariedad = 'falenciaAlistamientoVariedad';

  static const controlBoncheoTable = 'controlBoncheo';
  static const falenciaBoncheTable = 'falenciaBoncheTable';

  static const controlEcommerceTable = 'controlEcommerce';
  static const controlEcommerceId = 'controlEcommerceId';
  static const turno = 'turno';

  static const alertaEcuadorTable = 'alertaEcuador';
  static const alertaEcuadorId = 'alertaEcuadorId';
  static const variedadNombre = 'variedadNombre';
  static const tallosMuestra = 'tallosMuestra';
  static const tallosAfectados = 'tallosAfectados';

  static const problemasEcommerceTable = 'problemasEcommerce';
  static const problemasEcommerceId = 'problemasEcommerceId';
  static const problemasEcommerceNombre = 'problemasEcommerceNombre';
  static const problemasEcommerceNumero = 'problemasEcommerceNumero';
  static const problemasEcommerceTipo = 'problemasEcommerceTipo';

  static const checkEcommerceTable = 'checkEcommerce';
  static const checkEcommerceId = 'checkEcommerceId';
  static const checkEcommerceValor = 'checkEcommerceValor';

  static const controlEcuadorTable = 'controlEcuador';
  static const tipoControlTable = 'tipoControl';
  static const tipoControlId = 'tipoControlId';
  static const tipoControlNombre = 'tipoControlNombre';
  static const falenciasReporteEcuadorTable = 'falenciasReporteEcuador';
  static const claseId = 'claseId';

  static const ramosTable = 'ramos';
  static const controlRamosTable = 'controlRamos';
  static const ramosId = 'ramosId';
  static const controlRamosId = 'controlRamosId';
  static const ramosNumeroOrden = 'ramosNumeroOrden';
  static const ramosTotal = 'ramosTotal';
  static const ramosFecha = 'ramosFecha';
  static const ramosAprobado = 'ramosAprobado';
  static const ramosTallos = "ramosTallos";
  static const ramosDespachar = "ramosDespachar";
  static const ramosElaborados = "ramosElaborados";
  static const ramosDerogado = "ramosDerogado";
  static const ramosDesde = "ramosDesde";
  static const ramosHasta = "ramosHasta";
  static const ramoMarca = "ramoMarca";
  static const elite = "elite";

  static const errorTable = "error";
  static const errorDetalle = "errorDetalle";
  static const errorId = "errorId";

  static const empaqueTable = 'empaque';
  static const empaqueId = 'empaqueId';
  static const controlEmpaqueTable = 'controlEmpaque';
  static const controlEmpaqueId = 'controlEmpaqueId';
  static const empaqueNumeroOrden = 'empaqueNumeroOrden';
  static const empaqueTotal = 'empaqueTotal';
  static const empaqueRamos = 'empaqueRamos';
  static const empaqueFecha = 'empaqueFecha';
  static const empaqueAprobado = 'empaqueAprobado';
  static const empaqueTallos = "empaqueTallos";
  static const empaqueDespachar = "empaqueDespachar";
  static const empaqueDerogado = "empaqueDerogado";
  static const empaqueDesde = "empaqueDesde";
  static const empaqueHasta = "empaqueHasta";
  static const empaqueMarca = "empaqueMarca";
  static const empaqueRamosRevisar = "empaqueRamosRevisar";

  static const firmaTable = 'firma';
  static const firmaId = 'firmaId';
  static const firmaCodigo = 'firmaCodigo';
  static const firmaNombre = 'firmaNombre';
  static const firmaCargo = 'firmaCargo';
  static const firmaCorreo = 'firmaCorreo';

  //TABLA DETALLE FIRMA
  static const detalleFirmaTable = 'detalleFirma';
  static const detalleFirmaId = 'detalleFirmaId';
  static const detalleFirmaCodigo = 'detalleFirmaCodigo';
  static const detalleFirmaIdFk = 'firmaId';

  static const categoriaRamosTable = 'categoriaRamos';
  static const categoriaRamosId = 'categoriaRamosId';
  static const categoriaRamosNombre = 'categoriaRamosNombre';

  static const categoriaEmpaqueTable = 'categoriaEmpaque';
  static const categoriaEmpaqueId = 'categoriaEmpaqueId';
  static const categoriaEmpaqueNombre = 'categoriaEmpaqueNombre';

  static const falenciaRamosTable = 'falenciaRamos';
  static const falenciaRamosId = 'falenciaRamosId';
  static const falenciaRamosNombre = 'falenciaRamosNombre';

  static const falenciaEmpaqueTable = 'falenciaEmpaque';
  static const falenciaEmpaqueId = 'falenciaEmpaqueId';
  static const falenciaEmpaqueNombre = 'falenciaEmpaqueNombre';

  static const falenciasReporteRamosTable = 'falenciasReporteRamos';
  static const falenciasReporteRamosCantidad = 'falenciasReporteRamosCantidad';
  static const falenciasReporteRamosPorcentaje =
      'falenciasReporteRamosPorcentaje';
  static const falenciasReporteRamosId = 'falenciasReporteRamosId';
  static const total = 'total';

  static const falenciasReporteEmpaqueTable = 'falenciasReporteEmpaque';
  static const falenciasReporteEmpaqueCantidad =
      'falenciasReporteEmpaqueCantidad';
  static const falenciasReporteEmpaquePorcentaje =
      'falenciasReporteEmpaquePorcentaje';
  static const falenciasReporteEmpaqueId = 'falenciasReporteEmpaqueId';

  static const productoTable = 'producto';
  static const productoId = 'productoId';
  static const productoNombre = 'productoNombre';

  static const clienteTable = 'cliente';
  static const clienteId = 'clienteId';
  static const clienteNombre = 'clienteNombre';

  // TABLA ACTIVIDAD
  static const actividadTable = 'actividad';
  static const actividadTipoTable = 'actividadTipoTable';
  static const actividadId = 'actividadId';
  static const actividadTipoId = 'actividadTipoId';
  static const actividadTipoDescripcion = 'actividadTipoDescripcion';

  static const tipoActividadTable = 'tipoActividad';
  static const tipoActividadId = 'tipoActividadId';
  static const tipoActividadDescripcion = 'tipoActividadDescripcion';

  static const actividadUsuarioControlId = 'actividadUsuarioControlId';
  static const actividadDetalle = 'actividadDetalle';
  static const actividadHoraInicio = 'actividadHoraInicio';
  static const actividadHoraFin = 'actividadHoraFin';
  static const actividadFecha = 'actividadFecha';

  static const postcosechaTable = 'postcosecha';
  static const postcosechaId = 'postcosechaId';
  static const postcosechaNombre = 'postcosechaNombre';

  static const hidratacionTable = 'hidratacion';
  static const hidratacionId = 'hidratacionId';
  static const hidratacionNombre = 'hidratacionNombre';

  // TABLA PROCESO HIDRATACION
  static const procesoHidratacionTable = 'procesoHidratacion';
  static const procesoHidratacionId = 'procesoHidratacionId';
  static const procesoHidratacionUsuarioControlId =
      'procesoHidratacionUsuarioControlId';
  static const procesoHidratacionEstadoSoluciones =
      'procesoHidratacionEstadoSoluciones';
  static const procesoHidratacionTiemposHidratacion =
      'procesoHidratacionTiemposHidratacion';
  static const procesoHidratacionCantidadRamos =
      'procesoHidratacionCantidadRamos';
  static const procesoHidratacionPhSolucion = 'procesoHidratacionPhSolucion';
  static const procesoHidratacionNivelSolucion =
      'procesoHidratacionNivelSolucion';
  static const procesoHidratacionFecha = 'procesoHidratacionFecha';
  //TABLA MARITIMOS
  static const procesoMartimoMultiplesClientesTables =
      'procesoMartimoMultiplesClientesTables';

  static const procesoMaritimoTable = 'procesoMaritimoTable';
  static const procesoMaritimoId = 'procesoMaritimoId';
  static const procesoMaritimoUsuarioControlId =
      'procesoMaritimoUsuarioControlId';
  static const procesoMaritimoObservaciones = 'procesoMaritimoObservaciones';
  static const procesoMaritimoNumeroGuia = 'procesoMaritimoNumeroGuia';
  static const procesoMaritimoDestinoTable = 'procesoMaritimoDestinoTable';
  static const procesoMaritimoDestinoId = 'procesoMaritimoDestinoId';
  static const procesoMaritimoDestinoNombre = 'procesoMaritimoDestinoNombre';
  static const procesoMaritimoRealizadoPor = 'procesoMaritimoRealizadoPor';
  static const procesomoMaritimoAcompanamiento =
      'procesomoMaritimoAcompanamiento';
  static const procesoMaritimoNombreHidratante =
      'procesoMaritimoNombreHidratante';
  static const procesoMaritimoPhSoluciones = 'procesoMaritimoPhSoluciones';
  static const procesoMaritimoNivelSolucionTinas =
      'procesoMaritimoNivelSolucionTinas';
  static const procesoMaritimoSolucionHidratacionSinVegetal =
      'procesoMaritimmoSolucionHidratacionSinVegetal';
  static const procesoMaritimoTemperaturaCuartoFrio =
      'procesoMaritimoTemperaturaCuartoFrio';
  static const procesoMaritimoTemperaturaSolucionesHidratacion =
      'procesoMaritimoTemperaturaSolucionesHidratacion';
  static const procesoMaritimoEmpaqueAmbienteTemperatura =
      'procesoMaritimoEmpaqueAmbienteTemperatura';
  static const procesoMaritimoFlorEmpacada = 'procesoMaritimoFlorEmpacada';
  static const procesoMaritimoTransportCareEmpaque =
      'procesoMaritimoTransportCareEmpaque';
  static const procesoMaritimoCajasVisualDeformes =
      'procesoMaritimoCajasVisualDeformes';
  static const procesoMaritimoEtiquetasCajasUbicadas =
      'procesoMaritimoEtiquetasCajasUbicadas';
  static const procesoMaritimoTemperaturaCubiculoCamion =
      'procesoMaritimoTemperaturaCubiculoCamion';
  static const procesoMaritimoTemperaturaCajasTransferencia =
      'procesoMaritimoTemperaturaCajasTransferencia';
  static const procesoMaritimoAparenciaCajasTransferencia =
      'procesoMaritimoAparenciaCajasTransferencia';
  static const procesoMaritimoEstibasDebidamenteSelladas =
      'procesoMaritimoEstibasDebidamenteSelladas';
  static const procesoMaritimoPalletsEsquinerosCorrectamenteAjustados =
      'procesoMaritimoPalletsEsquinerosCorrectamenteAjustados';
  static const procesoMaritimoPalletsAlturaContenedor =
      'procesoMaritimoPalletsAlturaContenedor';
  static const procesoMaritimoTemperaturaPalletContenedor =
      'procesoMaritimoTemperaturaPalletContenedor';
  static const procesoMaritimoPalletIdentificadoNumero =
      'procesoMaritimoPalletIdentificadoNumero';
  static const procesoMaritimoTomaRegistroTemperaturas =
      'procesoMaritimoTomaRegistroTemperaturas';
  static const procesoMaritimoGenset = 'procesoMaritimoGenset';
  static const procesoMaritimoContenedorEdadFabricacion =
      'procesoMaritimoContenedorEdadFabricacion';
  static const procesoMaritimoContenedorCumplimientoSeteo =
      'procesoMaritimoContenedorCumplimientoSeteo';
  static const procesoMaritimoContenedorPreEnfriado =
      'procesoMaritimoContenedorPreEnfriado';
  static const procesoMaritimoContenedorlavadoDesinfectado =
      'procesoMaritimoContenedorlavadoDesinfectado';
  static const procesoMaritimoCarguePreviamenteHumedecidos =
      'procesoMaritimoCarguePreviamenteHumedecidos';
  static const procesoMaritimoLlegandoCierreSellado =
      'procesoMaritimoLlegandoCierreSellado';
  static const procesoMaritimoEstibasSelloICA =
      'procesoMaritimoEstibasSelloICA';
  static const procesoMaritimoPalletsTensionZunchos =
      'procesoMaritimoPalletsTensionZunchos';
  static const procesoMaritimoPalletIdentificadoEtiqueta =
      'procesoMaritimoPalletIdentificadoEtiqueta';
  static const procesoMaritimoComponentePalletDestinosEtiquetas =
      'procesoMaritimoComponentePalletDestinosEtiquetas';
  static const procesoMaritimoCamionSelloSeguridadContenedor =
      'procesoMaritimoCamionSelloSeguridadContenedor';
  static const procesoMaritimoVerificacionEncendidoTermografo =
      'procesoMaritimoVerificacionEncendidoTermografo';
  static const procesoMaritimoFotografiaPalletsEmpresaContenor =
      'procesoMaritimoFotografiaPalletsEmpresaContenor';
  static const procesoMaritimoObservacionesHidratacion =
      'procesoMaritimoObservacionessHidratacion';
  static const procesoMaritimoObservacionesEmpaque =
      'procesoMaritimoObservacionesEmpaque';
  static const procesoMaritimoObservacionesTransferencias =
      'procesoMaritimoObservacionesTransferencias';
  static const procesoMaritimoObservacionesPalletizado =
      'procesoMaritimoObservacionesPalletizado';
  static const procesoMaritimoObservacionesLlenadoContenedor =
      'procesoMaritimoObservacionesLlenadoContenedor';
  static const procesoMaritimoObservacionesRequerimientosCriticos =
      'procesoMaritimoObservacionesRequerimientosCriticos';
  static const procesoMaritimoFecha = 'procesoMaritimoFecha';

  // TABLA TEMPERATURA
  static const temperaturaTable = 'temperatura';
  static const temperaturaId = 'temperaturaId';
  static const temperaturaUsuarioControlId = 'usuarioControlId';
  static const temperaturaInterna1 = 'temperaturaInterna1';
  static const temperaturaInterna2 = 'temperaturaInterna2';
  static const temperaturaInterna3 = 'temperaturaInterna3';
  static const temperaturaExterna = 'temperaturaExterna';
  static const temperaturaFecha = 'temperaturaFecha';

  // TABLA PROCESO EMPAQUE
  static const procesoEmpaqueTable = 'procesoEmpaqueTable';
  static const procesoEmpaqueId = 'procesoEmpaqueId';
  static const procesoEmpaqueUsuarioControlId =
      'procesoEmpaqueUsuarioControlId';
  static const procesoEmpaqueAltura = 'procesoEmpaqueAltura';
  static const procesoEmpaqueCajas = 'procesoEmpaqueCajas';
  static const procesoEmpaqueSujeccion = 'procesoEmpaqueSujeccion';
  static const procesoEmpaqueMovimientos = 'procesoEmpaqueMovimientos';
  static const procesoEmpaqueTemperaturaCuartoFrio =
      'procesoEmpaqueTemperaturaCuartoFrio';
  static const procesoEmpaqueTemperaturaCajas =
      'procesoEmpaqueTemperaturaCajas';
  static const procesoEmpaqueTemperaturaCamion =
      'procesoEmpaqueTemperaturaCamion';
  static const procesoEmpaqueApilamiento = 'procesoEmpaqueApilamiento';
  static const procesoEmpaqueFecha = 'procesoEmpaqueFecha';

  static const usuarioId = 'usuarioId';
  //TABLA TIPO DE ACTIVIADES

  static const tipoClienteTable = 'tipoCliente';
  static const tipoClienteId = 'tipoClienteId';
  static const tipoClienteNombre = 'tipoClienteNombre';

  // TABLA CIRCULO DE CALIDAD - TABLAS ADICIONALES
  static const circuloCalidadTable = 'circuloCalidadTable';
  static const circuloCalidadId = 'circuloCalidadId';
  static const circuloCalidadRevisados = 'circuloCalidadRevisados';
  static const circuloCalidadRechazados = 'circuloCalidadRechazados';
  static const circuloCalidadPorcentajeNoConforme =
      'circuloCalidadPorcentajeNoConforme';
  static const circuloCalidadNumeroReunion = 'circuloCalidadNumeroReunion';
  static const circuloCalidadComentario = 'circuloCalidadComentario';
  static const circuloCalidadSupervisor = 'circuloCalidadSupervisor';
  static const circuloCalidadEvaluacionSupervisor =
      'circuloCalidadEvaluacionSupervisor';
  static const circuloCalidadSupervisor2 = 'circuloCalidadSupervisor2';
  static const circuloCalidadEvaluacionSupervisor2 =
      'circuloCalidadEvaluacionSupervisor2';
  static const circuloCalidadFecha = 'circuloCalidadFecha';

  static const circuloCalidadProductoTable = 'circuloCalidadProductoTable';
  static const circuloCalidadClienteTable = 'circuloCalidadClienteTable';
  static const circuloCalidadFalenciaTable = 'circuloCalidadFalenciaTable';

  static const circuloCalidadVariedadTable = 'circuloCalidadVariedadTable';
  static const circuloCalidadVariedadId = 'circuloCalidadVariedadId';
  static const circuloCalidadVariedadNombre = 'circuloCalidadVariedadNombre';

  static const circuloCalidadLineaTable = 'circuloCalidadLineaTable';
  static const circuloCalidadLineaId = 'circuloCalidadLineaId';
  static const circuloCalidadLineaNombre = 'circuloCalidadLineaNombre';

  static const circuloCalidadNumeroMesaTable = 'circuloCalidadNumeroMesaTable';
  static const circuloCalidadNumeroMesaId = 'circuloCalidadNumeroMesaId';
  static const circuloCalidadNumeroMesaNombre =
      'circuloCalidadNumeroMesaNombre';

  //--campos iguales circulo calidad
  static const circuloCalidadSameRevisados = 'revisados';
  static const circuloCalidadSameRechazados = 'rechazados';
  static const circuloCalidadSamePorcentaje = 'porcentaje';

  // CAMPOS ADICIONALES REFERENTE A HIDRATACION, FINAL DE BANDA Y EMPAQUE
  static const numeroMesa = 'numeroMesa';
  static const variedad = 'variedad';
  static const linea = 'linea';

  // PROCESO MARITIMO ALISTAMIENTO
  static const procesoMaritimoAlstroemeriaTable = 'procesoMaritimoAlistamientoTable';
  static const procesoMaritimoAlstroemeriaId = 'procesoMaritimoAlistamientoId';
  static const procesoMaritimoAlstroemeriaUsuarioControlId = 'UsuarioControlId';
  static const procesoMaritimoAlstroemeriaNumeroGuia = 'procesoMaritimoAlistamientoNumeroGuia';
  static const procesoMaritimoAlstroemeriaDestinoId = 'procesoMaritimoAlistamientoDestinoId';
  static const procesoMaritimoAlstroemeriaRealizadoPor = 'procesoMaritimoAlistamientoRealizadoPor';
  static const procesoMaritimoAlstroemeriaAcompanamiento = 'procesoMaritimoAlistamientoAcompanamiento';
  static const procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad =
      'procesomoMaritimoAlistamientoRecepcionTemperaturaHumedad';
  static const procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta =
      'procesoMaritimoAlistamientoRecepcionLavaDesinfecta';
  static const procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion =
      'procesoMaritimoAlistamientoRecepcionSistemaIdentificacion';
  static const procesoMaritimoAlstroemeriaClasificacionLongitudTallos =
      'procesoMaritimoAlstroemeriaClasificacionLongitudTallos';
  static const procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal =
      'procesoMaritimoAlistamientoClasificacionCapacitacionPersonal';
  static const procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado =
      'procesoMaritimoAlistamientoClasificacionCapuchonBiorentado';
  static const procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood =
      'procesoMaritimoAlistamientoClasificacionCapuchonFlowerFood';
  static const procesoMaritimoAlstroemeriaClasificacionLibreMaltrato =
      'procesoMaritimoAlistamientoClasificacionLibreMaltrato';
  static const procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso = 
      'procesoMaritimoAlistamientoClasificacionTallosCumplePeso';
  static const procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos =
      'procesoMaritimoAlistamientoClasificacionDespachosMaritimos';
  static const procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo =
      'procesoMaritimoAlistamientoClasificacionAseguramientoRamo';
  static const procesoMaritimoAlstroemeriaTratamientoBaldesTinas =
      'procesoMaritimoAlistamientoTratamientoBaldesTinas';
  static const procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion =
      'procesoMaritimoAlistamientoTratamientoSolucionHidratacion';
  static const procesoMaritimoAlstroemeriaTratamientoNivelSolucion =
      'procesoMaritimoAlistamientoTratamientoNivelSolucion';
  static const procesoMaritimoAlstroemeriaTratamientoCambioSolucion =
      'procesoMaritimoAlistamientoTratamientoCambioSolucion';
  static const procesoMaritimoAlstroemeriaTratamientoTiempoSala =
      'procesoMaritimoAlistamientoTratamientoTiempoSala';
  static const procesoMaritimoAlstroemeriaHidratacionNumeroRamos =
      'procesoMaritimoAlistamientoHidratacionNumeroRamos';
  static const procesoMaritimoAlstroemeriaHidratacionRamosHidratados =
      'procesoMaritimoAlistamientoHidratacionRamosHidratados';
  static const procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio =
      'procesoMaritimoAlistamientoHidratacionTemperaturaCuartoFrio';
  static const procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado =
      'procesoMaritimoAlistamientoHidratacionLimpioOrdenado';
  static const procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion =
      'procesoMaritimoAlistamientoEmpaqueEmpacadoresCapacitacion';
  static const procesoMaritimoAlstroemeriaEmpaqueEdadFlor = 'procesoMaritimoAlistamientoEmpaqueEdadFlor';
  static const procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos =
      'procesoMaritimoAlistamientoEmpaqueEscurridoRamos';
  static const procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos =
      'procesoMaritimoAlistamientoEmpaqueTemperaturaRamos';
  static const procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento =
      'procesoMaritimoAlistamientoEmpaqueCajasRequerimiento';
  static const procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo =
      'procesoMaritimoAlistamientoEmpaqueCajaDespachoMaritimo';
  static const procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad =
      'procesoMaritimoAlistamientoEmpaqueCajasDeformidad';
  static const procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas =
      'procesoMaritimoAlistamientoEmpaqueEtiquetasCajas';
  static const procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue =
      'procesoMaritimoAlistamientoEmpaqueProductoEmpaqueCargue';
  static const procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR =
      'procesoMaritimoAlistamientoEmpaqueTemperaturaHR';
  static const procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto =
      'procesoMaritimoAlistamientoEmpaqueAuditoriaProducto';
  static const procesoMaritimoAlstroemeriaEmpaqueEmpacoHB =
      'procesoMaritimoAlistamientoEmpaqueEmpacoHB';
  static const procesoMaritimoAlstroemeriaTransporteTemperauraCajas =
      'procesoMaritimoAlistamientoTransporteTemperauraCajas';
  static const procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio =
      'procesoMaritimoAlistamientoTransporteTemperaturaPromedio';
  static const procesoMaritimoAlstroemeriaTransporteCamionTransporta =
      'procesoMaritimoAlistamientoTransporteCamionTransporta';
  static const procesoMaritimoAlstroemeriaTransporteTemperaturaCamion =
      'procesoMaritimoAlistamientoTransporteTemperaturaCamion';
  static const procesoMaritimoAlstroemeriaTransporteBuenaConexion =
      'procesoMaritimoAlistamientoTransporteBuenaConexion';
  static const procesoMaritimoAlstroemeriaTransporteThermoking =
      'procesoMaritimoAlistamientoTransporteThermoking';
  static const procesoMaritimoAlstroemeriaTransporteCajasApiladas =
      'procesoMaritimoAlistamientoTransporteCajasApiladas';
  static const procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado =
      'procesoMaritimoAlistamientoTransporteAcopioPreenfriado';
  static const procesoMaritimoAlstromeriaTransporteTemperaturaFurgon =
      'procesoMaritimoAlistamientoTransporteTemperaturaFurgon';
  static const procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias =
  'procesoMaritimoAlistamientoPalletizadoEstibasLimpias';
  static const procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros =
  'procesoMaritimoAlistamientoPalletizadoPalletsEsquineros';
  static const procesoMaritimoAlstroemeriaPalletizadoPalletsAltura =
  'procesoMaritimoAlistamientoPalletizadoPalletsAltura';
  static const procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido =
  'procesoMaritimoAlistamientoPalletizadoTemperaturaDistribuido';
  static const procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado =
  'procesoMaritimoAlistamientoPalletizadoPalletIdentificado';
  static const procesoMaritimoAlstroemeriaContenedorGenset =
  'procesoMaritimoAlistamientoContenedorGenset';
  static const procesoMaritimoAlstroemeriaContenedorFechaFabricacion =
  'procesoMaritimoAlistamientoContenedorFechaFabricacion';
  static const procesoMaritimoAlstroemeriaContenedorContenedorSeteo =
  'procesoMaritimoAlistamientoContenedorContenedorSeteo';
  static const procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado =
  'procesoMaritimoAlistamientoContenedorContenedorPreenfriado';
  static const procesoMaritimoAlstroemeriaContenedorContenedorLavado =
  'procesoMaritimoAlistamientoContenedorContenedorLavado';
  static const procesoMaritimoAlstroemeriaContenedorSachetsEthiblock =
  'procesoMaritimoAlistamientoContenedorSachetsEthiblock';
  static const procesoMaritimoAlstroemeriaContenedorCierreSellado =
  'procesoMaritimoAlistamientoContenedorCierreSellado';
  static const procesoMaritimoAlstroemeriaContenedorControlTemperatura =
  'procesoMaritimoAlistamientoContenedorControlTemperatura';
  static const procesoMaritimoAlstroemeriaContenedorObservaciones =
  'procesoMaritimoAlistamientoContenedorObservaciones';
  static const procesoMaritimoAlstroemeriaPalletizadoObservaciones =
  'procesoMaritimoAlistamientoPalletizadoObservaciones';
  static const procesoMaritimoAlstroemeriaTransporteObservaciones =
  'procesoMaritimoAlistamientoTransporteObservaciones';
  static const procesoMaritimoAlstroemeriaEmpaqueObservaciones =
  'procesoMaritimoAlistamientoEmpaqueObservaciones';
  static const procesoMaritimoAlstroemeriaHidratacionObservaciones =
  'procesoMaritimoAlistamientoHidratacionObservaciones';
  static const procesoMaritimoAlstroemeriaTratamientoObservaciones =
  'procesoMaritimoAlistamientoTratamientoObservaciones';
  static const procesoMaritimoAlstroemeriaClasificacionObservaciones =
  'procesoMaritimoAlistamientoClasificacionObservaciones';
  static const procesoMaritimoAlstromeriaRecepcionObservaciones =
  'procesoMaritimoAlistamientoRecepcionObservaciones';
  static const procesoMaritimoAlstroemeriaFecha = 'procesoMaritimoAlistamientoFecha';

  //static const procesoMaritimo

  Future<void> createControlRamosTable(Database db) async {
    final ramosSql = '''CREATE TABLE $controlRamosTable
    (
      $controlRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaId INTEGER,
      $productoId INTEGER,
      $usuarioId INTEGER,
      $ramosFecha TEXT,
      $ramosNumeroOrden TEXT,
      $ramosTotal INTEGER,
      $ramosAprobado INTEGER,
      $ramosTallos INTEGER,
      $ramosDespachar INTEGER,
      $ramosElaborados INTEGER,
      $ramosDerogado TEXT,
      $postcosechaId INTEGER,
      $ramoMarca TEXT,
      $ramosDesde INTEGER,
      $ramosHasta INTEGER,
      $clienteId INTEGER,
      $elite INTEGER
    )''';
    await db.execute(ramosSql);
  }

  Future<void> createControlEcuadorTable(Database db) async {
    final ramosSql = '''CREATE TABLE $controlEcuadorTable
    (
      $controlRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaId INTEGER,
      $productoId INTEGER,
      $usuarioId INTEGER,
      $ramosFecha TEXT,
      $ramosNumeroOrden TEXT,
      $ramosTotal INTEGER,
      $ramosAprobado INTEGER,
      $ramosTallos INTEGER,
      $ramosDespachar INTEGER,
      $ramosElaborados INTEGER,
      $ramosDerogado TEXT,
      $postcosechaId INTEGER,
      $ramoMarca TEXT,
      $ramosDesde INTEGER,
      $ramosHasta INTEGER,
      $clienteId INTEGER,
      $elite INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciasReporteEcuadorTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciasReporteEcuadorTable
    (
      $falenciasReporteRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $controlRamosId INTEGER,
      $falenciasReporteRamosCantidad INTEGER,
      $falenciaRamosId INTEGER,
      $tipoControlId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createActividadesReporteEcuadorTable(Database db) async {
    final ramosSql = '''CREATE TABLE $alertaEcuadorTable
    (
      $alertaEcuadorId INTEGER PRIMARY KEY AUTOINCREMENT  ,
      $controlRamosId INTEGER,
      $tallosMuestra INTEGER,
      $productoId INTEGER,
      $falenciaRamosId INTEGER,
      $tallosAfectados INTEGER,
      $variedadNombre TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createTipoControl(Database db) async {
    final ramosSql = '''CREATE TABLE $tipoControlTable
    (
      $tipoControlId INTEGER PRIMARY KEY AUTOINCREMENT,
      $tipoControlNombre INTEGER,
      $claseId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createTipoActividad(Database db) async {
    final ramosSql = '''CREATE TABLE $tipoActividadTable
    (
      $tipoActividadId INTEGER PRIMARY KEY,
      $tipoActividadDescripcion TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createTipoCliente(Database db) async {
    final ramosSql = '''CREATE TABLE $tipoClienteTable
    (
      $tipoClienteId INTEGER PRIMARY KEY,
      $tipoClienteNombre TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createControlBoncheoTable(Database db) async {
    final ramosSql = '''CREATE TABLE $controlBoncheoTable
    (
      $controlRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaId INTEGER,
      $productoId INTEGER,
      $usuarioId INTEGER,
      $ramosFecha TEXT,
      $ramosNumeroOrden TEXT,
      $ramosTotal INTEGER,
      $ramosAprobado INTEGER,
      $ramosTallos INTEGER,
      $ramosDespachar INTEGER,
      $ramosElaborados INTEGER,
      $ramosDerogado TEXT,
      $postcosechaId INTEGER,
      $ramoMarca TEXT,
      $ramosDesde INTEGER,
      $ramosHasta INTEGER,
      $clienteId INTEGER,
      $elite INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createRamosTable(Database db) async {
    final ramosSql = '''CREATE TABLE $ramosTable
    (
      $ramosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $controlRamosId INTEGER,
      $numeroMesa TEXT,
      $variedad TEXT,
      $linea TEXT
    )''';

    await db.execute(ramosSql);
  }

  //BANDA TABLE
  Future<void> createControlBandaTable(Database db) async {
    final ramosSql = '''CREATE TABLE $controlBandaTable
    (
      $controlRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaId INTEGER,
      $productoId INTEGER,
      $usuarioId INTEGER,
      $ramosFecha TEXT,
      $ramosNumeroOrden TEXT,
      $ramosTotal INTEGER,
      $ramosAprobado INTEGER,
      $ramosTallos INTEGER,
      $ramosDespachar INTEGER,
      $ramosElaborados INTEGER,
      $ramosDerogado TEXT,
      $postcosechaId INTEGER,
      $ramoMarca TEXT,
      $ramosDesde INTEGER,
      $ramosHasta INTEGER,
      $clienteId INTEGER,
      $elite INTEGER,
      $tipoControlId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciasReporteBandaTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciasReporteBandaTable
    (
      $falenciasReporteBandaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciasReporteBandaCantidad INTEGER,
      $falenciaBandaId INTEGER,
      $bandaId INTEGER,
      $ramosId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createBandaTable(Database db) async {
    final bandaSql = ''' CREATE TABLE $bandaTable 
    (
      $bandaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $controlRamosId INTEGER,
      $controlBandaId INTEGER,
      $numeroMesa TEXT,
      $variedad TEXT,
      $linea TEXT
    )''';
    await db.execute(bandaSql);
  }

  Future<void> createFalenciaBandaTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciaBandaTable
    (
      $falenciaBandaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciaRamosId INTEGER,
      $falenciaBandaRamos INTEGER,
      $bandaId INTEGER
    )''';
    await db.execute(ramosSql);
  }

  Future<void> createFalenciaBoncheoTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciaBoncheTable
    (
      $falenciaBandaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciaRamosId INTEGER,
      $falenciaBandaRamos INTEGER,
      $controlRamosId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createControlEcommerceTable(Database db) async {
    final controlSql = '''CREATE TABLE $controlEcommerceTable
    (
      $controlEcommerceId INTEGER PRIMARY KEY AUTOINCREMENT,
      $ramosFecha TEXT,
      $postcosechaId INTEGER,
      $ramosAprobado INTEGER,
      $turno INTEGER
    )''';

    await db.execute(controlSql);
  }

  Future<void> createCheckEcommerceTable(Database db) async {
    final controlSql = '''CREATE TABLE $checkEcommerceTable
    (
      $checkEcommerceId INTEGER PRIMARY KEY AUTOINCREMENT,
      $checkEcommerceValor INTEGER,
      $problemasEcommerceId INTEGER,
      $controlEcommerceId INTEGER
    )''';

    await db.execute(controlSql);
  }

  Future<void> createProblemasEcommerceTable(Database db) async {
    final controlSql = '''CREATE TABLE $problemasEcommerceTable
    (
      $problemasEcommerceId INTEGER PRIMARY KEY,
      $problemasEcommerceNumero INTEGER,
      $problemasEcommerceNombre TEXT,
      $problemasEcommerceTipo INTEGER
    )''';

    await db.execute(controlSql);
  }

  Future<void> createFalenciaAlistamientoTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciaAlistamientoTable
    (
      $falenciaAlistamientoId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciaRamosId INTEGER,
      $productoId INTEGER,
      $falenciaAlistamientoTallosMuestra INTEGER,
      $falenciaAlistamientoTallosAfectados INTEGER,
      $falenciaAlistamientoVariedad TEXT,
      $controlRamosId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createControlEmpaqueTable(Database db) async {
    final ramosSql = '''CREATE TABLE $controlEmpaqueTable
    (
      $controlEmpaqueId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaId INTEGER,
      $usuarioId INTEGER,
      $productoId INTEGER,
      $empaqueFecha TEXT,
      $empaqueTotal INTEGER,
      $empaqueAprobado INTEGER,
      $empaqueDerogado TEXT,
      $empaqueRamosRevisar INTEGER,
      $empaqueTallos INTEGER,
      $postcosechaId INTEGER,
      $empaqueMarca TEXT,
      $clienteId INTEGER,
      $empaqueDespachar INTEGER,
      $empaqueRamos INTEGER,
      $empaqueNumeroOrden TEXT,
      $empaqueDesde INTEGER,
      $empaqueHasta INTEGER, 
      $elite INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createControlAlistamientoTable(Database db) async {
    final ramosSql = '''CREATE TABLE $controlAlistamientoTable
    (
      $controlRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaId INTEGER,
      $usuarioId INTEGER,
      $ramosFecha TEXT,
      $ramosAprobado INTEGER,
      $postcosechaId INTEGER,
      $ramosDesde INTEGER,
      $ramosHasta INTEGER,
      $clienteId INTEGER,
      $elite INTEGER,
      $tipoControlId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createEmpaqueTable(Database db) async {
    final ramosSql = '''CREATE TABLE $empaqueTable
    (
      $empaqueId INTEGER PRIMARY KEY AUTOINCREMENT,
      $controlEmpaqueId INTEGER,
      $numeroMesa TEXT,
      $variedad TEXT,
      $linea TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createClienteTable(Database db) async {
    final ramosSql = '''CREATE TABLE $clienteTable
    (
      $clienteId INTEGER PRIMARY KEY,
      $clienteNombre TEXT,
      $elite INTEGER,
      $tipoClienteId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createActividadTable(Database db) async {
    final actividadSql = '''CREATE TABLE $actividadTable
    (
      $actividadId INTEGER PRIMARY KEY,
      $actividadUsuarioControlId INTEGER,
      $actividadDetalle TEXT,
      $actividadHoraInicio TEXT,
      $actividadHoraFin TEXT,
      $postcosechaId INTEGER,
      $actividadFecha DATE,
      $tipoActividadId INTEGER
    )''';

    await db.execute(actividadSql);
  }

  Future<void> createErrorTable(Database db) async {
    final errorSql = '''CREATE TABLE $errorTable
    (
      $errorId INTEGER PRIMARY KEY AUTOINCREMENT,
      $errorDetalle TEXT
    )''';

    await db.execute(errorSql);
  }

  Future<void> createPostCosechaTable(Database db) async {
    final postcosechaSql = '''CREATE TABLE $postcosechaTable
    (
      $postcosechaId INTEGER PRIMARY KEY,
      $postcosechaNombre TEXT,
      $elite INTEGER
    )''';

    await db.execute(postcosechaSql);
  }

  Future<void> createHidratacionTable(Database db) async {
    final hidratacionSql = '''CREATE TABLE $hidratacionTable
    (
      $hidratacionId INTEGER PRIMARY KEY,
      $hidratacionNombre TEXT
    )''';

    await db.execute(hidratacionSql);
  }

  Future<void> createCategoriaRamosTable(Database db) async {
    final ramosSql = '''CREATE TABLE $categoriaRamosTable
    (
      $categoriaRamosId INTEGER PRIMARY KEY,
      $categoriaRamosNombre TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createCategoriaEmpaqueTable(Database db) async {
    final ramosSql = '''CREATE TABLE $categoriaEmpaqueTable
    (
      $categoriaEmpaqueId INTEGER PRIMARY KEY,
      $categoriaEmpaqueNombre TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciasRamosTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciaRamosTable
    (
      $falenciaRamosId INTEGER PRIMARY KEY,
      $falenciaRamosNombre TEXT,
      $categoriaRamosId INTEGER,
      $elite INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciasEmpaqueTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciaEmpaqueTable
    (
      $falenciaEmpaqueId INTEGER PRIMARY KEY,
      $falenciaEmpaqueNombre TEXT,
      $categoriaEmpaqueId INTEGER,
      $elite INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciasReporteRamosTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciasReporteRamosTable
    (
      $falenciasReporteRamosId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciasReporteRamosCantidad INTEGER,
      $falenciaRamosId INTEGER,
      $ramosId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciasReporteEmpaqueTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciasReporteEmpaqueTable
    (
      $falenciasReporteEmpaqueId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciasReporteEmpaqueCantidad INTEGER,
      $falenciaEmpaqueId INTEGER,
      $empaqueId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFirmaReportesTable(Database db) async {
    final ramosSql = '''CREATE TABLE $firmaTable
    (
      $firmaId INTEGER PRIMARY KEY,
      $firmaCodigo TEXT,
      $firmaNombre TEXT,
      $firmaCargo TEXT,
      $firmaCorreo TEXT
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createDetalleFirmaReportesTable(Database db) async {
    final ramosSql = '''CREATE TABLE $detalleFirmaTable
    (
      $detalleFirmaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $detalleFirmaCodigo TEXT,
      $firmaId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createProductoTable(Database db) async {
    final productoSql = '''CREATE TABLE $productoTable
    (
      $productoId INTEGER PRIMARY KEY,
      $productoNombre TEXT,
      $elite INTEGER
    )''';

    await db.execute(productoSql);
  }

  // CREATE TABLE CHECK HIDRATACION
  Future<void> createProcesoHidratacionTable(Database db) async {
    final procesoHidratacionSql = '''CREATE TABLE $procesoHidratacionTable
      (
        $procesoHidratacionId INTEGER PRIMARY KEY,
        $procesoHidratacionUsuarioControlId INTEGER,
        $procesoHidratacionEstadoSoluciones INTEGER,
        $procesoHidratacionTiemposHidratacion INTEGER,
        $procesoHidratacionCantidadRamos INTEGER,
        $procesoHidratacionPhSolucion NUMERIC,
        $procesoHidratacionNivelSolucion NUMERIC,
        $postcosechaId INTEGER,
        $procesoHidratacionFecha DATE
      )''';

    await db.execute(procesoHidratacionSql);
  }

  //DESTINO
  Future<void> createProcesoMaritimoDestinoTable(Database db) async {
    final procesoMaritimoDestinoSql =
        '''CREATE TABLE $procesoMaritimoDestinoTable
      (
        $procesoMaritimoDestinoId INTEGER PRIMARY KEY,
        $procesoMaritimoDestinoNombre TEXT
      )''';

    await db.execute(procesoMaritimoDestinoSql);
  }

  //MULTIPLES CLIENTES
  Future<void> MultiplesClientesMaritimoTable(Database db) async {
    final procesoMaritimoMultiplesClientesSql =
        '''CREATE TABLE $procesoMartimoMultiplesClientesTables
    (
      $clienteId INTEGER PRIMARY KEY,
      $procesoMaritimoId INTEGER
    )''';
  }

  // CREATE TABLE MARITIMO
  Future<void> createProcesoMaritimoTable(Database db) async {
    final procesoMaritimoSql = '''CREATE TABLE $procesoMaritimoTable
      (
        $procesoMaritimoId INTEGER PRIMARY KEY,
        $procesoMaritimoUsuarioControlId INTEGER,
        $procesoMaritimoNumeroGuia INTEGER,
        $procesoMaritimoDestinoId TEXT,
        $procesoMaritimoRealizadoPor TEXT,
        $procesomoMaritimoAcompanamiento TEXT,
        $procesoMaritimoNombreHidratante INTEGER,
        $procesoMaritimoPhSoluciones INTEGER,
        $procesoMaritimoNivelSolucionTinas INTEGER,
        $procesoMaritimoSolucionHidratacionSinVegetal INTEGER,
        $procesoMaritimoTemperaturaCuartoFrio  INTEGER,
        $procesoMaritimoTemperaturaSolucionesHidratacion INTEGER,
        $procesoMaritimoEmpaqueAmbienteTemperatura INTEGER,
        $procesoMaritimoFlorEmpacada INTEGER,
        $procesoMaritimoTransportCareEmpaque INTEGER,
        $procesoMaritimoCajasVisualDeformes INTEGER,
        $procesoMaritimoEtiquetasCajasUbicadas INTEGER,
        $procesoMaritimoTemperaturaCubiculoCamion INTEGER,
        $procesoMaritimoTemperaturaCajasTransferencia INTEGER,
        $procesoMaritimoAparenciaCajasTransferencia INTEGER,
        $procesoMaritimoEstibasDebidamenteSelladas INTEGER,
        $procesoMaritimoPalletsEsquinerosCorrectamenteAjustados INTEGER,
        $procesoMaritimoPalletsAlturaContenedor INTEGER,
        $procesoMaritimoTemperaturaPalletContenedor INTEGER,
        $procesoMaritimoPalletIdentificadoNumero INTEGER,
        $procesoMaritimoTomaRegistroTemperaturas INTEGER,
        $procesoMaritimoGenset INTEGER,
        $procesoMaritimoContenedorEdadFabricacion INTEGER,
        $procesoMaritimoContenedorCumplimientoSeteo INTEGER,
        $procesoMaritimoContenedorPreEnfriado INTEGER,
        $procesoMaritimoContenedorlavadoDesinfectado INTEGER,
        $procesoMaritimoCarguePreviamenteHumedecidos INTEGER,
        $procesoMaritimoLlegandoCierreSellado INTEGER,
        $procesoMaritimoEstibasSelloICA INTEGER,
        $procesoMaritimoPalletsTensionZunchos INTEGER,
        $procesoMaritimoPalletIdentificadoEtiqueta INTEGER,
        $procesoMaritimoComponentePalletDestinosEtiquetas INTEGER,
        $procesoMaritimoCamionSelloSeguridadContenedor INTEGER,
        $procesoMaritimoVerificacionEncendidoTermografo INTEGER,
        $procesoMaritimoFotografiaPalletsEmpresaContenor INTEGER,

        $procesoMaritimoObservacionesHidratacion TEXT,
        $procesoMaritimoObservacionesEmpaque TEXT,
        $procesoMaritimoObservacionesTransferencias TEXT,
        $procesoMaritimoObservacionesPalletizado TEXT,
        $procesoMaritimoObservacionesLlenadoContenedor TEXT,
        $procesoMaritimoObservacionesRequerimientosCriticos TEXT,
        $procesoMaritimoFecha DATE,
        $clienteId INTEGER,
        $postcosechaId INTEGER
      )''';
    await db.execute(procesoMaritimoSql);
  }

  // CREATE TABLE TEMPERATURA

  Future<void> createTemperaturaTable(Database db) async {
    final temperaturaSql = '''CREATE TABLE $temperaturaTable
    (
      $temperaturaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $temperaturaUsuarioControlId INTEGER,
      $temperaturaInterna1 NUMERIC,
      $temperaturaInterna2 NUMERIC,
      $temperaturaInterna3 NUMERIC,
      $temperaturaExterna NUMERIC,
      $postcosechaId INTEGER,
      $temperaturaFecha DATE,
      $clienteId INTEGER
    )''';

    await db.execute(temperaturaSql);
  }

  // CREATE TABLE PROCESO EMPAQUE
  Future<void> createProcesoEmpaqueTable(Database db) async {
    final procesoEmpaqueSql = '''CREATE TABLE $procesoEmpaqueTable
    (
      $procesoEmpaqueId INTEGER PRIMARY KEY AUTOINCREMENT,
      $procesoEmpaqueUsuarioControlId INTEGER,
      $procesoEmpaqueAltura INTEGER,
      $procesoEmpaqueCajas INTEGER,
      $procesoEmpaqueSujeccion INTEGER,
      $procesoEmpaqueMovimientos INTEGER,
      $procesoEmpaqueTemperaturaCuartoFrio INTEGER,
      $procesoEmpaqueTemperaturaCajas INTEGER,
      $procesoEmpaqueTemperaturaCamion INTEGER,
      $procesoEmpaqueApilamiento INTEGER,
      $postcosechaId INTEGER,
      $procesoEmpaqueFecha DATE
    )''';

    await db.execute(procesoEmpaqueSql);
  }

  //CREATE TABLE CIRCULO DE CALIDAD
  Future<void> createCirculoCalidad(Database db) async {
    final procesoCirculoCalidadSql = '''CREATE TABLE $circuloCalidadTable
    (
        $circuloCalidadId INTEGER PRIMARY KEY AUTOINCREMENT,
        $postcosechaId INTEGER,
        $circuloCalidadRevisados INTEGER,
        $circuloCalidadRechazados INTEGER,
        $circuloCalidadPorcentajeNoConforme FLOAT,
        $circuloCalidadNumeroReunion INTEGER,
        $circuloCalidadComentario TEXT,
        $circuloCalidadSupervisor TEXT,
        $circuloCalidadEvaluacionSupervisor TEXT,
        $circuloCalidadSupervisor2 TEXT,
        $circuloCalidadEvaluacionSupervisor2 TEXT,
        $circuloCalidadFecha DATE
    )''';

    final procesoCirculoCalidadProductoSql =
        '''CREATE TABLE $circuloCalidadProductoTable
    (
        $circuloCalidadSameRevisados INTEGER,
        $circuloCalidadSameRechazados INTEGER,
        $circuloCalidadSamePorcentaje FLOAT,
        $circuloCalidadId INTEGER,
        $productoId INTEGER
    )''';

    final procesoCirculoCalidadClienteSql =
        '''CREATE TABLE $circuloCalidadClienteTable
    (
        $circuloCalidadSameRevisados INTEGER,
        $circuloCalidadSameRechazados INTEGER,
        $circuloCalidadSamePorcentaje FLOAT,
        $circuloCalidadId INTEGER,
        $clienteId INTEGER
    )''';

    final procesoCirculoCalidadFalenciaSql =
        '''CREATE TABLE $circuloCalidadFalenciaTable
    (
        $circuloCalidadSameRevisados INTEGER,
        $circuloCalidadSameRechazados INTEGER,
        $circuloCalidadSamePorcentaje FLOAT,
        $circuloCalidadId INTEGER,
        $falenciaRamosId INTEGER
    )''';

    final procesoCirculoCalidadVariedadSql =
        '''CREATE TABLE $circuloCalidadVariedadTable
    (
        $circuloCalidadVariedadId INTEGER PRIMARY KEY AUTOINCREMENT,
        $circuloCalidadVariedadNombre TEXT,
        $circuloCalidadSameRevisados INTEGER,
        $circuloCalidadSameRechazados INTEGER,
        $circuloCalidadSamePorcentaje FLOAT,
        $circuloCalidadId INTEGER
    )''';

    final procesoCirculoCalidadNumeroMesaSql =
        '''CREATE TABLE $circuloCalidadNumeroMesaTable
    (
        $circuloCalidadNumeroMesaId INTEGER PRIMARY KEY AUTOINCREMENT,
        $circuloCalidadNumeroMesaNombre TEXT,
        $circuloCalidadSameRevisados INTEGER,
        $circuloCalidadSameRechazados INTEGER,
        $circuloCalidadSamePorcentaje FLOAT,
        $circuloCalidadId INTEGER
    )''';

    final procesoCirculoCalidadLineaSql =
        '''CREATE TABLE $circuloCalidadLineaTable
    (
        $circuloCalidadLineaId INTEGER PRIMARY KEY AUTOINCREMENT,
        $circuloCalidadLineaNombre TEXT,
        $circuloCalidadSameRevisados INTEGER,
        $circuloCalidadSameRechazados INTEGER,
        $circuloCalidadSamePorcentaje FLOAT,
        $circuloCalidadId INTEGER
    )''';
    await db.execute(procesoCirculoCalidadSql);
    await db.execute(procesoCirculoCalidadProductoSql);
    await db.execute(procesoCirculoCalidadClienteSql);
    await db.execute(procesoCirculoCalidadFalenciaSql);
    await db.execute(procesoCirculoCalidadVariedadSql);
    await db.execute(procesoCirculoCalidadNumeroMesaSql);
    await db.execute(procesoCirculoCalidadLineaSql);
  }

  Future<void> createProcesoMaritimoAlstroemeriaTable(Database db) async {

    final procesoMaritimoSql = '''CREATE TABLE $procesoMaritimoAlstroemeriaTable
      (
        $procesoMaritimoAlstroemeriaId INTEGER PRIMARY KEY,
        $procesoMaritimoAlstroemeriaUsuarioControlId INTEGER,
        $procesoMaritimoAlstroemeriaNumeroGuia INTEGER,
        $procesoMaritimoAlstroemeriaDestinoId TEXT,
        $procesoMaritimoAlstroemeriaRealizadoPor TEXT,
        $procesoMaritimoAlstroemeriaAcompanamiento TEXT,
        $procesoMaritimoAlstroemeriaRecepcionTemperaturaHumedad INTEGER,
        $procesoMaritimoAlstroemeriaRecepcionLavaDesinfecta INTEGER,
        $procesoMaritimoAlstroemeriaRecepcionSistemaIdentificacion INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionLongitudTallos INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionCapacitacionPersonal  INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionCapuchonBiorentado INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionCapuchonFlowerFood INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionLibreMaltrato INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionTallosCumplePeso INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionDespachosMaritimos INTEGER,
        $procesoMaritimoAlstroemeriaClasificacionAseguramientoRamo INTEGER,
        $procesoMaritimoAlstroemeriaTratamientoBaldesTinas INTEGER,
        $procesoMaritimoAlstroemeriaTratamientoSolucionHidratacion INTEGER,
        $procesoMaritimoAlstroemeriaTratamientoNivelSolucion INTEGER,
        $procesoMaritimoAlstroemeriaTratamientoCambioSolucion INTEGER,
        $procesoMaritimoAlstroemeriaTratamientoTiempoSala INTEGER,
        $procesoMaritimoAlstroemeriaHidratacionNumeroRamos INTEGER,
        $procesoMaritimoAlstroemeriaHidratacionRamosHidratados INTEGER,
        $procesoMaritimoAlstroemeriaHidratacionTemperaturaCuartoFrio INTEGER,
        $procesoMaritimoAlstroemeriaHidratacionLimpioOrdenado INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueEmpacadoresCapacitacion INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueEdadFlor INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueEscurridoRamos INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueTemperaturaRamos INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueCajasRequerimiento INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueCajaDespachoMaritimo INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueCajasDeformidad INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueEtiquetasCajas INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueProductoEmpaqueCargue INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueTemperaturaHR INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueAuditoriaProducto INTEGER,
        $procesoMaritimoAlstroemeriaEmpaqueEmpacoHB INTEGER,
        $procesoMaritimoAlstroemeriaTransporteTemperauraCajas INTEGER,
        $procesoMaritimoAlstroemeriaTransporteTemperaturaPromedio INTEGER,
        $procesoMaritimoAlstroemeriaTransporteCamionTransporta INTEGER,
        $procesoMaritimoAlstroemeriaTransporteTemperaturaCamion INTEGER,
        $procesoMaritimoAlstroemeriaTransporteBuenaConexion INTEGER,
        $procesoMaritimoAlstroemeriaTransporteThermoking INTEGER,
        $procesoMaritimoAlstroemeriaTransporteCajasApiladas INTEGER,
        $procesoMaritimoAlstroemeriaTransporteAcopioPreenfriado INTEGER,
        $procesoMaritimoAlstromeriaTransporteTemperaturaFurgon INTEGER,
        $procesoMaritimoAlstroemeriaPalletizadoEstibasLimpias INTEGER,
        $procesoMaritimoAlstroemeriaPalletizadoPalletsEsquineros INTEGER,
        $procesoMaritimoAlstroemeriaPalletizadoPalletsAltura INTEGER,
        $procesoMaritimoAlstroemeriaPalletizadoTemperaturaDistribuido INTEGER,
        $procesoMaritimoAlstroemeriaPalletizadoPalletIdentificado INTEGER,
        $procesoMaritimoAlstroemeriaContenedorGenset INTEGER,
        $procesoMaritimoAlstroemeriaContenedorFechaFabricacion INTEGER,
        $procesoMaritimoAlstroemeriaContenedorContenedorSeteo INTEGER,
        $procesoMaritimoAlstroemeriaContenedorContenedorPreenfriado INTEGER,
        $procesoMaritimoAlstroemeriaContenedorContenedorLavado INTEGER,
        $procesoMaritimoAlstroemeriaContenedorSachetsEthiblock INTEGER,
        $procesoMaritimoAlstroemeriaContenedorCierreSellado INTEGER,
        $procesoMaritimoAlstroemeriaContenedorControlTemperatura INTEGER,
        $procesoMaritimoAlstroemeriaContenedorObservaciones TEXT,
        $procesoMaritimoAlstroemeriaPalletizadoObservaciones TEXT,
        $procesoMaritimoAlstroemeriaTransporteObservaciones TEXT,
        $procesoMaritimoAlstroemeriaEmpaqueObservaciones TEXT,
        $procesoMaritimoAlstroemeriaHidratacionObservaciones TEXT,
        $procesoMaritimoAlstroemeriaTratamientoObservaciones TEXT,
        $procesoMaritimoAlstroemeriaClasificacionObservaciones TEXT,
        $procesoMaritimoAlstromeriaRecepcionObservaciones TEXT,
        $procesoMaritimoAlstroemeriaFecha DATE,
        $clienteId INTEGER,
        $postcosechaId INTEGER
      )''';
    await db.execute(procesoMaritimoSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, dbName);
    if (await Directory(p.dirname(path)).exists()) {
    } else {
      await Directory(p.dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('NewHcgCalidad3');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await createControlRamosTable(db);
    await createControlEmpaqueTable(db);
    await createRamosTable(db);
    await createCategoriaRamosTable(db);
    await createFalenciasRamosTable(db);
    await createFalenciasReporteRamosTable(db);
    await createProductoTable(db);
    await createClienteTable(db);
    await createHidratacionTable(db);
    await createActividadTable(db);
    await createPostCosechaTable(db);
    await createEmpaqueTable(db);
    await createFalenciasEmpaqueTable(db);
    await createFalenciasReporteEmpaqueTable(db);
    await createCategoriaEmpaqueTable(db);
    await createFirmaReportesTable(db);
    await createDetalleFirmaReportesTable(db);
    await createTemperaturaTable(db);
    await createProcesoHidratacionTable(db);
    await createProcesoEmpaqueTable(db);
    await createErrorTable(db);
    //banda
    await createBandaTable(db);
    await createFalenciaBandaTable(db);
    await createControlBandaTable(db);
    await createFalenciasReporteBandaTable(db);
    await createControlAlistamientoTable(db);
    await createFalenciaAlistamientoTable(db);
    await createControlBoncheoTable(db);
    await createFalenciaBoncheoTable(db);
    await createControlEcommerceTable(db);
    await createCheckEcommerceTable(db);
    await createProblemasEcommerceTable(db);
    await createControlEcuadorTable(db);
    await createFalenciasReporteEcuadorTable(db);
    await createActividadesReporteEcuadorTable(db);
    await createTipoControl(db);
    await createTipoActividad(db);
    await createTipoCliente(db);
    await createCirculoCalidad(db);
    await createProcesoMaritimoTable(db);
    await createProcesoMaritimoDestinoTable(db);
    await createProcesoMaritimoAlstroemeriaTable(db);
    await MultiplesClientesMaritimoTable(db);
  }
}
