import 'dart:convert';

ControlRamos ramosFromJson(String str) =>
    ControlRamos.fromJson(json.decode(str));

String ramosToJson(ControlRamos data) => json.encode(data.toJson());

class ControlRamos {
  ControlRamos(
      {this.controlRamosId,
      this.ramosNumeroOrden,
      this.ramosTotal,
      this.ramosFecha,
      this.ramosAprobado,
      this.detalleFirmaId,
      this.clienteId,
      this.tipoClienteId,
      this.productoId,
      this.usuarioId,
      this.ramosTallos,
      this.ramosDespachar,
      this.ramosElaborados,
      this.ramosDerogado,
      this.ramosDesde,
      this.ramosHasta,
      this.postcosechaId,
      this.ramosMarca,
      this.elite,
      this.tipoId});

  int controlRamosId = 0;
  String ramosNumeroOrden;
  int ramosTotal;
  String ramosFecha;
  int ramosAprobado;
  int detalleFirmaId;
  int clienteId;
  int tipoClienteId;
  int productoId;
  int usuarioId;
  int ramosTallos;
  int ramosDespachar;
  int ramosElaborados;
  String ramosDerogado;
  int ramosDesde;
  int ramosHasta;
  int postcosechaId;
  String ramosMarca;
  int elite;
  int tipoId;

  factory ControlRamos.fromJson(Map<String, dynamic> json) => ControlRamos(
      controlRamosId: json["controlRamosId"],
      ramosNumeroOrden: json["ramosNumeroOrden"],
      ramosTotal: json["ramosTotal"],
      ramosFecha: json["ramosFecha"],
      ramosAprobado: json["ramosAprobado"],
      detalleFirmaId: json["detalleFirmaId"],
      clienteId: json["clienteId"],
      tipoClienteId: json["tipoClienteId"],
      productoId: json["productoId"],
      usuarioId: json["usuarioId"],
      ramosTallos: json["ramosTallos"],
      ramosDespachar: json["ramosDespachar"],
      ramosElaborados: json["ramosElaborados"],
      ramosDerogado: json["ramosDerogado"],
      ramosDesde: json["ramosDesde"].toDouble(),
      ramosHasta: json["ramosHasta"].toDouble(),
      postcosechaId: json["postcosechaId"],
      ramosMarca: json["ramosMarca"],
      elite: json["elite"]);

  Map<String, dynamic> toJson() => {
        "controlRamosId": controlRamosId,
        "ramosNumeroOrden": ramosNumeroOrden,
        "ramosTotal": ramosTotal,
        "ramosFecha": ramosFecha,
        "ramosAprobado": ramosAprobado,
        "detalleFirmaId": detalleFirmaId,
        "clienteId": clienteId,
        "tipoClienteId": tipoClienteId,
        "productoId": productoId,
        "usuarioId": usuarioId,
        "ramosTallos": ramosTallos,
        "ramosDespachar": ramosDespachar,
        "ramosElaborados": ramosElaborados,
        "ramosDerogado": ramosDerogado,
        "ramosDesde": ramosDesde,
        "ramosHasta": ramosHasta,
        "postcosechaId": postcosechaId,
        "ramosMarca": ramosMarca,
        "elite": elite
      };
}
