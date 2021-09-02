// To parse this JSON data, do
//
//     final reporteSincronizacion = reporteSincronizacionFromJson(jsonString);

import 'dart:convert';

import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';

ReporteSincronizacionEmpaque reporteSincronizacionFromJson(String str) =>
    ReporteSincronizacionEmpaque.fromJson(json.decode(str));

String reporteSincronizacionToJson(ReporteSincronizacionEmpaque data) =>
    json.encode(data.toJson());

class ReporteSincronizacionEmpaque {
  ReporteSincronizacionEmpaque({
    this.firmas,
    this.detallesFirma,
    this.listaEmpaque,
  });

  List<Firmas> firmas;
  List<DetallesFirma> detallesFirma;
  List<ListaEmpaque> listaEmpaque;

  factory ReporteSincronizacionEmpaque.fromJson(Map<String, dynamic> json) =>
      ReporteSincronizacionEmpaque(
        firmas:
            List<Firmas>.from(json["firmas"].map((x) => Firmas.fromJson(x))),
        detallesFirma: List<DetallesFirma>.from(
            json["detallesFirma"].map((x) => DetallesFirma.fromJson(x))),
        listaEmpaque: List<ListaEmpaque>.from(
            json["listaEmpaque"].map((x) => ListaEmpaque.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firmas": List<dynamic>.from(firmas.map((x) => x.toJson())),
        "detallesFirma":
            List<dynamic>.from(detallesFirma.map((x) => x.toJson())),
        "listaEmpaque": List<dynamic>.from(listaEmpaque.map((x) => x.toJson())),
      };
}

ReporteSincronizacionRamo reporteSincronizacionramoFromJson(String str) =>
    ReporteSincronizacionRamo.fromJson(json.decode(str));

String reporteSincronizacionramoToJson(ReporteSincronizacionEmpaque data) =>
    json.encode(data.toJson());

class ReporteSincronizacionRamo {
  ReporteSincronizacionRamo({
    this.firmas,
    this.detallesFirma,
    this.listaRamo,
  });

  List<Firmas> firmas;
  List<DetallesFirma> detallesFirma;
  List<ListaRamo> listaRamo;

  factory ReporteSincronizacionRamo.fromJson(Map<String, dynamic> json) =>
      ReporteSincronizacionRamo(
        firmas:
            List<Firmas>.from(json["firmas"].map((x) => Firmas.fromJson(x))),
        detallesFirma: List<DetallesFirma>.from(
            json["detallesFirma"].map((x) => DetallesFirma.fromJson(x))),
        listaRamo: List<ListaRamo>.from(
            json["listaRamo"].map((x) => ListaRamo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firmas": List<dynamic>.from(firmas.map((x) => x.toJson())),
        "detallesFirma":
            List<dynamic>.from(detallesFirma.map((x) => x.toJson())),
        "listaRamo": List<dynamic>.from(listaRamo.map((x) => x.toJson())),
      };
}

ReporteSincronizacionFinalBanda reporteSincronizacionFinalBandaFromJson(
        String str) =>
    ReporteSincronizacionFinalBanda.fromJson(json.decode(str));

String reporteSincronizacionFinalBandaToJson(
        ReporteSincronizacionFinalBanda data) =>
    json.encode(data.toJson());

class ReporteSincronizacionFinalBanda {
  ReporteSincronizacionFinalBanda({
    this.firmas,
    this.detallesFirma,
    this.listaRamo,
  });

  List<Firmas> firmas;
  List<DetallesFirma> detallesFirma;
  List<ListaRamoBanda> listaRamo;

  factory ReporteSincronizacionFinalBanda.fromJson(Map<String, dynamic> json) =>
      ReporteSincronizacionFinalBanda(
        firmas:
            List<Firmas>.from(json["firmas"].map((x) => Firmas.fromJson(x))),
        detallesFirma: List<DetallesFirma>.from(
            json["detallesFirma"].map((x) => DetallesFirma.fromJson(x))),
        listaRamo: List<ListaRamoBanda>.from(
            json["listaRamo"].map((x) => ListaRamoBanda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firmas": List<dynamic>.from(firmas.map((x) => x.toJson())),
        "detallesFirma":
            List<dynamic>.from(detallesFirma.map((x) => x.toJson())),
        "listaRamo": List<dynamic>.from(listaRamo.map((x) => x.toJson())),
      };
}

ReporteSincronizacionProcesoMaritimo
    reporteSincronizacionProcesoMaritimoFromJson(String str) =>
        ReporteSincronizacionProcesoMaritimo.fromJson(json.decode(str));

String reporteSincronizacionProcesoMaritimoToJson(
        ReporteSincronizacionProcesoMaritimo data) =>
    json.encode(data.toJson());

class ReporteSincronizacionProcesoMaritimo {
  ReporteSincronizacionProcesoMaritimo({
    this.firmas,
    this.detallesFirma,
    this.procesoMaritimo,
  });

  List<Firmas> firmas;
  List<DetallesFirma> detallesFirma;
  List<ProcesoMaritimo> procesoMaritimo;

  factory ReporteSincronizacionProcesoMaritimo.fromJson(
          Map<String, dynamic> json) =>
      ReporteSincronizacionProcesoMaritimo(
        firmas:
            List<Firmas>.from(json["firmas"].map((x) => Firmas.fromJson(x))),
        detallesFirma: List<DetallesFirma>.from(
            json["detallesFirma"].map((x) => DetallesFirma.fromJson(x))),
        procesoMaritimo: List<ProcesoMaritimo>.from(
            json["procesoMaritimo"].map((x) => ProcesoMaritimo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firmas": List<dynamic>.from(firmas.map((x) => x.toJson())),
        "detallesFirma":
            List<dynamic>.from(detallesFirma.map((x) => x.toJson())),
        "procesoMaritimo":
            List<dynamic>.from(procesoMaritimo.map((x) => x.toJson())),
      };
}

ReporteSincronizacionProcesoMaritimoAlstroemeria
    reporteSincronizacionProcesoMaritimoAlstroemeriaFromJson(String str) =>
        ReporteSincronizacionProcesoMaritimoAlstroemeria.fromJson(
            json.decode(str));

String reporteSincronizacionProcesoMaritimoAlstroemeriaToJson(
        ReporteSincronizacionProcesoMaritimoAlstroemeria data) =>
    json.encode(data.toJson());

class ReporteSincronizacionProcesoMaritimoAlstroemeria {
  ReporteSincronizacionProcesoMaritimoAlstroemeria({
    this.firmas,
    this.detallesFirma,
    this.procesoMaritimoAlstro,
  });

  List<Firmas> firmas;
  List<DetallesFirma> detallesFirma;
  List<ProcesoMaritimoAlstroemeria> procesoMaritimoAlstro;

  factory ReporteSincronizacionProcesoMaritimoAlstroemeria.fromJson(
          Map<String, dynamic> json) =>
      ReporteSincronizacionProcesoMaritimoAlstroemeria(
        firmas:
            List<Firmas>.from(json["firmas"].map((x) => Firmas.fromJson(x))),
        detallesFirma: List<DetallesFirma>.from(
            json["detallesFirma"].map((x) => DetallesFirma.fromJson(x))),
        procesoMaritimoAlstro: List<ProcesoMaritimoAlstroemeria>.from(
            json["procesoMaritimoAlstro"]
                .map((x) => ProcesoMaritimoAlstroemeria.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "firmas": List<dynamic>.from(firmas.map((x) => x.toJson())),
        "detallesFirma":
            List<dynamic>.from(detallesFirma.map((x) => x.toJson())),
        "procesoMaritimoAlstro":
            List<dynamic>.from(procesoMaritimoAlstro.map((x) => x.toJson())),
      };
}

class Actividade {
  Actividade({
    this.actividadUsuarioControlId,
    this.actividadDetalle,
    this.actividadHoraInicio,
    this.actividadHoraFin,
    this.actividadFecha,
    this.postcosechaId,
    this.usuarioId,
  });

  int actividadUsuarioControlId;
  String actividadDetalle;
  String actividadHoraInicio;
  String actividadHoraFin;
  String actividadFecha;
  int postcosechaId;
  int usuarioId;

  factory Actividade.fromJson(Map<String, dynamic> json) => Actividade(
        actividadUsuarioControlId: json["actividadUsuarioControlId"],
        actividadDetalle: json["actividadDetalle"],
        actividadHoraInicio: json["actividadHoraInicio"],
        actividadHoraFin: json["actividadHoraFin"],
        actividadFecha: json["actividadFecha"],
        postcosechaId: json["postcosechaId"],
        usuarioId: json["usuarioId"],
      );

  Map<String, dynamic> toJson() => {
        "actividadUsuarioControlId": actividadUsuarioControlId,
        "actividadDetalle": actividadDetalle,
        "actividadHoraInicio": actividadHoraInicio,
        "actividadHoraFin": actividadHoraFin,
        "actividadFecha": actividadFecha,
        "usuarioId": usuarioId,
        "postcosechaId": postcosechaId
      };
}

class DetallesFirma {
  DetallesFirma({
    this.detalleFirmaId,
    this.firmaId,
    this.firmaReal,
    this.firmaCodigo,
  });

  int detalleFirmaId;
  int firmaId;
  int firmaReal;
  String firmaCodigo;

  factory DetallesFirma.fromJson(Map<String, dynamic> json) => DetallesFirma(
        detalleFirmaId: json["detalleFirmaId"],
        firmaId: json["firmaId"],
        firmaReal: json["firmaReal"],
        firmaCodigo: json["firmaCodigo"],
      );

  Map<String, dynamic> toJson() => {
        "detalleFirmaId": detalleFirmaId,
        "firmaId": firmaId,
        "firmaReal": firmaReal,
        "firmaCodigo": firmaCodigo,
      };
}

class Firmas {
  Firmas({
    this.firmaId,
    this.firmaReal,
    this.firmaNombre,
    this.firmaCargo,
    this.firmaCorreo,
    this.firmaCodigo,
  });

  int firmaId;
  int firmaReal;
  String firmaNombre;
  String firmaCargo;
  String firmaCorreo;
  String firmaCodigo;

  factory Firmas.fromJson(Map<String, dynamic> json) => Firmas(
        firmaId: json["firmaId"],
        firmaReal: json["firmaReal"],
        firmaNombre: json["firmaNombre"],
        firmaCargo: json["firmaCargo"],
        firmaCorreo: json["firmaCorreo"],
        firmaCodigo: json["firmaCodigo"],
      );

  Map<String, dynamic> toJson() => {
        "firmaId": firmaId,
        "firmaReal": firmaReal,
        "firmaNombre": firmaNombre,
        "firmaCargo": firmaCargo,
        "firmaCorreo": firmaCorreo,
        "firmaCodigo": firmaCodigo,
      };
}

class ListaEmpaque {
  ListaEmpaque({
    this.controlEmpaqueId,
    this.empaqueAprobado,
    this.usuarioId,
    this.empaqueNumeroOrden,
    this.empaqueTotal,
    this.clienteId,
    this.postcosechaId,
    this.productoId,
    this.empaqueDerogado,
    this.empaqueDespachar,
    this.empaqueRamos,
    this.empaqueTallos,
    this.empaqueFecha,
    this.detalleFirmaId,
    this.empaqueMarca,
    this.empaqueTiempo,
    this.empaqueRamosRevisar,
    this.elite,
    this.empaques,
  });

  int controlEmpaqueId;
  int empaqueAprobado;
  int usuarioId;
  String empaqueNumeroOrden;
  int empaqueTotal;
  int clienteId;
  int postcosechaId;
  int productoId;
  String empaqueDerogado;
  int empaqueDespachar;
  int empaqueRamos;
  int empaqueTallos;
  String empaqueFecha;
  int detalleFirmaId;
  String empaqueMarca;
  double empaqueTiempo;
  int empaqueRamosRevisar;
  int elite;
  List<Empaque> empaques;

  factory ListaEmpaque.fromJson(Map<String, dynamic> json) => ListaEmpaque(
        controlEmpaqueId: json["controlEmpaqueId"],
        empaqueAprobado: json["empaqueAprobado"],
        usuarioId: json["usuarioId"],
        empaqueNumeroOrden: json["empaqueNumeroOrden"],
        empaqueTotal: json["empaqueTotal"],
        clienteId: json["clienteId"],
        postcosechaId: json["postcosechaId"],
        productoId: json["productoId"],
        empaqueDerogado: json["empaqueDerogado"],
        empaqueDespachar: json["empaqueDespachar"],
        empaqueRamos: json["empaqueRamos"],
        empaqueTallos: json["empaqueTallos"],
        empaqueFecha: json["empaqueFecha"],
        detalleFirmaId: json["detalleFirmaId"],
        empaqueMarca: json["empaqueMarca "],
        empaqueTiempo: json["empaqueTiempo"].toDouble(),
        empaqueRamosRevisar: json["empaqueRamosRevisar"],
        elite: json["elite"],
        empaques: List<Empaque>.from(
            json["empaques"].map((x) => Empaque.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "controlEmpaqueId": controlEmpaqueId,
        "empaqueAprobado": empaqueAprobado,
        "usuarioId": usuarioId,
        "empaqueNumeroOrden": empaqueNumeroOrden,
        "empaqueTotal": empaqueTotal,
        "clienteId": clienteId,
        "postcosechaId": postcosechaId,
        "productoId": productoId,
        "empaqueDerogado": empaqueDerogado,
        "empaqueDespachar": empaqueDespachar,
        "empaqueRamos": empaqueRamos,
        "empaqueTallos": empaqueTallos,
        "empaqueFecha": empaqueFecha,
        "detalleFirmaId": detalleFirmaId,
        "empaqueMarca ": empaqueMarca,
        "empaqueTiempo": empaqueTiempo,
        "empaqueRamosRevisar": empaqueRamosRevisar,
        "elite": elite,
        "empaques": List<dynamic>.from(empaques.map((x) => x.toJson())),
      };
}

class Empaque {
  Empaque(
      {this.controlEmpaqueId,
      this.empaqueId,
      this.numeroMesa,
      this.variedad,
      this.linea,
      this.falencias,
      this.codigoEmpacador});

  int controlEmpaqueId;
  int empaqueId;
  String numeroMesa;
  String variedad;
  String linea;
  String codigoEmpacador;
  List<EmpaqueFalencia> falencias;

  factory Empaque.fromJson(Map<String, dynamic> json) => Empaque(
        controlEmpaqueId: json["controlEmpaqueId"],
        empaqueId: json["empaqueId"],
        numeroMesa: json["numeroMesa"],
        variedad: json["variedad"],
        linea: json["linea"],
        codigoEmpacador: json["codigoEmpacador"],
        falencias: List<EmpaqueFalencia>.from(
            json["falencias"].map((x) => EmpaqueFalencia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "controlEmpaqueId": controlEmpaqueId,
        "empaqueId": empaqueId,
        "numeroMesa": numeroMesa,
        "variedad": variedad,
        "linea": linea,
        "codigoEmpacador": codigoEmpacador,
        "falencias": List<dynamic>.from(falencias.map((x) => x.toJson())),
      };
}

class EmpaqueFalencia {
  EmpaqueFalencia({
    this.falenciaReporteEmpaqueId,
    this.falenciaEmpaqueId,
    this.cantidad,
  });

  int falenciaReporteEmpaqueId;
  int falenciaEmpaqueId;
  int cantidad;

  factory EmpaqueFalencia.fromJson(Map<String, dynamic> json) =>
      EmpaqueFalencia(
        falenciaReporteEmpaqueId: json["falenciaReporteEmpaqueId"],
        falenciaEmpaqueId: json["falenciaEmpaqueId"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "falenciaReporteEmpaqueId": falenciaReporteEmpaqueId,
        "falenciaEmpaqueId": falenciaEmpaqueId,
        "cantidad": cantidad,
      };
}

class ListaRamo {
  ListaRamo({
    this.controlRamosId,
    this.ramosNumeroOrden,
    this.ramosTotal,
    this.ramosFecha,
    this.ramosAprobado,
    this.detalleFirmaId,
    this.clienteId,
    this.productoId,
    this.usuarioId,
    this.ramosTallos,
    this.ramosDespachar,
    this.ramosElaborados,
    this.ramosDerogado,
    this.ramosTiempo,
    this.postcosechaId,
    this.ramosMarca,
    this.elite,
    this.ramos,
  });

  int controlRamosId;
  String ramosNumeroOrden;
  int ramosTotal;
  String ramosFecha;
  int ramosAprobado;
  int detalleFirmaId;
  int clienteId;
  int productoId;
  int usuarioId;
  int ramosTallos;
  int ramosDespachar;
  int ramosElaborados;
  String ramosDerogado;
  double ramosTiempo;
  int postcosechaId;
  String ramosMarca;
  int elite;
  List<Ramo> ramos;

  factory ListaRamo.fromJson(Map<String, dynamic> json) => ListaRamo(
        controlRamosId: json["controlRamosId"],
        ramosNumeroOrden: json["ramosNumeroOrden"],
        ramosTotal: json["ramosTotal"],
        ramosFecha: json["ramosFecha"],
        ramosAprobado: json["ramosAprobado"],
        detalleFirmaId: json["detalleFirmaId"],
        clienteId: json["clienteId"],
        productoId: json["productoId"],
        usuarioId: json["usuarioId"],
        ramosTallos: json["ramosTallos"],
        ramosDespachar: json["ramosDespachar"],
        ramosElaborados: json["ramosElaborados"],
        ramosDerogado: json["ramosDerogado"],
        ramosTiempo: json["ramosTiempo"].toDouble(),
        postcosechaId: json["postcosechaId"],
        ramosMarca: json["ramosMarca"],
        elite: json["elite"],
        ramos: List<Ramo>.from(json["ramos"].map((x) => Ramo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "controlRamosId": controlRamosId,
        "ramosNumeroOrden": ramosNumeroOrden,
        "ramosTotal": ramosTotal,
        "ramosFecha": ramosFecha,
        "ramosAprobado": ramosAprobado,
        "detalleFirmaId": detalleFirmaId,
        "clienteId": clienteId,
        "productoId": productoId,
        "usuarioId": usuarioId,
        "ramosTallos": ramosTallos,
        "ramosDespachar": ramosDespachar,
        "ramosElaborados": ramosElaborados,
        "ramosDerogado": ramosDerogado,
        "ramosTiempo": ramosTiempo,
        "postcosechaId": postcosechaId,
        "ramosMarca": ramosMarca,
        "elite": elite,
        "ramos": List<dynamic>.from(ramos.map((x) => x.toJson())),
      };
}

class ListaRamoBanda {
  ListaRamoBanda(
      {this.controlRamosId,
      this.ramosNumeroOrden,
      this.ramosTotal,
      this.ramosFecha,
      this.ramosAprobado,
      this.detalleFirmaId,
      this.clienteId,
      this.productoId,
      this.usuarioId,
      this.ramosTallos,
      this.ramosDespachar,
      this.ramosElaborados,
      this.ramosDerogado,
      this.ramosTiempo,
      this.postcosechaId,
      this.ramosMarca,
      this.elite,
      this.tipoId,
      this.bandas});

  int controlRamosId;
  String ramosNumeroOrden;
  int ramosTotal;
  String ramosFecha;
  int ramosAprobado;
  int detalleFirmaId;
  int clienteId;
  int productoId;
  int usuarioId;
  int ramosTallos;
  int ramosDespachar;
  int ramosElaborados;
  String ramosDerogado;
  double ramosTiempo;
  int postcosechaId;
  String ramosMarca;
  int elite;
  int tipoId;
  List<BandaSinc> bandas;

  factory ListaRamoBanda.fromJson(Map<String, dynamic> json) => ListaRamoBanda(
        controlRamosId: json["controlRamosId"],
        ramosNumeroOrden: json["ramosNumeroOrden"],
        ramosTotal: json["ramosTotal"],
        ramosFecha: json["ramosFecha"],
        ramosAprobado: json["ramosAprobado"],
        detalleFirmaId: json["detalleFirmaId"],
        clienteId: json["clienteId"],
        productoId: json["productoId"],
        usuarioId: json["usuarioId"],
        ramosTallos: json["ramosTallos"],
        ramosDespachar: json["ramosDespachar"],
        ramosElaborados: json["ramosElaborados"],
        ramosDerogado: json["ramosDerogado"],
        ramosTiempo: json["ramosTiempo"].toDouble(),
        postcosechaId: json["postcosechaId"],
        ramosMarca: json["ramosMarca"],
        elite: json["elite"],
        tipoId: json["tipoId"],
        bandas: List<BandaSinc>.from(
            json["ramos"].map((x) => BandaSinc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "controlRamosId": controlRamosId,
        "ramosNumeroOrden": ramosNumeroOrden,
        "ramosTotal": ramosTotal,
        "ramosFecha": ramosFecha,
        "ramosAprobado": ramosAprobado,
        "detalleFirmaId": detalleFirmaId,
        "clienteId": clienteId,
        "productoId": productoId,
        "usuarioId": usuarioId,
        "ramosTallos": ramosTallos,
        "ramosDespachar": ramosDespachar,
        "ramosElaborados": ramosElaborados,
        "ramosDerogado": ramosDerogado,
        "ramosTiempo": ramosTiempo,
        "postcosechaId": postcosechaId,
        "ramosMarca": ramosMarca,
        "elite": elite,
        "tipoId": tipoId,
        "bandas": List<dynamic>.from(bandas.map((x) => x.toJson())),
      };
}

class Ramo {
  Ramo({
    this.controlRamosId,
    this.ramoId,
    this.numeroMesa,
    this.variedad,
    this.linea,
    this.falencias,
  });

  int controlRamosId;
  int ramoId;
  String numeroMesa;
  String variedad;
  String linea;
  List<RamoFalencia> falencias;

  factory Ramo.fromJson(Map<String, dynamic> json) => Ramo(
        controlRamosId: json["controlRamosId"],
        ramoId: json["ramoId"],
        numeroMesa: json["numeroMesa"],
        variedad: json["variedad"],
        linea: json["linea"],
        falencias: List<RamoFalencia>.from(
            json["falencias"].map((x) => RamoFalencia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "controlRamosId": controlRamosId,
        "ramoId": ramoId,
        "numeroMesa": numeroMesa,
        "variedad": variedad,
        "linea": linea,
        "falencias": List<dynamic>.from(falencias.map((x) => x.toJson())),
      };
}

class BandaSinc {
  BandaSinc({
    this.controlRamosId,
    this.bandaId,
    this.numeroMesa,
    this.variedad,
    this.linea,
    this.falencias,
  });

  int controlRamosId;
  int bandaId;
  String numeroMesa;
  String variedad;
  String linea;
  List<BandaFalencia> falencias;

  factory BandaSinc.fromJson(Map<String, dynamic> json) => BandaSinc(
        controlRamosId: json["controlRamosId"],
        bandaId: json["bandaId"],
        numeroMesa: json["numeroMesa"],
        variedad: json["variedad"],
        linea: json["linea"],
        falencias: List<BandaFalencia>.from(
            json["falencias"].map((x) => BandaFalencia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "controlRamosId": controlRamosId,
        "bandaId": bandaId,
        "numeroMesa": numeroMesa,
        "variedad": variedad,
        "linea": linea,
        "falencias": List<dynamic>.from(falencias.map((x) => x.toJson())),
      };
}

class RamoFalencia {
  RamoFalencia({
    this.falenciaReporteRamoId,
    this.falenciaRamoId,
    this.cantidad,
  });

  int falenciaReporteRamoId;
  int falenciaRamoId;
  int cantidad;

  factory RamoFalencia.fromJson(Map<String, dynamic> json) => RamoFalencia(
        falenciaReporteRamoId: json["falenciaReporteRamoId"],
        falenciaRamoId: json["falenciaRamoId"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "falenciaReporteRamoId": falenciaReporteRamoId,
        "falenciaRamoId": falenciaRamoId,
        "cantidad": cantidad,
      };
}

class BandaFalencia {
  BandaFalencia({
    this.falenciaBandaId,
    this.falenciaRamoId,
    this.falenciaBandaRamos,
  });

  int falenciaBandaId;
  int falenciaRamoId;
  int falenciaBandaRamos;

  factory BandaFalencia.fromJson(Map<String, dynamic> json) => BandaFalencia(
        falenciaBandaId: json["falenciaBandaId"],
        falenciaRamoId: json["falenciaRamoId"],
        falenciaBandaRamos: json["falenciaBandaRamos"],
      );

  Map<String, dynamic> toJson() => {
        "falenciaBandaId": falenciaBandaId,
        "falenciaRamoId": falenciaRamoId,
        "falenciaBandaRamos": falenciaBandaRamos,
      };
}

class ProcesoEmpaque {
  ProcesoEmpaque(
      {this.procesoEmpaqueUsuarioControlId,
      this.procesoEmpaqueAltura,
      this.procesoEmpaqueCajas,
      this.procesoEmpaqueSujeccion,
      this.procesoEmpaqueMovimientos,
      this.procesoEmpaqueTemperaturaCuartoFrio,
      this.procesoEmpaqueTemperaturaCajas,
      this.procesoEmpaqueTemperaturaCamion,
      this.procesoEmpaqueApilamiento,
      this.procesoEmpaqueFecha,
      this.usuarioId,
      this.postcosechaId});

  int procesoEmpaqueUsuarioControlId;
  int procesoEmpaqueAltura;
  int procesoEmpaqueCajas;
  int procesoEmpaqueSujeccion;
  int procesoEmpaqueMovimientos;
  int procesoEmpaqueTemperaturaCuartoFrio;
  int procesoEmpaqueTemperaturaCajas;
  int procesoEmpaqueTemperaturaCamion;
  int procesoEmpaqueApilamiento;
  String procesoEmpaqueFecha;
  int usuarioId;
  int postcosechaId;
  factory ProcesoEmpaque.fromJson(Map<String, dynamic> json) => ProcesoEmpaque(
        procesoEmpaqueUsuarioControlId: json["procesoEmpaqueUsuarioControlId"],
        procesoEmpaqueAltura: json["procesoEmpaqueAltura"],
        procesoEmpaqueCajas: json["procesoEmpaqueCajas"],
        procesoEmpaqueSujeccion: json["procesoEmpaqueSujeccion"],
        procesoEmpaqueMovimientos: json["procesoEmpaqueMovimientos"],
        procesoEmpaqueTemperaturaCuartoFrio:
            json["procesoEmpaqueTemperaturaCuartoFrio"],
        procesoEmpaqueTemperaturaCajas: json["procesoEmpaqueTemperaturaCajas"],
        procesoEmpaqueTemperaturaCamion:
            json["procesoEmpaqueTemperaturaCamion"],
        procesoEmpaqueApilamiento: json["procesoEmpaqueApilamiento"],
        procesoEmpaqueFecha: json["procesoEmpaqueFecha"],
        usuarioId: json["usuarioId"],
        postcosechaId: json["postcosechaId"],
      );

  Map<String, dynamic> toJson() => {
        "procesoEmpaqueUsuarioControlId": procesoEmpaqueUsuarioControlId,
        "procesoEmpaqueAltura": procesoEmpaqueAltura,
        "procesoEmpaqueCajas": procesoEmpaqueCajas,
        "procesoEmpaqueSujeccion": procesoEmpaqueSujeccion,
        "procesoEmpaqueMovimientos": procesoEmpaqueMovimientos,
        "procesoEmpaqueTemperaturaCuartoFrio":
            procesoEmpaqueTemperaturaCuartoFrio,
        "procesoEmpaqueTemperaturaCajas": procesoEmpaqueTemperaturaCajas,
        "procesoEmpaqueTemperaturaCamion": procesoEmpaqueTemperaturaCamion,
        "procesoEmpaqueApilamiento": procesoEmpaqueApilamiento,
        "procesoEmpaqueFecha": procesoEmpaqueFecha,
        "usuarioId": usuarioId,
        "postcosechaId": postcosechaId,
      };
}

class RegistroHidratacion {
  RegistroHidratacion(
      {this.procesoHidratacionUsuarioControlId,
      this.procesoHidratacionEstadoSoluciones,
      this.procesoHidratacionTiemposHidratacion,
      this.procesoHidratacionCantidadRamos,
      this.procesoHidratacionPhSolucion,
      this.procesoHidratacionNivelSolucion,
      this.procesoHidratacionFecha,
      this.usuarioId,
      this.postcosechaId});

  int procesoHidratacionUsuarioControlId;
  int procesoHidratacionEstadoSoluciones;
  int procesoHidratacionTiemposHidratacion;
  int procesoHidratacionCantidadRamos;
  double procesoHidratacionPhSolucion;
  double procesoHidratacionNivelSolucion;
  String procesoHidratacionFecha;
  int usuarioId;
  int postcosechaId;

  factory RegistroHidratacion.fromJson(Map<String, dynamic> json) =>
      RegistroHidratacion(
        procesoHidratacionUsuarioControlId:
            json["procesoHidratacionUsuarioControlId"],
        procesoHidratacionEstadoSoluciones:
            json["procesoHidratacionEstadoSoluciones"],
        procesoHidratacionTiemposHidratacion:
            json["procesoHidratacionTiemposHidratacion"],
        procesoHidratacionCantidadRamos:
            json["procesoHidratacionCantidadRamos"],
        procesoHidratacionPhSolucion:
            json["procesoHidratacionPhSolucion"].toDouble(),
        procesoHidratacionNivelSolucion:
            json["procesoHidratacionNivelSolucion"].toDouble(),
        procesoHidratacionFecha: json["procesoHidratacionFecha"],
        usuarioId: json["usuarioId"],
        postcosechaId: json["postcosechaId"],
      );

  Map<String, dynamic> toJson() => {
        "procesoHidratacionUsuarioControlId":
            procesoHidratacionUsuarioControlId,
        "procesoHidratacionEstadoSoluciones":
            procesoHidratacionEstadoSoluciones,
        "procesoHidratacionTiemposHidratacion":
            procesoHidratacionTiemposHidratacion,
        "procesoHidratacionCantidadRamos": procesoHidratacionCantidadRamos,
        "procesoHidratacionPhSolucion": procesoHidratacionPhSolucion,
        "procesoHidratacionNivelSolucion": procesoHidratacionNivelSolucion,
        "procesoHidratacionFecha": procesoHidratacionFecha,
        "usuarioId": usuarioId,
        "postcosechaId": postcosechaId,
      };
}

class RegistroTemperatura {
  RegistroTemperatura(
      {this.temperaturaUsuarioControlId,
      this.temperaturaInterna1,
      this.temperaturaInterna2,
      this.temperaturaInterna3,
      this.temperaturaExterna,
      this.temperaturaFecha,
      this.usuarioId,
      this.postcosechaId});

  int temperaturaUsuarioControlId;
  double temperaturaInterna1;
  double temperaturaInterna2;
  double temperaturaInterna3;
  double temperaturaExterna;
  String temperaturaFecha;
  int usuarioId;
  int postcosechaId;

  factory RegistroTemperatura.fromJson(Map<String, dynamic> json) =>
      RegistroTemperatura(
          temperaturaUsuarioControlId: json["temperaturaUsuarioControlId"],
          temperaturaInterna1: json["temperaturaInterna1"].toDouble(),
          temperaturaInterna2: json["temperaturaInterna2"].toDouble(),
          temperaturaInterna3: json["temperaturaInterna3"].toDouble(),
          temperaturaExterna: json["temperaturaExterna"].toDouble(),
          temperaturaFecha: json["temperaturaFecha"],
          usuarioId: json["usuarioId"],
          postcosechaId: json["postcosechaId"]);

  Map<String, dynamic> toJson() => {
        "temperaturaUsuarioControlId": temperaturaUsuarioControlId,
        "temperaturaInterna1": temperaturaInterna1,
        "temperaturaInterna2": temperaturaInterna2,
        "temperaturaInterna3": temperaturaInterna3,
        "temperaturaExterna": temperaturaExterna,
        "temperaturaFecha": temperaturaFecha,
        "usuarioId": usuarioId,
        "postcosechaId": postcosechaId
      };
}
