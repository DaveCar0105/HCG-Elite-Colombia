import 'dart:convert';
import 'package:hcgcalidadapp/src/basedatos/database_creator.dart';

ControlDestinoEcommerceDto controlDestinoEcommerceFromJson(String str) =>
    ControlDestinoEcommerceDto.fromJson(json.decode(str));

String controlDestinoEcommerceToJson(ControlDestinoEcommerceDto data) =>
    json.encode(data.toJson());

class ControlDestinoEcommerceDto {
  ControlDestinoEcommerceDto(
      {this.controlDestinoEcommerceId,
      this.detalleFirmaId,
      this.productoId,
      this.usuarioId,
      this.controlDestinoEcommerceFecha,
      this.controlDestinoEcommerceRevisar,
      this.controlDestinoEcommerceAprobado,
      this.controlDestinoEcommerceTallos,
      this.controlDestinoEcommerceDespachar,
      this.controlDestinoEcommerceCorte1,
      this.controlDestinoEcommerceCorte2,
      this.controlDestinoEcommerceCorte3,
      this.postcosechaId,
      this.variedadId,
      this.controlDestinoEcommerceAccionesTomadas,
      this.controlDestinoEcommerceDesde,
      this.controlDestinoEcommerceHasta,
      this.clienteId});

  int controlDestinoEcommerceId = 0;
  int detalleFirmaId;
  int productoId;
  int usuarioId;
  DateTime controlDestinoEcommerceFecha;
  int controlDestinoEcommerceRevisar;
  int controlDestinoEcommerceAprobado;
  int controlDestinoEcommerceTallos;
  int controlDestinoEcommerceDespachar;
  double controlDestinoEcommerceCorte1;
  double controlDestinoEcommerceCorte2;
  double controlDestinoEcommerceCorte3;
  int postcosechaId;
  int variedadId;
  String controlDestinoEcommerceAccionesTomadas;
  int controlDestinoEcommerceDesde;
  int controlDestinoEcommerceHasta;
  int clienteId;

  factory ControlDestinoEcommerceDto.fromJson(Map<String, dynamic> json) =>
      ControlDestinoEcommerceDto(
          controlDestinoEcommerceId:
              json[DatabaseCreator.controlDestinoEcommerceId],
          detalleFirmaId: json[DatabaseCreator.detalleFirmaId],
          productoId: json[DatabaseCreator.productoId],
          usuarioId: json[DatabaseCreator.usuarioId],
          controlDestinoEcommerceFecha: DateTime.parse(
              json[DatabaseCreator.controlDestinoEcommerceFecha]),
          controlDestinoEcommerceRevisar:
              json[DatabaseCreator.controlDestinoEcommerceRevisar],
          controlDestinoEcommerceAprobado:
              json[DatabaseCreator.controlDestinoEcommerceAprobado],
          controlDestinoEcommerceTallos:
              json[DatabaseCreator.controlDestinoEcommerceTallos],
          controlDestinoEcommerceDespachar:
              json[DatabaseCreator.controlDestinoEcommerceDespachar],
          controlDestinoEcommerceCorte1:
              json[DatabaseCreator.controlDestinoEcommerceCorte1],
          controlDestinoEcommerceCorte2:
              json[DatabaseCreator.controlDestinoEcommerceCorte2],
          controlDestinoEcommerceCorte3:
              json[DatabaseCreator.controlDestinoEcommerceCorte3],
          postcosechaId: json[DatabaseCreator.postcosechaId],
          variedadId: json[DatabaseCreator.variedadId],
          controlDestinoEcommerceAccionesTomadas:
              json[DatabaseCreator.controlDestinoEcommerceAccionesTomadas],
          controlDestinoEcommerceDesde:
              json[DatabaseCreator.controlDestinoEcommerceDesde],
          controlDestinoEcommerceHasta:
              json[DatabaseCreator.controlDestinoEcommerceHasta],
          clienteId: json[DatabaseCreator.clienteId]);

  Map<String, dynamic> toJson() => {
        "controlDestinoEcommerceId": controlDestinoEcommerceId,
        "detalleFirmaId": detalleFirmaId,
        "productoId": productoId,
        "usuarioId": usuarioId,
        "controlDestinoEcommerceFecha":
            controlDestinoEcommerceFecha.toIso8601String(),
        "controlDestinoEcommerceRevisar": controlDestinoEcommerceRevisar,
        "controlDestinoEcommerceAprobado": controlDestinoEcommerceAprobado,
        "controlDestinoEcommerceTallos": controlDestinoEcommerceTallos,
        "controlDestinoEcommerceDespachar": controlDestinoEcommerceDespachar,
        "controlDestinoEcommerceCorte1": controlDestinoEcommerceCorte1,
        "controlDestinoEcommerceCorte2": controlDestinoEcommerceCorte2,
        "controlDestinoEcommerceCorte3": controlDestinoEcommerceCorte3,
        "postcosechaId": postcosechaId,
        "variedadId": variedadId,
        "controlDestinoEcommerceAccionesTomadas":
            controlDestinoEcommerceAccionesTomadas,
        "controlDestinoEcommerceDesde": controlDestinoEcommerceDesde,
        "controlDestinoEcommerceHasta": controlDestinoEcommerceHasta,
        "clienteId": clienteId
      };
}
