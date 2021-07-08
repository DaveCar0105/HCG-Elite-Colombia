import 'dart:convert';

Hidratacion hidratacionFromJson(String str) => Hidratacion.fromJson(json.decode(str));

String hidratacionToJson(Hidratacion data) => json.encode(data.toJson());

class Hidratacion {
  Hidratacion({
    this.hidratacionId,
    this.hidratacionNombre,
  });

  int hidratacionId;
  String hidratacionNombre;

  factory Hidratacion.fromJson(Map<String, dynamic> json) => Hidratacion(
    hidratacionId: json["hidratacionId"],
    hidratacionNombre: json["hidratacionNombre"],
  );

  Map<String, dynamic> toJson() => {
    "hidratacionId": hidratacionId,
    "hidratacionNombre": hidratacionNombre,
  };
}
