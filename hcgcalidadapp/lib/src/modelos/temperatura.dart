// To parse this JSON data, do
//
//     final temperatura = temperaturaFromJson(jsonString);

import 'dart:convert';

Temperatura temperaturaFromJson(String str) =>
    Temperatura.fromJson(json.decode(str));

String temperaturaToJson(Temperatura data) => json.encode(data.toJson());

class Temperatura {
  var temperaturaInterna3;

  Temperatura({
    this.temperaturaId,
    this.temperaturaUsuarioControlId,
    this.temperaturaInterna1,
    this.temperaturaInterna2,
    this.temperatiraInterna3,
    this.temperaturaExterna,
    this.temperaturaFecha,
    this.postcosechaId,
  });

  int temperaturaId;
  int temperaturaUsuarioControlId;
  double temperaturaInterna1;
  double temperaturaInterna2;
  double temperatiraInterna3;
  double temperaturaExterna;
  DateTime temperaturaFecha;
  int postcosechaId;

  factory Temperatura.fromJson(Map<String, dynamic> json) => Temperatura(
        temperaturaId: json["temperaturaId"],
        temperaturaUsuarioControlId: json["temperaturaUsuarioControlId"],
        temperaturaInterna1: json["temperaturaInterna1"].toDouble(),
        temperaturaInterna2: json["temperaturaInterna2"].toDouble(),
        temperatiraInterna3: json["temperaturaInterna3"].toDouble(),
        temperaturaExterna: json["temperaturaExterna"].toDouble(),
        temperaturaFecha: DateTime.parse(json["temperaturaFecha"]),
        postcosechaId: json["postcosechaId"],
      );

  Map<String, dynamic> toJson() => {
        "temperaturaId": temperaturaId,
        "temperaturaUsuarioControlId": temperaturaUsuarioControlId,
        "temperaturaInterna1": temperaturaInterna1,
        "temperaturaInterna2": temperaturaInterna2,
        "temperaturaInterna3": temperaturaInterna3,
        "temperaturaExterna": temperaturaExterna,
        "postcosechaId": postcosechaId,
        "temperaturaFecha":
            "${temperaturaFecha.year.toString().padLeft(4, '0')}-${temperaturaFecha.month.toString().padLeft(2, '0')}-${temperaturaFecha.day.toString().padLeft(2, '0')}",
      };
}
