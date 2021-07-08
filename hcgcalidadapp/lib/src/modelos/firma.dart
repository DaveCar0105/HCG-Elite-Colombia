// To parse this JSON data, do
//
//     final firma = firmaFromJson(jsonString);

import 'dart:convert';

Firma firmaFromJson(String str) => Firma.fromJson(json.decode(str));

String firmaToJson(Firma data) => json.encode(data.toJson());

class Firma {
  Firma({
    this.firmaId,
    this.firmaNombre,
    this.firmaCargo,
    this.firmaCorreo,
    this.firmaCodigo
  });

  int firmaId;
  String firmaCodigo;
  String firmaNombre;
  String firmaCargo;
  String firmaCorreo;

  factory Firma.fromJson(Map<String, dynamic> json) => Firma(
    firmaId: json["firmaId"],
    firmaCodigo: json["firmaCodigo"],
    firmaNombre: json["firmaNombre"],
    firmaCargo: json["firmaCargo"],
    firmaCorreo: json["firmaCorreo"]
  );

  Map<String, dynamic> toJson() => {
    "firmaId": firmaId,
    "firmaCodigo" : firmaCodigo,
    "firmaNombre": firmaNombre,
    "firmaCargo": firmaCargo,
    "firmaCorreo": firmaCorreo
  };
}
