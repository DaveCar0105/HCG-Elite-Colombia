import 'dart:convert';

TipoCliente tipoClienteFromJson(String str) =>
    TipoCliente.fromJson(json.decode(str));

String tipoClienteToJson(TipoCliente data) => json.encode(data.toJson());

class TipoCliente {
  TipoCliente({this.tipoClienteId, this.tipoClienteNombre});

  int tipoClienteId;
  String tipoClienteNombre;

  factory TipoCliente.fromJson(Map<String, dynamic> json) => TipoCliente(
        tipoClienteId: json["tipoClienteId"],
        tipoClienteNombre: json["tipoClienteNombre"],
      );

  Map<String, dynamic> toJson() =>
      {"tipoClienteId": tipoClienteId, "tipoClienteNombre": tipoClienteNombre};
}
