import 'dart:convert';

ReporteGeneralDto reporteGeneralFromJson(String str) =>
    ReporteGeneralDto.fromJson(json.decode(str));

String reporteGeneralToJson(ReporteGeneralDto data) =>
    json.encode(data.toJson());

class ReporteGeneralDto {
  ReporteGeneralDto(
      {this.ramosRevisados,
      this.ramosNoConformes,
      this.porRamosNoConformes,
      this.falencias,
      this.totalFalencias,
      this.productos,
      this.clientes
      });

  int ramosRevisados;
  int ramosNoConformes;
  double porRamosNoConformes;
  List<FalenciaReporteGeneralDto> falencias;
  int totalFalencias;
  List<ClienteReporteGeneralDto> clientes;
  List<ProductoReporteGeneralDto> productos;

  factory ReporteGeneralDto.fromJson(Map<String, dynamic> json) =>
      ReporteGeneralDto(
          ramosRevisados: json["ramosRevisados"],
          ramosNoConformes: json["ramosNoConformes"],
          porRamosNoConformes: json["porRamosNoConformes"].toDouble(),
          falencias: json["falencias"],
          totalFalencias: json["totalFalencias"],
          clientes: json["clientes"],
          productos: json["productos"],
          
          );

  Map<String, dynamic> toJson() => {
        "ramosRevisados": ramosRevisados,
        "ramosNoConformes": ramosNoConformes,
        "porRamosNoConformes": porRamosNoConformes,
        "falencias": falencias,
        "totalFalencias": totalFalencias,
        "clientes": clientes,
        "productos": productos
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
