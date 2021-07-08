import 'dart:convert';

TipoControl tipoControlFromJson(String str) => TipoControl.fromJson(json.decode(str));

String tipoControlToJson(TipoControl data) => json.encode(data.toJson());

class TipoControl {
  TipoControl({
    this.tipoControlId,
    this.tipoControlNombre,
    this.claseId
  });

  int tipoControlId;
  String tipoControlNombre;
  int claseId;

  factory TipoControl.fromJson(Map<String, dynamic> json) => TipoControl(
    tipoControlId: json["tipoControlId"],
    tipoControlNombre: json["tipoControlNombre"],
  );

  Map<String, dynamic> toJson() => {
    "tipoControlId": tipoControlId,
    "tipoControlNombre": tipoControlNombre,
  };
}
