import 'dart:convert';

Actividad actividadFromJson(String str) => Actividad.fromJson(json.decode(str));

String actividadToJson(Actividad data) => json.encode(data.toJson());

class Actividad {
  Actividad(
      {this.actividadId,
      this.actividadUsuarioControlId,
      this.actividadDetalle,
      this.actividadHoraInicio,
      this.actividadHoraFin,
      this.actividadFecha,
      this.postcosechaId,
      this.tipoActividadId,
      this.tipoActividadDescripcion
      //this.
      });

  int actividadId;
  int actividadUsuarioControlId;
  String actividadDetalle;
  String actividadHoraInicio;
  String actividadHoraFin;
  DateTime actividadFecha;
  int postcosechaId;
  int tipoActividadId;
  String tipoActividadDescripcion;

  factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        actividadId: json["actividadId"],
        actividadUsuarioControlId: json["actividadUsuarioControlId"],
        actividadDetalle: json["actividadDetalle"],
        actividadHoraInicio: json["actividadHoraInicio"],
        actividadHoraFin: json["actividadHoraFin"],
        postcosechaId: json["postcosechaId"],
        tipoActividadId: json["tipoActividadId"],
        tipoActividadDescripcion: json["tipoActividadDescripcion"],
        actividadFecha: DateTime.parse(json["actividadFecha"]),
      );

  Map<String, dynamic> toJson() => {
        "actividadId": actividadId,
        "actividadUsuarioControlId": actividadUsuarioControlId,
        "actividadDetalle": actividadDetalle,
        "actividadHoraInicio": actividadHoraInicio,
        "actividadHoraFin": actividadHoraFin,
        "postcosechaId": postcosechaId,
        "tipoActividadId": tipoActividadId,
        "tipoActividadDescripcion":tipoActividadDescripcion,
        "actividadFecha": actividadFecha.toIso8601String(),
      };
}
