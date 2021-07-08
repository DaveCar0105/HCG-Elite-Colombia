import 'dart:convert';

Ramo ramoFromJson(String str) => Ramo.fromJson(json.decode(str));

String ramoToJson(Ramo data) => json.encode(data.toJson());

class Ramo {
  Ramo({
    this.controlRamoId,
    this.ramoId,
    this.cantidadFalencias,
  });

  int controlRamoId;
  int ramoId;
  int cantidadFalencias;

  factory Ramo.fromJson(Map<String, dynamic> json) => Ramo(
    controlRamoId: json["controlRamoId"],
    ramoId: json["ramoId"],
    cantidadFalencias: json["cantidadFalencias"],
  );

  Map<String, dynamic> toJson() => {
    "controlRamoId": controlRamoId,
    "ramoId": ramoId,
    "cantidadFalencias": cantidadFalencias,
  };
}
