// To parse this JSON data, do
//
//     final falenciaEmpaque = falenciaEmpaqueFromJson(jsonString);

import 'dart:convert';

FalenciaEmpaque falenciaEmpaqueFromJson(String str) => FalenciaEmpaque.fromJson(json.decode(str));

String falenciaEmpaqueToJson(FalenciaEmpaque data) => json.encode(data.toJson());

class FalenciaEmpaque {
  FalenciaEmpaque({
    this.falenciaEmpaqueId,
    this.falenciaEmpaqueNombre,
    this.categoriaEmpaqueId,
    this.elite
  });

  int falenciaEmpaqueId;
  String falenciaEmpaqueNombre;
  int categoriaEmpaqueId;
  int elite;

  factory FalenciaEmpaque.fromJson(Map<String, dynamic> json) => FalenciaEmpaque(
    falenciaEmpaqueId: json["falenciaEmpaqueId"],
    falenciaEmpaqueNombre: json["falenciaEmpaqueNombre"],
    categoriaEmpaqueId: json["categoriaEmpaqueId"],
    elite: json["elite"],
  );

  Map<String, dynamic> toJson() => {
    "falenciaEmpaqueId": falenciaEmpaqueId,
    "falenciaEmpaqueNombre": falenciaEmpaqueNombre,
    "categoriaEmpaqueId": categoriaEmpaqueId,
    "elite": elite,
  };
}
