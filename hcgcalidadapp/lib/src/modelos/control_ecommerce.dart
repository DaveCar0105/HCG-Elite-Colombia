
import 'dart:convert';

ControlEcommerce controlEcommerceFromJson(String str) => ControlEcommerce.fromJson(json.decode(str));

String controlEcommerceToJson(ControlEcommerce data) => json.encode(data.toJson());

class ControlEcommerce {
  ControlEcommerce({
    this.controlId,
    this.id,
    this.numero,
    this.nombre,
    this.cumple,
    this.noCumple,
    this.noAplica,
    this.problemaId,
    this.tipo
  });
  int controlId;
  int problemaId;
  int id;
  int numero;
  String nombre;
  bool cumple;
  bool noCumple;
  bool noAplica;
  int tipo;

  factory ControlEcommerce.fromJson(Map<String, dynamic> json) => ControlEcommerce(
    id: json["id"],
    controlId: json["controlId"],
    problemaId: json["problemaId"],
    numero: json["numero"],
    nombre: json["nombre"],
    cumple: json["cumple"],
    noCumple: json["noCumple"],
    noAplica: json["noAplica"],
    tipo: json["tipo"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "controlId": controlId,
    "problemaId": problemaId,
    "numero": numero,
    "nombre": nombre,
    "cumple": cumple,
    "noCumple": noCumple,
    "noAplica": noAplica,
    "tipo": tipo,
  };
}
