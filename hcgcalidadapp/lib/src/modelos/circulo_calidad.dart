import 'dart:convert';

circuloCalidad ramosFromJson(String str) =>
    circuloCalidad.fromJson(json.decode(str));

String ramosToJson(circuloCalidad data) => json.encode(data.toJson());

class circuloCalidad {
  circuloCalidad({
    this.circuloCalidadId,
    //this.ramosNumeroOrden,
    this.ramosRevisados,
    this.ramosRechazados,
    this.calidadReunion,
    this.problemaId1,
    this.problemaId2,
    this.problemaId3,
    this.problemaId4,
    this.problemaId5,
    this.clienteId1,
    this.clienteId2,
    this.productoId1,
    this.productoId2,
    this.variedad1,
    this.variedad2,
    this.postcosechaId,
    this.codigoMesa,
    this.linea,
    this.supervisor1,
    this.supervisor2,
    this.supervisorcheck1,
    this.supervisorcheck2,
    this.comentarios,
  });

  int circuloCalidadId = 0;
  String ramosNumeroOrden;
  int ramosRevisados;
  String ramosRechazados;
  int calidadReunion;
  int problemaId1;
  int problemaId2;
  int problemaId3;
  int problemaId4;
  int problemaId5;
  int clienteId1;
  int clienteId2;
  String productoId1;
  int productoId2;
  int variedad1;
  int postcosechaId;
  String variedad2;
  int codigoMesa;
  int linea;
  String supervisor1;
  String supervisor2;
  String supervisorcheck1;
  String supervisorcheck2;
  String comentarios;

  factory circuloCalidad.fromJson(Map<String, dynamic> json) => circuloCalidad(
      circuloCalidadId: json["controlRamosId"],
      // ramosNumeroOrden: json["ramosNumeroOrden"],
      ramosRevisados: json["ramosRevisados"],
      ramosRechazados: json["ramosRechazados"],
      calidadReunion: json["calidadReunion"],
      problemaId1: json["problemaId1"],
      problemaId2: json["problemaId2"],
      problemaId3: json["problamId3"],
      problemaId4: json["problemaId4"],
      problemaId5: json["problemaId5"],
      clienteId1: json["clienteId1"],
      clienteId2: json["clienteId2"],
      productoId1: json["productoId1"],
      productoId2: json["productoId2"],
      variedad1: json["variedad1"],
      postcosechaId: json["postcosechaId"],
      variedad2: json["variedad2"],
      codigoMesa: json["codigoMesa"],
      linea: json["linea"],
      supervisor1: json["supervisor1"],
      supervisor2: json["supervisor2"],
      supervisorcheck1: json["supervisorcheck1"],
      supervisorcheck2: json["supervisorcheck2"],
      comentarios: json["comentarios"]);
  Map<String, dynamic> toJson() => {
        "circuloCalidadId": circuloCalidadId,
        //"ramosNumeroOrden": ramosNumeroOrden,
        "ramosRevisados": ramosRevisados,
        "ramosRechazados": ramosRechazados,
        "calidadReunion": calidadReunion,
        "problemaId1": problemaId1,
        "problemaId2": problemaId2,
        "problemaId3": problemaId3,
        "problemaId4": problemaId4,
        "problemaId5": problemaId5,
        "clienteId1": clienteId1,
        "clienteId2": clienteId2,
        "productoId1": productoId1,
        "productoId2": productoId2,
        "variedad1": variedad1,
        "postcosechaId": postcosechaId,
        "variedad2": variedad2,
        "codigoMesa": codigoMesa,
        "linea": linea,
        "supervisor1": supervisor1,
        "supervisor2": supervisor2,
        "supervisorcheck1": supervisorcheck1,
        "supervisorcheck2": supervisorcheck2,
        "comentarios": comentarios
      };
}
