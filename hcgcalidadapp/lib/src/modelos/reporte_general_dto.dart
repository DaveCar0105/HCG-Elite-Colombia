import 'dart:convert';

ReporteGeneralDto reporteGeneralFromJson(String str) =>
    ReporteGeneralDto.fromJson(json.decode(str));

String reporteGeneralToJson(ReporteGeneralDto data) =>
    json.encode(data.toJson());

class ReporteGeneralDto {
  ReporteGeneralDto(
      {this.postcosechaId,
        this.ramosRevisados,
      this.ramosNoConformes,
      this.porRamosNoConformes,
      this.falencias,
      this.totalFalencias,
      this.productos,
      this.clientes
      });

  int postcosechaId;
  int ramosRevisados;
  int ramosNoConformes;
  double porRamosNoConformes;
  int totalFalencias;
  List<FalenciaReporteGeneralDto> falencias;
  List<ClienteReporteGeneralDto> clientes;
  List<ProductoReporteGeneralDto> productos;
  List<VariedadReporteGeneralDto> variedades;
  List<NumeroMesaReporteGeneralDto> numerosMesa;
  List<LineaReporteGeneralDto> lineas;

  factory ReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      ReporteGeneralDto(
          ramosRevisados: json["ramosRevisados"],
          ramosNoConformes: json["ramosNoConformes"],
          porRamosNoConformes: json["porRamosNoConformes"].toDouble(),
          falencias: json["falencias"],
          totalFalencias: json["totalFalencias"],
          clientes: json["clientes"],
          productos: json["productos"],
          postcosechaId: json["postcosechaId"],
          );

  Map<String, dynamic> toJson() => {
        "ramosRevisados": ramosRevisados,
        "ramosNoConformes": ramosNoConformes,
        "porRamosNoConformes": porRamosNoConformes,
        "falencias": falencias,
        "totalFalencias": totalFalencias,
        "clientes": clientes,
        "productos": productos,
        "postcosechaId": postcosechaId
      };
}

FalenciaReporteGeneralDto falenciaReporteGeneralFromJson(String str) =>
    FalenciaReporteGeneralDto.fromJson(json.decode(str));

String falenciaReporteGeneralToJson(FalenciaReporteGeneralDto data) =>
    json.encode(data.toJson());

class FalenciaReporteGeneralDto {
  FalenciaReporteGeneralDto(
      {this.id, this.cantidad, this.nombreFalencia, this.porcentajeFalencia});

  int id;
  String nombreFalencia;
  int cantidad;
  double porcentajeFalencia;

  factory FalenciaReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      FalenciaReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreFalencia: json["nombreFalencia"],
          porcentajeFalencia: json["porcentajeFalencia"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreFalencia": nombreFalencia,
        "porcentajeFalencia": porcentajeFalencia
      };
}


ClienteReporteGeneralDto clienteReporteGeneralFromJson(String str) =>
    ClienteReporteGeneralDto.fromJson(json.decode(str));

String clienteReporteGeneralToJson(ClienteReporteGeneralDto data) =>
    json.encode(data.toJson());

class ClienteReporteGeneralDto {
  ClienteReporteGeneralDto(
      {this.id, this.cantidad, this.nombreCliente, this.porcentajeCliente, this.totalClientes});

  int id;
  String nombreCliente;
  int cantidad;
  double porcentajeCliente;
  int totalClientes;

  factory ClienteReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      ClienteReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreCliente: json["nombreCliente"],
          totalClientes: json["totalClientes"],
          porcentajeCliente: json["porcentajeCliente"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreCliente": nombreCliente,
        "totalClientes": totalClientes,
        "porcentajeCliente": porcentajeCliente
      };
}

ProductoReporteGeneralDto productoReporteGeneralFromJson(String str) =>
    ProductoReporteGeneralDto.fromJson(json.decode(str));

String productoReporteGeneralToJson(ProductoReporteGeneralDto data) =>
    json.encode(data.toJson());

class ProductoReporteGeneralDto {
  ProductoReporteGeneralDto(
      {this.id, this.cantidad, this.nombreProducto, this.porcentajeProducto, this.totalProductos});

  int id;
  String nombreProducto;
  int cantidad;
  double porcentajeProducto;
  int totalProductos;

  factory ProductoReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      ProductoReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreProducto: json["nombreProducto"],
          totalProductos: json["totalProductos"],
          porcentajeProducto: json["porcentajeProducto"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreProducto": nombreProducto,
        "porcentajeProducto": porcentajeProducto,
        "totalProductos": totalProductos
      };
}

// Variedad - Numero de mesa - Linea
VariedadReporteGeneralDto variedadReporteGeneralFromJson(String str) =>
    VariedadReporteGeneralDto.fromJson(json.decode(str));

String variedadReporteGeneralToJson(VariedadReporteGeneralDto data) =>
    json.encode(data.toJson());

class VariedadReporteGeneralDto {
  VariedadReporteGeneralDto(
      {this.id, this.cantidad, this.nombreVariedad, this.porcentajeVariedad});

  int id;
  String nombreVariedad;
  int cantidad;
  double porcentajeVariedad;

  factory VariedadReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      VariedadReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreVariedad: json["nombreVariedad"],
          porcentajeVariedad: json["porcentajeVariedad"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreVariedad": nombreVariedad,
        "porcentajeVariedad": porcentajeVariedad
      };
}

NumeroMesaReporteGeneralDto numeroMesaReporteGeneralFromJson(String str) =>
    NumeroMesaReporteGeneralDto.fromJson(json.decode(str));

String numeroMesaReporteGeneralToJson(NumeroMesaReporteGeneralDto data) =>
    json.encode(data.toJson());

class NumeroMesaReporteGeneralDto {
  NumeroMesaReporteGeneralDto(
      {this.id, this.cantidad, this.nombreNumeroMesa, this.porcentajeNumeroMesa});

  int id;
  String nombreNumeroMesa;
  int cantidad;
  double porcentajeNumeroMesa;

  factory NumeroMesaReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      NumeroMesaReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreNumeroMesa: json["nombreNumeroMesa"],
          porcentajeNumeroMesa: json["porcentajeNumeroMesa"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreNumeroMesa": nombreNumeroMesa,
        "porcentajeNumeroMesa": porcentajeNumeroMesa
      };
}

LineaReporteGeneralDto lineaReporteGeneralFromJson(String str) =>
    LineaReporteGeneralDto.fromJson(json.decode(str));

String lineaReporteGeneralToJson(LineaReporteGeneralDto data) =>
    json.encode(data.toJson());

class LineaReporteGeneralDto {
  LineaReporteGeneralDto(
      {this.id, this.cantidad, this.nombreLinea, this.porcentajeLinea});

  int id;
  String nombreLinea;
  int cantidad;
  double porcentajeLinea;

  factory LineaReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      LineaReporteGeneralDto(
          id: json["id"],
          cantidad: json["cantidad"],
          nombreLinea: json["nombreLinea"],
          porcentajeLinea: json["porcentajeLinea"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "nombreLinea": nombreLinea,
        "porcentajeLinea": porcentajeLinea
      };
}