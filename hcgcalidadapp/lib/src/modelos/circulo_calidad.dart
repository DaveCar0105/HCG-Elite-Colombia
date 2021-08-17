import 'dart:convert';

// CIRCULO DE CALIDAD
CirculoCalidad circuloCalidadFromJson(String str) =>
    CirculoCalidad.fromJson(json.decode(str));

String circuloCalidadToJson(CirculoCalidad data) => json.encode(data.toJson());

class CirculoCalidad {
  CirculoCalidad({
    this.circuloCalidadId,
    this.circuloCalidadRevisados,
    this.circuloCalidadRechazados,
    this.circuloCalidadPorcentajeNoConforme,
    this.circuloCalidadNumeroReunion,
    this.circuloCalidadComentario,
    this.circuloCalidadSupervisor,
    this.circuloCalidadEvaluacionSupervisor,
    this.circuloCalidadSupervisor2,
    this.circuloCalidadEvaluacionSupervisor2,
    this.circuloCalidadFecha,
    this.postcosechaId
  });

  int circuloCalidadId = 0;
  int circuloCalidadRevisados;
  int circuloCalidadRechazados;
  double circuloCalidadPorcentajeNoConforme;
  int circuloCalidadNumeroReunion;
  String circuloCalidadComentario;
  String circuloCalidadSupervisor;
  String circuloCalidadEvaluacionSupervisor;
  String circuloCalidadSupervisor2;
  String circuloCalidadEvaluacionSupervisor2;
  String circuloCalidadFecha;
  int postcosechaId;

  factory CirculoCalidad.fromJson(Map<String, dynamic> json) => CirculoCalidad(
      circuloCalidadId: json["circuloCalidadId"],
      circuloCalidadRevisados: json["circuloCalidadRevisados"],
      circuloCalidadRechazados: json["circuloCalidadRechazados"],
      circuloCalidadPorcentajeNoConforme: json["circuloCalidadPorcentajeNoConforme"],
      circuloCalidadNumeroReunion: json["circuloCalidadNumeroReunion"],
      circuloCalidadComentario: json["circuloCalidadComentario"],
      circuloCalidadSupervisor: json["circuloCalidadSupervisor"],
      circuloCalidadEvaluacionSupervisor: json["circuloCalidadEvaluacionSupervisor"],
      circuloCalidadSupervisor2: json["circuloCalidadSupervisor2"],
      circuloCalidadEvaluacionSupervisor2: json["circuloCalidadEvaluacionSupervisor2"],
      circuloCalidadFecha: json["circuloCalidadFecha"],
      postcosechaId: json["postcosechaId"]);
  Map<String, dynamic> toJson() => {
        "circuloCalidadId": circuloCalidadId,
        "circuloCalidadRevisados": circuloCalidadRevisados,
        "circuloCalidadRechazados": circuloCalidadRechazados,
        "circuloCalidadPorcentajeNoConforme": circuloCalidadPorcentajeNoConforme,
        "circuloCalidadNumeroReunion": circuloCalidadNumeroReunion,
        "circuloCalidadComentario": circuloCalidadComentario,
        "circuloCalidadSupervisor": circuloCalidadSupervisor,
        "circuloCalidadEvaluacionSupervisor": circuloCalidadEvaluacionSupervisor,
        "circuloCalidadSupervisor2": circuloCalidadSupervisor2,
        "circuloCalidadEvaluacionSupervisor2": circuloCalidadEvaluacionSupervisor2,
        "circuloCalidadFecha": circuloCalidadFecha,
        "postcosechaId": postcosechaId
      };
}

// CIRCULO DE CALIDAD PRODUCTRO
CirculoCalidadProducto circuloCalidadProductoFromJson(String str) =>
    CirculoCalidadProducto.fromJson(json.decode(str));

String circuloCalidadProductoToJson(CirculoCalidadProducto data) => json.encode(data.toJson());

class CirculoCalidadProducto {
  CirculoCalidadProducto({
    this.revisados,
    this.rechazados,
    this.porcentaje,
    this.circuloCalidadId,
    this.productoId
  });

  int revisados;
  int rechazados;
  double porcentaje;
  int circuloCalidadId;
  int productoId;

  factory CirculoCalidadProducto.fromJson(Map<String, dynamic> json) => CirculoCalidadProducto(
      revisados: json["revisados"],
      rechazados: json["rechazados"],
      porcentaje: json["porcentaje"],
      circuloCalidadId: json["circuloCalidadId"],
      productoId: json["productoId"]);

  Map<String, dynamic> toJson() => {
        "revisados": revisados,
        "rechazados": rechazados,
        "porcentaje": porcentaje,
        "circuloCalidadId": circuloCalidadId,
        "productoId": productoId
      };
}

// CIRCULO DE CALIDAD CLIENTE
CirculoCalidadCliente circuloCalidadClienteFromJson(String str) =>
    CirculoCalidadCliente.fromJson(json.decode(str));

String circuloCalidadClienteToJson(CirculoCalidadCliente data) => json.encode(data.toJson());

class CirculoCalidadCliente {
  CirculoCalidadCliente({
    this.revisados,
    this.rechazados,
    this.porcentaje,
    this.circuloCalidadId,
    this.clienteId
  });

  int revisados;
  int rechazados;
  double porcentaje;
  int circuloCalidadId;
  int clienteId;

  factory CirculoCalidadCliente.fromJson(Map<String, dynamic> json) => CirculoCalidadCliente(
      revisados: json["revisados"],
      rechazados: json["rechazados"],
      porcentaje: json["porcentaje"],
      circuloCalidadId: json["circuloCalidadId"],
      clienteId: json["clienteId"]);
      
  Map<String, dynamic> toJson() => {
        "revisados": revisados,
        "rechazados": rechazados,
        "porcentaje": porcentaje,
        "circuloCalidadId": circuloCalidadId,
        "clienteId": clienteId
      };
}

// CIRCULO DE CALIDAD FALENCIA
CirculoCalidadFalencia circuloCalidadFalenciaFromJson(String str) =>
    CirculoCalidadFalencia.fromJson(json.decode(str));

String circuloCalidadFalenciaToJson(CirculoCalidadFalencia data) => json.encode(data.toJson());

class CirculoCalidadFalencia {
  CirculoCalidadFalencia({
    this.revisados,
    this.rechazados,
    this.porcentaje,
    this.circuloCalidadId,
    this.falenciaRamosId 
  });

  int revisados;
  int rechazados;
  double porcentaje;
  int circuloCalidadId;
  int falenciaRamosId;

  factory CirculoCalidadFalencia.fromJson(Map<String, dynamic> json) => CirculoCalidadFalencia(
      revisados: json["revisados"],
      rechazados: json["rechazados"],
      porcentaje: json["porcentaje"],
      circuloCalidadId: json["circuloCalidadId"],
      falenciaRamosId : json["falenciaRamosId"]);
      
  Map<String, dynamic> toJson() => {
        "revisados": revisados,
        "rechazados": rechazados,
        "porcentaje": porcentaje,
        "circuloCalidadId": circuloCalidadId,
        "falenciaRamosId": falenciaRamosId 
      };
}

// CIRCULO DE CALIDAD VARIEDAD
CirculoCalidadVariedad circuloCalidadVariedadFromJson(String str) =>
    CirculoCalidadVariedad.fromJson(json.decode(str));

String circuloCalidadVariedadToJson(CirculoCalidadVariedad data) => json.encode(data.toJson());

class CirculoCalidadVariedad {
  CirculoCalidadVariedad({
    this.circuloCalidadVariedadId,
    this.circuloCalidadVariedadNombre,
    this.revisados,
    this.rechazados,
    this.porcentaje,
    this.circuloCalidadId
  });

  int circuloCalidadVariedadId;
  String circuloCalidadVariedadNombre;
  int revisados;
  int rechazados;
  double porcentaje;
  int circuloCalidadId;

  factory CirculoCalidadVariedad.fromJson(Map<String, dynamic> json) => CirculoCalidadVariedad(
      circuloCalidadVariedadId: json["circuloCalidadVariedadId"],
      circuloCalidadVariedadNombre: json["circuloCalidadVariedadNombre"],
      revisados: json["revisados"],
      rechazados: json["rechazados"],
      porcentaje: json["porcentaje"],
      circuloCalidadId: json["circuloCalidadId"]);
      
  Map<String, dynamic> toJson() => {
        "circuloCalidadVariedadId": circuloCalidadVariedadId,
        "circuloCalidadVariedadNombre": circuloCalidadVariedadNombre,
        "revisados": revisados,
        "rechazados": rechazados,
        "porcentaje": porcentaje,
        "circuloCalidadId": circuloCalidadId
      };
}

// CIRCULO DE CALIDAD NUMERO DE MESA
CirculoCalidadNumeroMesa circuloCalidadNumeroMesaFromJson(String str) =>
    CirculoCalidadNumeroMesa.fromJson(json.decode(str));

String circuloCalidadNumeroMesaToJson(CirculoCalidadNumeroMesa data) => json.encode(data.toJson());

class CirculoCalidadNumeroMesa {
  CirculoCalidadNumeroMesa({
    this.circuloCalidadNumeroMesaId,
    this.circuloCalidadNumeroMesaNombre,
    this.revisados,
    this.rechazados,
    this.porcentaje,
    this.circuloCalidadId
  });

  int circuloCalidadNumeroMesaId;
  String circuloCalidadNumeroMesaNombre;
  int revisados;
  int rechazados;
  double porcentaje;
  int circuloCalidadId;

  factory CirculoCalidadNumeroMesa.fromJson(Map<String, dynamic> json) => CirculoCalidadNumeroMesa(
      circuloCalidadNumeroMesaId: json["circuloCalidadNumeroMesaId"],
      circuloCalidadNumeroMesaNombre: json["circuloCalidadNumeroMesaNombre"],
      revisados: json["revisados"],
      rechazados: json["rechazados"],
      porcentaje: json["porcentaje"],
      circuloCalidadId: json["circuloCalidadId"]);
      
  Map<String, dynamic> toJson() => {
        "circuloCalidadNumeroMesaId": circuloCalidadNumeroMesaId,
        "circuloCalidadNumeroMesaNombre": circuloCalidadNumeroMesaNombre,
        "revisados": revisados,
        "rechazados": rechazados,
        "porcentaje": porcentaje,
        "circuloCalidadId": circuloCalidadId
      };
}

// CIRCULO DE CALIDAD LINEA
CirculoCalidadLinea circuloCalidadLineaFromJson(String str) =>
    CirculoCalidadLinea.fromJson(json.decode(str));

String circuloCalidadLineaToJson(CirculoCalidadLinea data) => json.encode(data.toJson());

class CirculoCalidadLinea {
  CirculoCalidadLinea({
    this.circuloCalidadLineaId,
    this.circuloCalidadLineaNombre,
    this.revisados,
    this.rechazados,
    this.porcentaje,
    this.circuloCalidadId
  });

  int circuloCalidadLineaId;
  String circuloCalidadLineaNombre;
  int revisados;
  int rechazados;
  double porcentaje;
  int circuloCalidadId;

  factory CirculoCalidadLinea.fromJson(Map<String, dynamic> json) => CirculoCalidadLinea(
      circuloCalidadLineaId: json["circuloCalidadLineaId"],
      circuloCalidadLineaNombre: json["circuloCalidadLineaNombre"],
      revisados: json["revisados"],
      rechazados: json["rechazados"],
      porcentaje: json["porcentaje"],
      circuloCalidadId: json["circuloCalidadId"]);
      
  Map<String, dynamic> toJson() => {
        "circuloCalidadLineaId": circuloCalidadLineaId,
        "circuloCalidadLineaNombre": circuloCalidadLineaNombre,
        "revisados": revisados,
        "rechazados": rechazados,
        "porcentaje": porcentaje,
        "circuloCalidadId": circuloCalidadId
      };
}

// CIRCULO DE CALIDAD INFORMACION GENERAL
CirculoCalidadInformacionGeneral circuloCalidadInformacionGeneralFromJson(String str) =>
    CirculoCalidadInformacionGeneral.fromJson(json.decode(str));

String circuloCalidadInformacionGeneralToJson(CirculoCalidadInformacionGeneral data) => json.encode(data.toJson());

class CirculoCalidadInformacionGeneral{
  CirculoCalidadInformacionGeneral({
    circuloCalidad,
    this.listaCirculoCalidadCliente,
    this.listaCirculoCalidadFalencia,
    this.listaCirculoCalidadProducto,
    this.listaCirculoCalidadVariedad,
    this.listaCirculoCalidadNumeroMesa,
    this.listaCirculoCalidadLinea
  });

  CirculoCalidad circuloCalidad;
  List<CirculoCalidadCliente> listaCirculoCalidadCliente;
  List<CirculoCalidadFalencia> listaCirculoCalidadFalencia;
  List<CirculoCalidadProducto> listaCirculoCalidadProducto;
  List<CirculoCalidadVariedad> listaCirculoCalidadVariedad;
  List<CirculoCalidadNumeroMesa> listaCirculoCalidadNumeroMesa;
  List<CirculoCalidadLinea> listaCirculoCalidadLinea;



  factory CirculoCalidadInformacionGeneral.fromJson(Map<String, dynamic> json) => CirculoCalidadInformacionGeneral(
      circuloCalidad: json["circuloCalidad"],
      listaCirculoCalidadCliente: json["listaCirculoCalidadCliente"],
      listaCirculoCalidadFalencia: json["listaCirculoCalidadFalencia"],
      listaCirculoCalidadProducto: json["listaCirculoCalidadProducto"],
      listaCirculoCalidadVariedad: json["listaCirculoCalidadVariedad"],
      listaCirculoCalidadLinea: json["listaCirculoCalidadLinea"],
      listaCirculoCalidadNumeroMesa: json["listaCirculoCalidadNumeroMesa"]);
      
  Map<String, dynamic> toJson() => {
        "circuloCalidad": circuloCalidad,
        "listaCirculoCalidadCliente": listaCirculoCalidadCliente,
        "listaCirculoCalidadFalencia": listaCirculoCalidadFalencia,
        "listaCirculoCalidadProducto": listaCirculoCalidadProducto,
        "listaCirculoCalidadVariedad": listaCirculoCalidadVariedad,
        "listaCirculoCalidadLinea": listaCirculoCalidadLinea,
        "listaCirculoCalidadNumeroMesa": listaCirculoCalidadNumeroMesa
      };
}