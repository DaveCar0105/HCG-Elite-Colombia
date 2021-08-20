import 'dart:convert';

Banda ramoFromJson(String str) => Banda.fromJson(json.decode(str));

String ramoToJson(Banda data) => json.encode(data.toJson());

class Banda {
  Banda(
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

  factory Banda.fromJson(Map<String, dynamic> json) => Banda(
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
