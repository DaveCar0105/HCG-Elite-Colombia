import 'package:hcgcalidadapp/src/modelos/tipoActividad.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

Database db;

class DatabaseCreator {
  static const controlBandaTable = 'controlBanda';
  static const falenciaBandaTable = 'falenciaBanda';
  static const falenciaBandaId = 'falenciaBandaId';
  static const falenciaBandaRamos = 'falenciaBandaRamos';

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
  static const procesoMaritimoTable = 'procesoMaritimoTable';
  static const procesoMaritimoId = 'procesoMaritimoId';
  static const procesoMaritimoUsuarioControlId =
      'procesoMaritimoUsuarioControlId';
  static const procesoMaritimoObservaciones = 'procesoMaritimoObservaciones';
  static const procesoMaritimoNumeroGuia = 'procesoMaritimoNumeroGuia';
  static const procesoMaritimoDestino = "procesoMaritimoDestino";
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

  // TABLA CIRCULO DE CALIDAD
  static const procesoCirculoCalidadTable = 'procesoCirculoCalidadTable';
  static const procesoCirculoCalidadId = 'procesoCirculoCalidadId';
  static const procesoCirculoCalidadPoscosecha =
      'procesoCirculoCalidadPoscosecha';
  static const procesoCirculoCalidadReunion = 'procesoCirculoCalidadReunion';
  static const procesoCirculoCalidadClienteId1 =
      'procesoCirculoCalidadClienteId1';
  static const procesoCirculoCalidadClienteId2 =
      'procesoCirculoCalidadClienteId2';
  static const procesoCirculoCalidadProducto1 =
      'procesoCirculoCalidadProducto1';
  static const procesoCirculoCalidadProducto2 =
      'procesoCirculoCalidadProducto2';
  static const procesoCirculoCalidadRamosRevisados =
      'procesoCirculoCalidadRamosRevisados';
  static const procesoCirculoCalidadRamosRechazados =
      'procesoCirculoCalidadRamosRechazados';
  static const procesoCirculoCalidadProblemaId1 =
      'procesoCirculoCalidadProblema1';
  static const procesoCirculoCalidadProblemaId2 =
      'procesoCirculoCalidadProblema2';
  static const procesoCirculoCalidadProblemaId3 =
      'procesoCirculoCalidadProblema3';
  static const procesoCirculoCalidadProblemaId4 =
      'procesoCirculoCalidadProblema4';
  static const procesoCirculoCalidadProblemaId5 =
      'procesoCirculoCalidadProblema5';
  static const procesoCirculoCalidadVariedad1 =
      'procesoCirculoCalidadVariedad1';
  static const procesoCirculoCalidadVariedad2 =
      'procesoCirculoCalidadVariedad2';
  static const procesoCirculoCalidadCodigoMesa =
      'procesoCirculoCalidadCodigoMesa';
  static const procesoCirculoCalidadLinea = 'procesoCirculoCalidadLinea';
  static const procesoCirculoCalidadSupervisor1 =
      'procesoCirculoCalidadSupervisor1';
  static const procesoCirculoCalidadSupervisor2 =
      'procesoCirculoCalidadSupervisor2';
  static const procesoCirculoCalidadComentarios =
      'procesoCirculoCalidadComentarios';
  static const procesoCirculoCalidadCheckSuperviso1 =
      'procesoCirculoCalidadCheckSuperviso1';
  static const procesoCirculoCalidadCheckSuperviso2 =
      'procesoCirculoCalidadCheckSuperviso2';

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
      $controlRamosId INTEGER
    )''';

    await db.execute(ramosSql);
  }

  Future<void> createFalenciaBandaTable(Database db) async {
    final ramosSql = '''CREATE TABLE $falenciaBandaTable
    (
      $falenciaBandaId INTEGER PRIMARY KEY AUTOINCREMENT,
      $falenciaRamosId INTEGER,
      $falenciaBandaRamos INTEGER,
      $controlRamosId INTEGER
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
      $controlEmpaqueId INTEGER
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

  // CREATE TABLE MARITIMO
  Future<void> createProcesoMaritimoTable(Database db) async {
    final procesoMaritimoSql = '''CREATE TABLE $procesoMaritimoTable
      (
        $procesoMaritimoId INTEGER PRIMARY KEY,
        $procesoMaritimoUsuarioControlId INTEGER,
        $procesoMaritimoObservaciones TEXT,
        $procesoMaritimoNumeroGuia INTEGER,
        $procesoMaritimoDestino TEXT,
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

        $procesoMaritimoFecha DATE,
        $clienteId INTEGER,
        $clienteNombre TEXT,
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
    final procesoCirculoCalidadSql =
        '''CREATE TABLE $procesoCirculoCalidadTable 
    (
        $procesoCirculoCalidadId INTEGER PRIMARY KEY AUTOINCREMENT,
        $procesoCirculoCalidadPoscosecha TEXT,
        $procesoCirculoCalidadReunion INTEGER,
        $procesoCirculoCalidadClienteId1 INTEGER,
        $procesoCirculoCalidadClienteId2 INTEGER,
        $procesoCirculoCalidadProducto1 TEXT,
        $procesoCirculoCalidadProducto2 TEXT,
        $procesoCirculoCalidadRamosRevisados INTEGER,
        $procesoCirculoCalidadRamosRechazados INTEGER,
        $procesoCirculoCalidadProblemaId1 TEXT,
        $procesoCirculoCalidadProblemaId2 TEXT,
        $procesoCirculoCalidadProblemaId3 TEXT,
        $procesoCirculoCalidadProblemaId4 TEXT,
        $procesoCirculoCalidadProblemaId5 TEXT,
        $procesoCirculoCalidadVariedad1 TEXT,
        $procesoCirculoCalidadVariedad2 TEXT,
        $procesoCirculoCalidadCodigoMesa INTEGER,
        $procesoCirculoCalidadLinea INTEGER,
        $procesoCirculoCalidadCheckSuperviso1 TEXT,
        $procesoCirculoCalidadCheckSuperviso2 TEXT,
        $procesoCirculoCalidadComentarios TEXT,
        $procesoCirculoCalidadSupervisor1 TEXT,
        $procesoCirculoCalidadSupervisor2 TEXT
    )''';
    await db.execute(procesoCirculoCalidadSql);
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
    await createFalenciaBandaTable(db);
    await createControlBandaTable(db);
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
  }
}
