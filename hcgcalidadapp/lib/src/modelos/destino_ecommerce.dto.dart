import 'dart:convert';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';

DestinoEcommerceDto destinoEcommerceDtoFromJson(String str) =>
    DestinoEcommerceDto.fromJson(json.decode(str));

String destinoEcommerceDtoToJson(DestinoEcommerceDto data) =>
    json.encode(data.toJson());

class DestinoEcommerceDto {
  DestinoEcommerceDto(
      {this.destinoEcommerceId, this.controlDestinoEcommerceId});

  int destinoEcommerceId;
  int controlDestinoEcommerceId;

  factory DestinoEcommerceDto.fromJson(Map<String, dynamic> json) =>
      DestinoEcommerceDto(
        destinoEcommerceId: json[DatabaseCreator.destinoEcommerceId],
        controlDestinoEcommerceId:
            json[DatabaseCreator.controlDestinoEcommerceId],
      );

  Map<String, dynamic> toJson() => {
        "destinoEcommerceId": destinoEcommerceId,
        "controlDestinoEcommerceId": controlDestinoEcommerceId,
      };
}

DestinoEcommerceDetalleFalenciaDto destinoEcommerceDetalleFalenciaDtoFromJson(
        String str) =>
    DestinoEcommerceDetalleFalenciaDto.fromJson(json.decode(str));

String destinoEcommerceDetalleFalenciaDtoToJson(
        DestinoEcommerceDetalleFalenciaDto data) =>
    json.encode(data.toJson());

class DestinoEcommerceDetalleFalenciaDto {
  DestinoEcommerceDetalleFalenciaDto(
      {this.destinoEcommerceId,
      this.controlDestinoEcommerceId,
      this.cantidadFalencias});

  int destinoEcommerceId;
  int controlDestinoEcommerceId;
  int cantidadFalencias;

  factory DestinoEcommerceDetalleFalenciaDto.fromJson(
          Map<String, dynamic> json) =>
      DestinoEcommerceDetalleFalenciaDto(
          destinoEcommerceId: json[DatabaseCreator.destinoEcommerceId],
          controlDestinoEcommerceId:
              json[DatabaseCreator.controlDestinoEcommerceId],
          cantidadFalencias: json['cantidadFalencias']);

  Map<String, dynamic> toJson() => {
        "destinoEcommerceId": destinoEcommerceId,
        "controlDestinoEcommerceId": controlDestinoEcommerceId,
        "cantidadFalencias": cantidadFalencias,
      };
}
