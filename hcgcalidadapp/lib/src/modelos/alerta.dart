
import 'dart:convert';

AlertaEcuador alertaEcuadorFromJson(String str) => AlertaEcuador.fromJson(json.decode(str));

String alertaEcuadorToJson(AlertaEcuador data) => json.encode(data.toJson());

class AlertaEcuador {
  AlertaEcuador({
    this.controlEcuadorId,
    this.alertaEcuadorId,
    this.productoNombre,
    this.productoId,
    this.falenciaRamoNombre,
    this.falenciaRamoId,
    this.tallosMuestra,
    this.tallosAfectados,
    this.variedadNombre
  });

  int controlEcuadorId;
  int alertaEcuadorId;
  String productoNombre;
  int productoId;
  String falenciaRamoNombre;
  String variedadNombre;
  int falenciaRamoId;
  int tallosMuestra;
  int tallosAfectados;

  factory AlertaEcuador.fromJson(Map<String, dynamic> json) => AlertaEcuador(
    controlEcuadorId: json["controlEcuadorId"],
    alertaEcuadorId: json["alertaEcuadorId"],
    productoNombre: json["productoNombre"],
    productoId: json["productoId"],
    variedadNombre: json["variedadNombre"],
    falenciaRamoNombre: json["falenciaRamoNombre"],
    falenciaRamoId: json["falenciaRamoId"],
    tallosMuestra: json["tallosMuestra"],
    tallosAfectados: json["tallosAfectados"],
  );

  Map<String, dynamic> toJson() => {
    "controlEcuadorId": controlEcuadorId,
    "alertaEcuadorId": alertaEcuadorId,
    "productoNombre": productoNombre,
    "productoId": productoId,
    "falenciaRamoNombre": falenciaRamoNombre,
    "falenciaRamoId": falenciaRamoId,
    "tallosMuestra": tallosMuestra,
    "tallosAfectados": tallosAfectados,
    "variedadNombre":variedadNombre
  };
}
