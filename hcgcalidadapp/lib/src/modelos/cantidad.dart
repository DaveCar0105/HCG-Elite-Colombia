// To parse this JSON data, do
//
//     final cantidad = cantidadFromJson(jsonString);

import 'dart:convert';

Cantidad cantidadFromJson(String str) => Cantidad.fromJson(json.decode(str));

String cantidadToJson(Cantidad data) => json.encode(data.toJson());

class Cantidad {
  Cantidad({
    this.ramos,
    this.empaque,
    this.temperaturas,
    this.procesoEmp,
    this.procesoHid,
    this.actividades,
    this.banda,
    this.ecuador
  });

  int ramos;
  int empaque;
  int temperaturas;
  int procesoEmp;
  int procesoHid;
  int actividades;
  int banda;
  int ecuador;

  factory Cantidad.fromJson(Map<String, dynamic> json) => Cantidad(
    ramos: json["ramos"],
    empaque: json["empaque"],
    temperaturas: json["temperaturas"],
    procesoEmp: json["procesoEmp"],
    procesoHid: json["procesoHid"],
    actividades: json["actividades"],
    banda: json["banda"],
    ecuador: json["ecuador"],
  );

  Map<String, dynamic> toJson() => {
    "ramos": ramos,
    "empaque": empaque,
    "temperaturas": temperaturas,
    "procesoEmp": procesoEmp,
    "procesoHid": procesoHid,
    "actividades": actividades,
    "banda": banda,
    "ecuador": ecuador,
  };
}
