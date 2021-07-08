import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {
  Producto({
    this.productoId,
    this.productoNombre,
    this.elite
  });

  int productoId;
  String productoNombre;
  int elite;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    productoId: json["productoId"],
    productoNombre: json["productoNombre"],
    elite: json["elite"],
  );

  Map<String, dynamic> toJson() => {
    "productoId": productoId,
    "productoNombre": productoNombre,
    "elite":elite
  };
}
