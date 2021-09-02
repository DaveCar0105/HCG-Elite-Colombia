import 'dart:convert';

Empaque empaqueFromJson(String str) => Empaque.fromJson(json.decode(str));

String empaqueToJson(Empaque data) => json.encode(data.toJson());

class Empaque {
  Empaque(
      {this.controlEmpaqueId,
      this.empaqueId,
      this.cantidadFalencias,
      this.tipo,
      this.numeroMesa,
      this.variedad,
      this.linea,
      this.codigoEmpacador});

  int controlEmpaqueId;
  int empaqueId;
  int cantidadFalencias;
  String tipo;
  String numeroMesa;
  String variedad;
  String linea;
  String codigoEmpacador;

  factory Empaque.fromJson(Map<String, dynamic> json) => Empaque(
      controlEmpaqueId: json["controlEmpaqueId"],
      empaqueId: json["empaqueId"],
      cantidadFalencias: json["cantidadFalencias"],
      tipo: json["tipo"],
      numeroMesa: json["numeroMesa"],
      variedad: json["variedad"],
      linea: json["linea"],
      codigoEmpacador: json["codigoEmpacador"]);

  Map<String, dynamic> toJson() => {
        "controlEmpaqueId": controlEmpaqueId,
        "empaqueId": empaqueId,
        "cantidadFalencias": cantidadFalencias,
        "tipo": tipo,
        "numeroMesa": numeroMesa,
        "variedad": variedad,
        "linea": linea,
        "codigoEmpacador": codigoEmpacador
      };
}
