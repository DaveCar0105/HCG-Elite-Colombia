import 'dart:convert';

Ramo ramoFromJson(String str) => Ramo.fromJson(json.decode(str));

String ramoToJson(Ramo data) => json.encode(data.toJson());

class Ramo {
  Ramo(
      {this.controlRamoId,
      this.ramoId,
      this.cantidadFalencias,
      this.numeroMesa,
      this.variedad,
      this.linea});

  int controlRamoId;
  int ramoId;
  int cantidadFalencias;
  String numeroMesa;
  String variedad;
  String linea;

  factory Ramo.fromJson(Map<String, dynamic> json) => Ramo(
      controlRamoId: json["controlRamoId"],
      ramoId: json["ramoId"],
      cantidadFalencias: json["cantidadFalencias"],
      numeroMesa: json["numeroMesa"],
      variedad: json["variedad"],
      linea: json["linea"]);

  Map<String, dynamic> toJson() => {
        "controlRamoId": controlRamoId,
        "ramoId": ramoId,
        "cantidadFalencias": cantidadFalencias,
        "numeroMesa": numeroMesa,
        "variedad": variedad,
        "linea": linea
      };
}
