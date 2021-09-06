import 'dart:convert';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';

VariedadDto variedadDtoFromJson(String str) =>
    VariedadDto.fromJson(json.decode(str));

String variedadDtoToJson(VariedadDto data) => json.encode(data.toJson());

class VariedadDto {
  VariedadDto({this.variedadId, this.variedadNombre});

  int variedadId;
  String variedadNombre;

  factory VariedadDto.fromJson(Map<String, dynamic> json) => VariedadDto(
        variedadId: json[DatabaseCreator.variedadId],
        variedadNombre: json[DatabaseCreator.variedadTableNombre],
      );

  Map<String, dynamic> toJson() => {
        "variedadId": variedadId,
        "variedadNombre": variedadNombre,
      };
}
