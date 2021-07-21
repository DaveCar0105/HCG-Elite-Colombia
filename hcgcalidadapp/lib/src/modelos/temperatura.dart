// To parse this JSON data, do
//
//     final temperatura = temperaturaFromJson(jsonString);

import 'dart:convert';

Temperatura temperaturaFromJson(String str) =>
    Temperatura.fromJson(json.decode(str));

String temperaturaToJson(Temperatura data) => json.encode(data.toJson());

class Temperatura {

  Temperatura(
      {this.temperaturaId,
      this.temperaturaUsuarioControlId,
      this.temperaturaInterna1,
      this.temperaturaInterna2,
      this.temperaturaInterna3,
      this.temperaturaExterna,
      this.temperaturaFecha,
      this.postcosechaId,
      this.clienteId});

  int temperaturaId;
  int temperaturaUsuarioControlId;
  double temperaturaInterna1;
  double temperaturaInterna2;
  double temperaturaInterna3;
  double temperaturaExterna;
  DateTime temperaturaFecha;
  int postcosechaId;
  int clienteId;

  factory Temperatura.fromJson(Map<String, dynamic> json) => Temperatura(
        temperaturaId: json["temperaturaId"],
        temperaturaUsuarioControlId: json["temperaturaUsuarioControlId"],
        temperaturaInterna1: json["temperaturaInterna1"].toDouble(),
        temperaturaInterna2: json["temperaturaInterna2"].toDouble(),
        temperaturaInterna3: json["temperaturaInterna3"].toDouble(),
        temperaturaExterna: json["temperaturaExterna"].toDouble(),
        temperaturaFecha: DateTime.parse(json["temperaturaFecha"]),
        postcosechaId: json["postcosechaId"],
        clienteId: json["clienteId"],
      );

  Map<String, dynamic> toJson() => {
        "temperaturaId": temperaturaId,
        "temperaturaUsuarioControlId": temperaturaUsuarioControlId,
        "temperaturaInterna1": temperaturaInterna1,
        "temperaturaInterna2": temperaturaInterna2,
        "temperaturaInterna3": temperaturaInterna3,
        "temperaturaExterna": temperaturaExterna,
        "postcosechaId": postcosechaId,
        "clienteId": clienteId,
        "temperaturaFecha":
            "${temperaturaFecha.year.toString().padLeft(4, '0')}-${temperaturaFecha.month.toString().padLeft(2, '0')}-${temperaturaFecha.day.toString().padLeft(2, '0')}",
      };
}
