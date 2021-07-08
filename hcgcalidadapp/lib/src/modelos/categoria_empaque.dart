// To parse this JSON data, do
//
//     final categoriaEmpaque = categoriaEmpaqueFromJson(jsonString);

import 'dart:convert';

CategoriaEmpaque categoriaEmpaqueFromJson(String str) => CategoriaEmpaque.fromJson(json.decode(str));

String categoriaEmpaqueToJson(CategoriaEmpaque data) => json.encode(data.toJson());

class CategoriaEmpaque {
  CategoriaEmpaque({
    this.categoriaEmpaqueId,
    this.categoriaEmpaqueNombre,
  });

  int categoriaEmpaqueId;
  String categoriaEmpaqueNombre;

  factory CategoriaEmpaque.fromJson(Map<String, dynamic> json) => CategoriaEmpaque(
    categoriaEmpaqueId: json["categoriaEmpaqueId"],
    categoriaEmpaqueNombre: json["categoriaEmpaqueNombre"],
  );

  Map<String, dynamic> toJson() => {
    "categoriaEmpaqueId": categoriaEmpaqueId,
    "categoriaEmpaqueNombre": categoriaEmpaqueNombre,
  };
}
