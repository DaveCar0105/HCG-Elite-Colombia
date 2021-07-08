import 'dart:convert';

ProblemaEcommerce problemaEcommerceFromJson(String str) => ProblemaEcommerce.fromJson(json.decode(str));

String problemaEcommerceToJson(ProblemaEcommerce data) => json.encode(data.toJson());

class ProblemaEcommerce {
  ProblemaEcommerce({
    this.id,
    this.numero,
    this.nombre,
    this.tipo
  });

  int id;
  int numero;
  String nombre;
  int tipo;

  factory ProblemaEcommerce.fromJson(Map<String, dynamic> json) => ProblemaEcommerce(
    id: json["id"],
    numero: json["numero"],
    nombre: json["nombre"],
    tipo: json["tipo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numero": numero,
    "nombre": nombre,
    "tipo": tipo,
  };
}
