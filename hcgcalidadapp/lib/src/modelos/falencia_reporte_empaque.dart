// To parse this JSON data, do
//
//     final falenciaReporteEmpaque = falenciaReporteEmpaqueFromJson(jsonString);

import 'dart:convert';

FalenciaReporteEmpaque falenciaReporteEmpaqueFromJson(String str) => FalenciaReporteEmpaque.fromJson(json.decode(str));

String falenciaReporteEmpaqueToJson(FalenciaReporteEmpaque data) => json.encode(data.toJson());

class FalenciaReporteEmpaque {
  FalenciaReporteEmpaque({
    this.falenciasReporteEmpaqueId,
    this.falenciasReporteEmpaqueCantidad,
    this.falenciasReporteEmpaquePorcentaje,
    this.falenciaEmpaqueId,
    this.empaqueId,
    this.falenciaEmpaqueNombre,
    this.total,
    this.totalRamos,
    this.ramos
  });

  int falenciasReporteEmpaqueId;
  int falenciasReporteEmpaqueCantidad;
  String falenciasReporteEmpaquePorcentaje;
  int falenciaEmpaqueId;
  int empaqueId;
  String falenciaEmpaqueNombre;
  int total;
  int totalRamos;
  bool ramos;

  factory FalenciaReporteEmpaque.fromJson(Map<String, dynamic> json) => FalenciaReporteEmpaque(
    falenciasReporteEmpaqueId: json["falenciasReporteEmpaqueId"],
    falenciasReporteEmpaqueCantidad: json["falenciasReporteEmpaqueCantidad"],
    falenciasReporteEmpaquePorcentaje: json["falenciasReporteEmpaquePorcentaje"],
    falenciaEmpaqueId: json["falenciaEmpaqueId"],
    empaqueId: json["empaqueId"],
    falenciaEmpaqueNombre: json["falenciaEmpaqueNombre"],
    total: json["total"],
    totalRamos: json["totalRamos"],
    ramos: json["ramos"]
  );

  Map<String, dynamic> toJson() => {
    "falenciasReporteEmpaqueId": falenciasReporteEmpaqueId,
    "falenciasReporteEmpaqueCantidad": falenciasReporteEmpaqueCantidad,
    "falenciasReporteEmpaquePorcentaje": falenciasReporteEmpaquePorcentaje,
    "falenciaEmpaqueId": falenciaEmpaqueId,
    "empaqueId": empaqueId,
    "falenciaEmpaqueNombre": falenciaEmpaqueNombre,
    "total": total,
    "totalRamos":totalRamos,
    "ramos":ramos
  };
}
