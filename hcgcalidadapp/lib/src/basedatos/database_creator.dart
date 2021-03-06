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
  static const actividadId = 'actividadId';
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
      $elite INTEGER
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
      $actividadFecha DATE
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

  // CREATE TABLE PROCESO HIDRATACION
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
      $temperaturaFecha DATE
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
  }
}
