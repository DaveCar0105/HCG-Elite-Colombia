import 'dart:convert';

FalenciaControlAlistamiento falenciaControlAlistamientoFromJson(String str) => FalenciaControlAlistamiento.fromJson(json.decode(str));

String falenciaControlAlistamientoToJson(FalenciaControlAlistamiento data) => json.encode(data.toJson());

class FalenciaControlAlistamiento {
  FalenciaControlAlistamiento({
    this.falenciasReporteRamosId,
    this.falenciasReporteTallosMuestra,
    this.falenciasReporteTallosAfectados,
    this.falenciasReporteVariedad,
    this.falenciaRamosId,
    this.controlAlistamientoId,
    this.falenciasReporteNombre,
    this.productoId,
    this.productoNombre
  });

  int falenciasReporteRamosId;
  int falenciasReporteTallosMuestra;
  int falenciasReporteTallosAfectados;
  String falenciasReporteVariedad;
  String falenciasReporteNombre;
  String productoNombre;
  int falenciaRamosId;
  int controlAlistamientoId;
  int productoId;

  factory FalenciaControlAlistamiento.fromJson(Map<String, dynamic> json) => FalenciaControlAlistamiento(
    falenciasReporteRamosId: json["falenciasReporteRamosId"],
    falenciasReporteTallosMuestra: json["falenciasReporteTallosMuestra"],
    falenciasReporteTallosAfectados: json["falenciasReporteTallosAfectados"],
    falenciasReporteVariedad: json["falenciasReporteVariedad"],
    falenciasReporteNombre: json["falenciasReporteNombre"],
    falenciaRamosId: json["falenciaRamosId"],
    controlAlistamientoId: json["controlAlistamientoId"],
      productoId: json["productoId"],
    productoNombre: json["productoNombre"]
  );

  Map<String, dynamic> toJson() => {
    "falenciasReporteRamosId": falenciasReporteRamosId,
    "falenciasReporteTallosMuestra": falenciasReporteTallosMuestra,
    "falenciasReporteTallosAfectados": falenciasReporteTallosAfectados,
    "falenciasReporteVariedad": falenciasReporteVariedad,
    "falenciasReporteNombre": falenciasReporteNombre,
    "falenciaRamosId": falenciaRamosId,
    "controlAlistamientoId": controlAlistamientoId,
    "productoId": productoId,
    "productoNombre":productoNombre
  };
}
