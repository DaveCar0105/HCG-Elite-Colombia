// To parse this JSON data, do
//
//     final falenciaReporteRamos = falenciaReporteRamosFromJson(jsonString);

import 'dart:convert';

FalenciaReporteRamosBanda falenciaReporteRamosFromJson(String str) =>
    FalenciaReporteRamosBanda.fromJson(json.decode(str));

String falenciaReporteRamosToJson(FalenciaReporteRamosBanda data) =>
    json.encode(data.toJson());

class FalenciaReporteRamosBanda {
  FalenciaReporteRamosBanda(
      {this.falenciasReporteRamosId,
      this.falenciasReporteRamosCantidad,
      this.falenciasReporteRamosPorcentaje,
      this.falenciaBandaId,
      this.ramosId,
      this.falenciaRamosNombre,
      this.total});

  int falenciasReporteRamosId;
  int falenciasReporteRamosCantidad;
  String falenciasReporteRamosPorcentaje;
  int falenciaBandaId;
  int ramosId;
  String falenciaRamosNombre;
  int total;

  factory FalenciaReporteRamosBanda.fromJson(Map<String, dynamic> json) =>
      FalenciaReporteRamosBanda(
          falenciasReporteRamosId: json["falenciasReporteRamosId"],
          falenciasReporteRamosCantidad: json["falenciasReporteRamosCantidad"],
          falenciasReporteRamosPorcentaje:
              json["falenciasReporteRamosPorcentaje"],
          falenciaBandaId: json["falenciaBandaId"],
          ramosId: json["ramosId"],
          total: json["total"]);

  Map<String, dynamic> toJson() => {
        "falenciasReporteRamosId": falenciasReporteRamosId,
        "falenciasReporteRamosCantidad": falenciasReporteRamosCantidad,
        "falenciasReporteRamosPorcentaje": falenciasReporteRamosPorcentaje,
        "falenciabandaId": falenciaBandaId,
        "ramosId": ramosId,
        "total": total
      };
}
