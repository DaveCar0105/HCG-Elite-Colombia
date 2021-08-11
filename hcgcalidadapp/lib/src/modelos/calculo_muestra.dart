import 'dart:convert';

import 'dart:ffi';

calculoMuestra hidratacionFromJson(String str) =>
    calculoMuestra.fromJson(json.decode(str));

String hidratacionToJson(calculoMuestra data) => json.encode(data.toJson());

class calculoMuestra {
  calculoMuestra(
      {this.RamosTotales, this.NivelDeConfianza, this.MargenDeError});

  int RamosTotales;
  Float NivelDeConfianza;
  Float MargenDeError;

  factory calculoMuestra.fromJson(Map<String, dynamic> json) => calculoMuestra(
      RamosTotales: json["RamosTotales"],
      NivelDeConfianza: json["NivelDeConfianza"],
      MargenDeError: json["MargenDeError"]);

  Map<String, dynamic> toJson() => {
        "RamosTotales": RamosTotales,
        "NivelDeConfianza": NivelDeConfianza,
        "MargenDeError": MargenDeError
      };
}
