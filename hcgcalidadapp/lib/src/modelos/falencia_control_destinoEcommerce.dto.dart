import 'dart:convert';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';

FalenciaControlDestinoEcommerceDto falenciaControlDestinoEcommerceDtoFromJson(
        String str) =>
    FalenciaControlDestinoEcommerceDto.fromJson(json.decode(str));

String falenciaControlDestinoEcommerceDtoToJson(
        FalenciaControlDestinoEcommerceDto data) =>
    json.encode(data.toJson());

class FalenciaControlDestinoEcommerceDto {
  FalenciaControlDestinoEcommerceDto(
      {this.falenciasControlDestinoEcommerceId,
      this.destinoEcommerceId,
      this.falenciaRamosId,
      this.falenciasControlDestinoEcommerceCantidad});

  int falenciasControlDestinoEcommerceId;
  int destinoEcommerceId;
  int falenciaRamosId;
  int falenciasControlDestinoEcommerceCantidad;

  factory FalenciaControlDestinoEcommerceDto.fromJson(
          Map<String, dynamic> json) =>
      FalenciaControlDestinoEcommerceDto(
        falenciasControlDestinoEcommerceId:
            json[DatabaseCreator.falenciasControlDestinoEcommerceId],
        destinoEcommerceId: json[DatabaseCreator.destinoEcommerceId],
        falenciaRamosId: json[DatabaseCreator.falenciaRamosId],
        falenciasControlDestinoEcommerceCantidad:
            json[DatabaseCreator.falenciasControlDestinoEcommerceCantidad],
      );

  Map<String, dynamic> toJson() => {
        "falenciasControlDestinoEcommerceId":
            falenciasControlDestinoEcommerceId,
        "destinoEcommerceId": destinoEcommerceId,
        "falenciaRamosId": falenciaRamosId,
        "falenciasControlDestinoEcommerceCantidad":
            falenciasControlDestinoEcommerceCantidad,
      };
}

FalenciaReporteDestinoEcommerce falenciaReporteDestinoEcommerceFromJson(
        String str) =>
    FalenciaReporteDestinoEcommerce.fromJson(json.decode(str));

String falenciaReporteDestinoEcommerceToJson(
        FalenciaReporteDestinoEcommerce data) =>
    json.encode(data.toJson());

class FalenciaReporteDestinoEcommerce {
  FalenciaReporteDestinoEcommerce(
      {this.falenciasControlDestinoEcommerceId,
      this.falenciasControlDestinoEcommerceCantidad,
      this.falenciasReporteDestinoEcommercePorcentaje,
      this.falenciaRamosId,
      this.destinoEcommerceId,
      this.falenciaRamosNombre,
      this.total});

  int falenciasControlDestinoEcommerceId;
  int falenciasControlDestinoEcommerceCantidad;
  String falenciasReporteDestinoEcommercePorcentaje;
  int falenciaRamosId;
  int destinoEcommerceId;
  String falenciaRamosNombre;
  int total;

  factory FalenciaReporteDestinoEcommerce.fromJson(Map<String, dynamic> json) =>
      FalenciaReporteDestinoEcommerce(
          falenciasControlDestinoEcommerceId:
              json[DatabaseCreator.falenciasControlDestinoEcommerceId],
          falenciasControlDestinoEcommerceCantidad:
              json[DatabaseCreator.falenciasControlDestinoEcommerceCantidad],
          falenciasReporteDestinoEcommercePorcentaje:
              json["falenciasReporteDestinoEcommercePorcentaje"],
          falenciaRamosId: json[DatabaseCreator.falenciaRamosId],
          destinoEcommerceId: json[DatabaseCreator.destinoEcommerceId],
          total: json["total"]);

  Map<String, dynamic> toJson() => {
        "falenciasControlDestinoEcommerceId":
            falenciasControlDestinoEcommerceId,
        "falenciasControlDestinoEcommerceCantidad":
            falenciasControlDestinoEcommerceCantidad,
        "falenciasReporteDestinoEcommercePorcentaje":
            falenciasReporteDestinoEcommercePorcentaje,
        "falenciaRamosId": falenciaRamosId,
        "destinoEcommerceId": destinoEcommerceId,
        "total": total
      };
}
