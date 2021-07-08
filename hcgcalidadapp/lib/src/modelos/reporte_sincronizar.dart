// To parse this JSON data, do
//
//     final reporteSincronizar = reporteSincronizarFromJson(jsonString);

import 'dart:convert';

ReporteSincronizar reporteSincronizarFromJson(String str) => ReporteSincronizar.fromJson(json.decode(str));

String reporteSincronizarToJson(ReporteSincronizar data) => json.encode(data.toJson());

class ReporteSincronizar {
  ReporteSincronizar({
    this.firmaCadena,
    this.firmaNombre,
    this.firmaCargo,
    this.reporteId,
    this.ramosElaborados,
    this.ramosDespachados,
    this.ramosRevisados,
    this.tallosPorRamo,
    this.postCosechaId,
    this.marca,
    this.clienteId,
    this.productoId,
    this.numeroOrden,
    this.derogacion,
    this.falenciaId,
    this.falenciaCantidad,
    this.tipo,
    this.cajasDespachar,
    this.cajasRevisar,
    this.ramosCaja,
    this.duracion,
    this.firmaId,
    this.fecha,
    this.usuarioId,
  });

  String firmaCadena;
  String firmaNombre;
  String firmaCargo;
  int reporteId;
  int ramosElaborados;
  int ramosDespachados;
  int ramosRevisados;
  int tallosPorRamo;
  int postCosechaId;
  String marca;
  int clienteId;
  int productoId;
  String numeroOrden;
  String derogacion;
  int falenciaId;
  int falenciaCantidad;
  bool tipo;
  int cajasDespachar;
  int cajasRevisar;
  int ramosCaja;
  int duracion;
  int firmaId;
  String fecha;
  int usuarioId;

  factory ReporteSincronizar.fromJson(Map<String, dynamic> json) => ReporteSincronizar(
    firmaCadena: json["firmaCadena"],
    firmaNombre: json["firmaNombre"],
    firmaCargo: json["firmaCargo"],
    reporteId: json["reporteId"],
    ramosElaborados: json["ramosElaborados"],
    ramosDespachados: json["ramosDespachados"],
    ramosRevisados: json["ramosRevisados"],
    tallosPorRamo: json["tallosPorRamo"],
    postCosechaId: json["postCosechaId"],
    marca: json["marca"],
    clienteId: json["clienteId"],
    productoId: json["productoId"],
    numeroOrden: json["numeroOrden"],
    derogacion: json["derogacion"],
    falenciaId: json["falenciaId"],
    falenciaCantidad: json["falenciaCantidad"],
    tipo: json["tipo"],
    cajasDespachar: json["cajasDespachar"],
    cajasRevisar: json["cajasRevisar"],
    ramosCaja: json["ramosCaja"],
    duracion: json["duracion"],
    firmaId: json["firmaId"],
    fecha: json["fecha"],
    usuarioId: json["usuarioId"],
  );

  Map<String, dynamic> toJson() => {
    "firmaCadena": firmaCadena,
    "firmaNombre": firmaNombre,
    "firmaCargo": firmaCargo,
    "reporteId": reporteId,
    "ramosElaborados": ramosElaborados,
    "ramosDespachados": ramosDespachados,
    "ramosRevisados": ramosRevisados,
    "tallosPorRamo": tallosPorRamo,
    "postCosechaId": postCosechaId,
    "marca": marca,
    "clienteId": clienteId,
    "productoId": productoId,
    "numeroOrden": numeroOrden,
    "derogacion": derogacion,
    "falenciaId": falenciaId,
    "falenciaCantidad": falenciaCantidad,
    "tipo": tipo,
    "cajasDespachar": cajasDespachar,
    "cajasRevisar": cajasRevisar,
    "ramosCaja": ramosCaja,
    "duracion": duracion,
    "firmaId": firmaId,
    "fecha": fecha,
    "usuarioId": usuarioId,
  };
}
