
import 'dart:convert';

CategoriaRamos categoriaRamosFromJson(String str) => CategoriaRamos.fromJson(json.decode(str));

String categoriaRamosToJson(CategoriaRamos data) => json.encode(data.toJson());

class CategoriaRamos {
  CategoriaRamos({
    this.categoriaRamosId,
    this.categoriaRamosNombre,
  });

  int categoriaRamosId;
  String categoriaRamosNombre;

  factory CategoriaRamos.fromJson(Map<String, dynamic> json) => CategoriaRamos(
    categoriaRamosId: json["categoriaRamosId"],
    categoriaRamosNombre: json["categoriaRamosNombre"],
  );

  Map<String, dynamic> toJson() => {
    "categoriaRamosId": categoriaRamosId,
    "categoriaRamosNombre": categoriaRamosNombre,
  };
}
