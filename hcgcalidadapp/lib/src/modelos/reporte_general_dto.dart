import 'dart:convert';

ReporteGeneralDto reporteGeneralFromJson(String str) =>
    ReporteGeneralDto.fromJson(json.decode(str));

String reporteGeneralToJson(ReporteGeneralDto data) =>
    json.encode(data.toJson());

class ReporteGeneralDto {
  ReporteGeneralDto(
      {this.ramosRevisados,
      this.ramosNoConformes,
      this.porRamosNoConformes,
      this.falencias,
      this.totalFalencias});

  int ramosRevisados;
  int ramosNoConformes;
  double porRamosNoConformes;
  List<FalenciaReporteGeneralDto> falencias;
  int totalFalencias;

  factory ReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      ReporteGeneralDto(
          ramosRevisados: json["ramosRevisados"],
          ramosNoConformes: json["ramosNoConformes"],
          porRamosNoConformes: json["porRamosNoConformes"].toDouble(),
          falencias: json["falencias"],
          totalFalencias: json["totalFalencias"]);

  Map<String, dynamic> toJson() => {
        "ramosRevisados": ramosRevisados,
        "ramosNoConformes": ramosNoConformes,
        "porRamosNoConformes": porRamosNoConformes,
        "falencias": falencias,
        "totalFalencias": totalFalencias
      };
}

FalenciaReporteGeneralDto falenciaReporteGeneralFromJson(String str) =>
    FalenciaReporteGeneralDto.fromJson(json.decode(str));

String falenciaReporteGeneralToJson(FalenciaReporteGeneralDto data) =>
    json.encode(data.toJson());

class FalenciaReporteGeneralDto {
  FalenciaReporteGeneralDto(
      {this.id, this.cantidad, this.nombreFalencia, this.porcentajeFalencia});

  int id;
  String nombreFalencia;
  int cantidad;
  double porcentajeFalencia;

  factory FalenciaReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      FalenciaReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreFalencia: json["nombreFalencia"],
          porcentajeFalencia: json["porcentajeFalencia"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreFalencia": nombreFalencia,
        "porcentajeFalencia": porcentajeFalencia
      };
}
