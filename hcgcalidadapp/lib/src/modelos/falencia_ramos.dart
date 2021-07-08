
import 'dart:convert';

FalenciaRamos falenciaRamosFromJson(String str) => FalenciaRamos.fromJson(json.decode(str));

String falenciaRamosToJson(FalenciaRamos data) => json.encode(data.toJson());

class FalenciaRamos {
  FalenciaRamos({
    this.falenciaRamosId,
    this.falenciaRamosNombre,
    this.categoriaRamosId,
    this.elite
  });

  int falenciaRamosId;
  String falenciaRamosNombre;
  int categoriaRamosId;
  int elite;

  factory FalenciaRamos.fromJson(Map<String, dynamic> json) => FalenciaRamos(
    falenciaRamosId: json["falenciaRamosId"],
    falenciaRamosNombre: json["falenciaRamosNombre"],
    categoriaRamosId: json["categoriaRamosId"],
    elite: json["elite"],
  );

  Map<String, dynamic> toJson() => {
    "falenciaRamosId": falenciaRamosId,
    "falenciaRamosNombre": falenciaRamosNombre,
    "categoriaRamosId": categoriaRamosId,
    "elite": elite,
  };
}
