import 'dart:convert';

ProcesoMaritimoDestinos procesoMaritimoDestinosFromJson(String str) =>
    ProcesoMaritimoDestinos.fromJson(json.decode(str));

String procesoMaritimoDestinosToJson(ProcesoMaritimoDestinos data) =>
    json.encode(data.toJson());

class ProcesoMaritimoDestinos {
  ProcesoMaritimoDestinos(
      {this.procesoMaritimoDestinoId, this.procesoMaritimoDestinoNombre});

  int procesoMaritimoDestinoId;
  String procesoMaritimoDestinoNombre;

  factory ProcesoMaritimoDestinos.fromJson(Map<String, dynamic> json) =>
      ProcesoMaritimoDestinos(
          procesoMaritimoDestinoId: json["destinoMaritimoId"],
          procesoMaritimoDestinoNombre: json["destinoMaritimoNombre"]);

  Map<String, dynamic> toJson() => {
        "procesoMaritimoDestinoId": procesoMaritimoDestinoId,
        "procesoMaritimoDestinoNombreId": procesoMaritimoDestinoId
      };
}
