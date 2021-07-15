import 'dart:convert';

TipoActividad tipoActividadFromJson(String str) =>
    TipoActividad.fromJson(json.decode(str));

String tipoActividadToJson(TipoActividad data) => json.encode(data.toJson());

class TipoActividad {
  TipoActividad({this.tipoActividadId, this.tipoActividadDescripcion});

  int tipoActividadId;
  String tipoActividadDescripcion;

  factory TipoActividad.fromJson(Map<String, dynamic> json) => TipoActividad(
        tipoActividadId: json["tipoActividadId"],
        tipoActividadDescripcion: json["tipoActividadDescripcion"],
      );

  Map<String, dynamic> toJson() => {
        "tipoActividadId": tipoActividadId,
        "tipoActividadDescripcion": tipoActividadDescripcion,
      };
}
