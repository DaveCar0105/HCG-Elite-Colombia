// To parse this JSON data, do
//
//     final historial = historialFromJson(jsonString);

import 'dart:convert';

Historial historialFromJson(String str) => Historial.fromJson(json.decode(str));

String historialToJson(Historial data) => json.encode(data.toJson());

class Historial {
  Historial({
    this.controlRamosId,
    this.ramosNumeroOrden,
    this.ramosTotal,
    this.ramosFecha,
    this.ramosAprobado,
    this.detalleFirmaId,
    this.clienteId,
    this.clienteNombre,
    this.productoNombre,
    this.productoId,
    this.usuarioId,
    this.ramosTallos,
    this.ramosDespachar,
    this.ramosElaborados,
    this.ramosDerogado,
    this.ramosDesde,
    this.ramosHasta,
    this.postcosechaId,
    this.postcosechaNombre,
    this.ramosMarca,
    this.estado,
    this.cajasRevisar,
    this.tipo,
  });

  int controlRamosId;
  String ramosNumeroOrden;
  String ramosTotal;
  String ramosFecha;
  String ramosAprobado;
  int detalleFirmaId;
  int clienteId;
  String clienteNombre;
  String productoNombre;
  int productoId;
  int usuarioId;
  String ramosTallos;
  String ramosDespachar;
  String ramosElaborados;
  String ramosDerogado;
  String ramosDesde;
  String ramosHasta;
  int postcosechaId;
  String postcosechaNombre;
  String ramosMarca;
  int estado;
  String cajasRevisar;
  String tipo;

  factory Historial.fromJson(Map<String, dynamic> json) => Historial(
    controlRamosId: json["controlRamosId"],
    ramosNumeroOrden: json["ramosNumeroOrden"],
    ramosTotal: json["ramosTotal"],
    ramosFecha: json["ramosFecha"],
    ramosAprobado: json["ramosAprobado"],
    detalleFirmaId: json["detalleFirmaId"],
    clienteId: json["clienteId"],
    clienteNombre: json["clienteNombre"],
    productoNombre: json["productoNombre"],
    productoId: json["productoId"],
    usuarioId: json["usuarioId"],
    ramosTallos: json["ramosTallos"],
    ramosDespachar: json["ramosDespachar"],
    ramosElaborados: json["ramosElaborados"],
    ramosDerogado: json["ramosDerogado"],
    ramosDesde: json["ramosDesde"],
    ramosHasta: json["ramosHasta"],
    postcosechaId: json["postcosechaId"],
    postcosechaNombre: json["postcosechaNombre"],
    ramosMarca: json["ramosMarca"],
    estado: json["estado"],
    cajasRevisar: json["cajasRevisar"],
    tipo: json["tipo"],
  );

  Map<String, dynamic> toJson() => {
    "controlRamosId": controlRamosId,
    "ramosNumeroOrden": ramosNumeroOrden,
    "ramosTotal": ramosTotal,
    "ramosFecha": ramosFecha,
    "ramosAprobado": ramosAprobado,
    "detalleFirmaId": detalleFirmaId,
    "clienteId": clienteId,
    "clienteNombre": clienteNombre,
    "productoNombre": productoNombre,
    "productoId": productoId,
    "usuarioId": usuarioId,
    "ramosTallos": ramosTallos,
    "ramosDespachar": ramosDespachar,
    "ramosElaborados": ramosElaborados,
    "ramosDerogado": ramosDerogado,
    "ramosDesde": ramosDesde,
    "ramosHasta": ramosHasta,
    "postcosechaId": postcosechaId,
    "postcosechaNombre": postcosechaNombre,
    "ramosMarca": ramosMarca,
    "estado": estado,
    "cajasRevisar": cajasRevisar,
    "tipo": tipo,
  };
}
