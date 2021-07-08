// To parse this JSON data, do
//
//     final temperatura = temperaturaFromJson(jsonString);

import 'dart:convert';

Temperatura temperaturaFromJson(String str) => Temperatura.fromJson(json.decode(str));

String temperaturaToJson(Temperatura data) => json.encode(data.toJson());

class Temperatura {
    Temperatura({
        this.temperaturaId,
        this.temperaturaUsuarioControlId,
        this.temperaturaInterna,
        this.temperaturaExterna,
        this.temperaturaFecha,
        this.postcosechaId,
    });

    int temperaturaId;
    int temperaturaUsuarioControlId;
    double temperaturaInterna;
    double temperaturaExterna;
    DateTime temperaturaFecha;
    int postcosechaId;

    factory Temperatura.fromJson(Map<String, dynamic> json) => Temperatura(
        temperaturaId: json["temperaturaId"],
        temperaturaUsuarioControlId: json["temperaturaUsuarioControlId"],
        temperaturaInterna: json["temperaturaInterna"].toDouble(),
        temperaturaExterna: json["temperaturaExterna"].toDouble(),
        temperaturaFecha: DateTime.parse(json["temperaturaFecha"]),
        postcosechaId: json["postcosechaId"],
    );

    Map<String, dynamic> toJson() => {
        "temperaturaId": temperaturaId,
        "temperaturaUsuarioControlId": temperaturaUsuarioControlId,
        "temperaturaInterna": temperaturaInterna,
        "temperaturaExterna": temperaturaExterna,
        "postcosechaId": postcosechaId,
        "temperaturaFecha": "${temperaturaFecha.year.toString().padLeft(4, '0')}-${temperaturaFecha.month.toString().padLeft(2, '0')}-${temperaturaFecha.day.toString().padLeft(2, '0')}",
    };
}