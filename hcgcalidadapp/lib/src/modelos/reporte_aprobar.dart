// To parse this JSON data, do
//
//     final reporteAprobacion = reporteAprobacionFromJson(jsonString);

import 'dart:convert';

ReporteAprobacion reporteAprobacionFromJson(String str) =>
    ReporteAprobacion.fromJson(json.decode(str));

String reporteAprobacionToJson(ReporteAprobacion data) =>
    json.encode(data.toJson());

class ReporteAprobacion {
  ReporteAprobacion(
      {this.clienteId,
      this.clienteNombre,
      this.inconformidadP,
      this.falenciaPrincipal,
      this.falenciaSegundaria,
      this.inconformidadEmpaqueCajasP,
      this.inconformidadEmpaqueRamosP,
      this.falenciaPrincipalEmpaque,
      this.falenciaSegundariaEmpaque,
      this.totalEmpaqueCajas,
      this.totalEmpaqueRamos,
      this.totalRamosRamos,
      this.aprobado,
      this.totalRamosRevisados,
      this.totalEmpaqueRamosRevisados,
      this.totalEmpaqueCajasRevisadas});

  int clienteId;
  String clienteNombre;
  double inconformidadP;
  String falenciaPrincipal;
  String falenciaSegundaria;
  double inconformidadEmpaqueCajasP;
  double inconformidadEmpaqueRamosP;
  String falenciaPrincipalEmpaque;
  String falenciaSegundariaEmpaque;
  int totalEmpaqueCajas;
  int totalEmpaqueRamos;
  int totalRamosRamos;
  int aprobado;
  int totalRamosRevisados;
  int totalEmpaqueRamosRevisados;
  int totalEmpaqueCajasRevisadas;

  factory ReporteAprobacion.fromJson(Map<String, dynamic> json) =>
      ReporteAprobacion(
          clienteId: json["clienteId"],
          clienteNombre: json["clienteNombre"],
          inconformidadP: json["inconformidadP"].toDouble(),
          falenciaPrincipal: json["falenciaPrincipal"],
          falenciaSegundaria: json["falenciaSegundaria"],
          inconformidadEmpaqueCajasP:
              json["inconformidadEmpaqueCajasP"].toDouble(),
          inconformidadEmpaqueRamosP:
              json["inconformidadEmpaqueRamosP"].toDouble(),
          falenciaPrincipalEmpaque: json["falenciaPrincipalEmpaque"],
          falenciaSegundariaEmpaque: json["falenciaSegundariaEmpaque"],
          totalEmpaqueCajas: json["totalEmpaqueCajas"],
          totalEmpaqueRamos: json["totalEmpaqueRamos"],
          totalRamosRamos: json["totalRamosRamos"],
          aprobado: json["aprobado"],
          totalRamosRevisados: json["totalRamosRevisados"],
          totalEmpaqueRamosRevisados: json["totalEmpaqueRamosRevisados"],
          totalEmpaqueCajasRevisadas: json["totalEmpaqueCajasRevisadas"]);

  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "clienteNombre": clienteNombre,
        "inconformidadP": inconformidadP,
        "falenciaPrincipal": falenciaPrincipal,
        "falenciaSegundaria": falenciaSegundaria,
        "inconformidadEmpaqueCajasP": inconformidadEmpaqueCajasP,
        "inconformidadEmpaqueRamosP": inconformidadEmpaqueRamosP,
        "falenciaPrincipalEmpaque": falenciaPrincipalEmpaque,
        "falenciaSegundariaEmpaque": falenciaSegundariaEmpaque,
        "totalEmpaqueCajas": totalEmpaqueCajas,
        "totalEmpaqueRamos": totalEmpaqueRamos,
        "totalRamosRamos": totalRamosRamos,
        "aprobado": aprobado,
        "totalRamosRevisados": totalRamosRevisados,
        "totalEmpaqueRamosRevisados": totalEmpaqueRamosRevisados,
        "totalEmpaqueCajasRevisadas": totalEmpaqueCajasRevisadas
      };
}

// ReporteAprobacion reporteAprobacionBandaFromJson(String str) => ReporteAprobacion.fromJson(json.decode(str));

// String reporteAprobacionBandaToJson(ReporteAprobacion data) => json.encode(data.toJson());

OrdenEmpaque ordenEmpaqueFromJson(String str) =>
    OrdenEmpaque.fromJson(json.decode(str));

String ordenEmpaqueToJson(OrdenEmpaque data) => json.encode(data.toJson());

class OrdenEmpaque {
  OrdenEmpaque(
      {this.ordenEmpaqueId,
      this.empaqueId,
      this.clienteNombre,
      this.postCosechaNombre,
      this.productoNombre,
      this.marca,
      this.empaqueInconformidadCajas,
      this.empaqueInconformidadRamos,
      this.numeroOrden,
      this.ramosRevisados,
      this.cajasRevisadas});

  int ordenEmpaqueId;
  int empaqueId;
  String clienteNombre;
  String postCosechaNombre;
  String productoNombre;
  String marca;
  String numeroOrden;
  double empaqueInconformidadCajas;
  double empaqueInconformidadRamos;
  int ramosRevisados;
  int cajasRevisadas;
  int cajasDespachar;
  String falenciaPrincipalRamos;
  String falenciaPrincipalCajas;
  String falenciaSegundariaRamos;
  String falenciaSegundariaCajas;
  int ramosNoConformes;
  factory OrdenEmpaque.fromJson(Map<String, dynamic> json) => OrdenEmpaque(
        ordenEmpaqueId: json["ordenEmpaqueId"],
        empaqueId: json["empaqueId"],
        clienteNombre: json["clienteNombre"],
        postCosechaNombre: json["postCosechaNombre"],
        productoNombre: json["productoNombre"],
        marca: json["marca"],
        numeroOrden: json["numeroOrden"],
        ramosRevisados: json["ramosRevisados"],
        cajasRevisadas: json["cajasRevisadas"],
        empaqueInconformidadCajas: json["empaqueInconformidadCajas"].toDouble(),
        empaqueInconformidadRamos: json["empaqueInconformidadRamos"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ordenEmpaqueId": ordenEmpaqueId,
        "empaqueId": empaqueId,
        "clienteNombre": clienteNombre,
        "postCosechaNombre": postCosechaNombre,
        "productoNombre": productoNombre,
        "marca": marca,
        "numeroOrden": numeroOrden,
        "empaqueInconformidadCajas": empaqueInconformidadCajas,
        "empaqueInconformidadRamos": empaqueInconformidadRamos,
        "ramosRevisados": ramosRevisados,
        "cajasRevisadas": cajasRevisadas,
      };
}

OrdenRamo ordenRamoFromJson(String str) => OrdenRamo.fromJson(json.decode(str));

String ordenRamoToJson(OrdenRamo data) => json.encode(data.toJson());

class OrdenRamo {
  OrdenRamo(
      {this.ordenRamoId,
      this.numeroOrden,
      this.clienteNombre,
      this.postCosechaNombre,
      this.productoNombre,
      this.marca,
      this.ramoInconformidad,
      this.ramosRevisados,
      this.ramosElaborados,
      this.ramosADespachar,
      this.inspeccion,
      this.ramosNoConformes,
      this.falenciaPrincipal,
      this.falenciaSegundaria});

  int ordenRamoId;
  String numeroOrden;
  String clienteNombre;
  String postCosechaNombre;
  String productoNombre;
  String marca;
  double ramoInconformidad;
  int ramosRevisados;
  int ramosADespachar;
  int ramosElaborados;
  double inspeccion;
  int ramosNoConformes;
  String falenciaPrincipal;
  String falenciaSegundaria;

  factory OrdenRamo.fromJson(Map<String, dynamic> json) => OrdenRamo(
        ordenRamoId: json["ordenRamoId"],
        numeroOrden: json["numeroOrden"],
        clienteNombre: json["clienteNombre"],
        postCosechaNombre: json["postCosechaNombre"],
        productoNombre: json["productoNombre"],
        marca: json["marca"],
        ramosRevisados: json["ramosRevisados"],
        ramoInconformidad: json["ramoInconformidad"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ordenRamoId": ordenRamoId,
        "numeroOrden": numeroOrden,
        "clienteNombre": clienteNombre,
        "postCosechaNombre": postCosechaNombre,
        "productoNombre": productoNombre,
        "marca": marca,
        "ramoInconformidad": ramoInconformidad,
        "ramosRevisados": ramosRevisados,
      };
}
