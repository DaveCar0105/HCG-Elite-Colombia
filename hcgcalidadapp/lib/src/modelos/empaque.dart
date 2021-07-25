import 'dart:convert';

ControlEmpaque empaqueFromJson(String str) =>
    ControlEmpaque.fromJson(json.decode(str));

String empaqueToJson(ControlEmpaque data) => json.encode(data.toJson());

class ControlEmpaque {
  ControlEmpaque(
      {this.controlEmpaqueId,
      this.empaqueNumeroOrden,
      this.empaqueTotal,
      this.empaqueFecha,
      this.empaqueAprobado,
      this.firmaId,
      this.clienteId,
      this.tipoClienteId,
      this.productoId,
      this.usuarioId,
      this.empaqueTallos,
      this.empaqueRamos,
      this.empaqueDespachar,
      this.empaqueDerogado,
      this.empaqueDesde,
      this.empaqueHasta,
      this.postcosechaId,
      this.empaqueMarca,
      this.ramosRevisar,
      this.elite});

  int controlEmpaqueId;
  String empaqueNumeroOrden;
  int empaqueTotal;
  String empaqueFecha;
  int empaqueAprobado;
  int firmaId;
  int clienteId;
  int tipoClienteId;
  int productoId;
  int usuarioId;
  int empaqueTallos;
  int empaqueRamos;
  int empaqueDespachar;
  String empaqueDerogado;
  int empaqueDesde;
  int empaqueHasta;
  int postcosechaId;
  int ramosRevisar;
  String empaqueMarca;
  int elite;

  factory ControlEmpaque.fromJson(Map<String, dynamic> json) => ControlEmpaque(
      controlEmpaqueId: json["controlEmpaqueId"],
      empaqueNumeroOrden: json["empaqueNumeroOrden"],
      empaqueTotal: json["empaqueTotal"],
      empaqueFecha: json["empaqueFecha"],
      empaqueAprobado: json["empaqueAprobado"],
      firmaId: json["firmaId"],
      clienteId: json["clienteId"],
      tipoClienteId: json["tipoClienteId"],
      productoId: json["productoId"],
      usuarioId: json["usuarioId"],
      empaqueTallos: json["empaqueTallos"],
      empaqueRamos: json["empaqueRamos"],
      empaqueDespachar: json["empaqueDespachar"],
      empaqueDerogado: json["empaqueDerogado"],
      empaqueDesde: json["empaqueDesde"],
      empaqueHasta: json["empaqueHasta"],
      postcosechaId: json["postcosechaId"],
      empaqueMarca: json["empaqueMarca"],
      ramosRevisar: json["ramosRevisar"],
      elite: json["elite"]);

  Map<String, dynamic> toJson() => {
        "controlEmpaqueId": controlEmpaqueId,
        "empaqueNumeroOrden": empaqueNumeroOrden,
        "empaqueTotal": empaqueTotal,
        "empaqueFecha": empaqueFecha,
        "empaqueAprobado": empaqueAprobado,
        "firmaId": firmaId,
        "clienteId": clienteId,
        "tipoClienteId": tipoClienteId,
        "productoId": productoId,
        "usuarioId": usuarioId,
        "empaqueTallos": empaqueTallos,
        "empaqueRamos": empaqueRamos,
        "empaqueDespachar": empaqueDespachar,
        "empaqueDerogado": empaqueDerogado,
        "empaqueDesde": empaqueDesde,
        "empaqueHasta": empaqueHasta,
        "postcosechaId": postcosechaId,
        "empaqueMarca": empaqueMarca,
        "ramosRevisar": ramosRevisar,
        "elite": elite
      };
}
