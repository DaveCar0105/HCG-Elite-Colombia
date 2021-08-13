// To parse this JSON data, do
//
//     final falenciaReporteRamos = falenciaReporteRamosFromJson(jsonString);

import 'dart:convert';

FalenciaReporteRamos falenciaReporteRamosFromJson(String str) =>
    FalenciaReporteRamos.fromJson(json.decode(str));

String falenciaReporteRamosToJson(FalenciaReporteRamos data) =>
    json.encode(data.toJson());

class FalenciaReporteRamos {
  FalenciaReporteRamos(
      {this.falenciasReporteRamosId,
      this.falenciasReporteRamosCantidad,
      this.falenciasReporteRamosPorcentaje,
      this.falenciaRamosId,
      this.ramosId,
      this.falenciaRamosNombre,
      this.total});

  int falenciasReporteRamosId;
  int falenciasReporteRamosCantidad;
  String falenciasReporteRamosPorcentaje;
  int falenciaRamosId;
  int ramosId;
  String falenciaRamosNombre;
  int total;

  factory FalenciaReporteRamos.fromJson(Map<String, dynamic> json) =>
      FalenciaReporteRamos(
          falenciasReporteRamosId: json["falenciasReporteRamosId"],
          falenciasReporteRamosCantidad: json["falenciasReporteRamosCantidad"],
          falenciasReporteRamosPorcentaje:
              json["falenciasReporteRamosPorcentaje"],
          falenciaRamosId: json["falenciaRamosId"],
          ramosId: json["ramosId"],
          total: json["total"]);

  Map<String, dynamic> toJson() => {
        "falenciasReporteRamosId": falenciasReporteRamosId,
        "falenciasReporteRamosCantidad": falenciasReporteRamosCantidad,
        "falenciasReporteRamosPorcentaje": falenciasReporteRamosPorcentaje,
        "falenciaRamosId": falenciaRamosId,
        "ramosId": ramosId,
        "total": total
      };
}
