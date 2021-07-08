import 'dart:convert';

ProcesoHidratacion procesoHidratacionFromJson(String str) => ProcesoHidratacion.fromJson(json.decode(str));

String procesoHidratacionToJson(ProcesoHidratacion data) => json.encode(data.toJson());

class ProcesoHidratacion {
    ProcesoHidratacion({
        this.procesoHidratacionId,
        this.procesoHidratacionUsuarioControlId,
        this.procesoHidratacionEstadoSoluciones,
        this.procesoHidratacionTiemposHidratacion,
        this.procesoHidratacionCantidadRamos,
        this.procesoHidratacionPhSolucion,
        this.procesoHidratacionNivelSolucion,
        this.procesoHidratacionFecha,
        this.postcosechaId
    });

    int procesoHidratacionId;
    int procesoHidratacionUsuarioControlId;
    int procesoHidratacionEstadoSoluciones;
    int procesoHidratacionTiemposHidratacion;
    int procesoHidratacionCantidadRamos;
    double procesoHidratacionPhSolucion;
    double procesoHidratacionNivelSolucion;
    DateTime procesoHidratacionFecha;
    int postcosechaId;

    factory ProcesoHidratacion.fromJson(Map<String, dynamic> json) => ProcesoHidratacion(
        procesoHidratacionId: json["procesoHidratacionId"],
        postcosechaId: json["postcosechaId"],
        procesoHidratacionUsuarioControlId: json["procesoHidratacionUsuarioControlId"],
        procesoHidratacionEstadoSoluciones: json["procesoHidratacionEstadoSoluciones"],
        procesoHidratacionTiemposHidratacion: json["procesoHidratacionTiemposHidratacion"],
        procesoHidratacionCantidadRamos: json["procesoHidratacionCantidadRamos"],
        procesoHidratacionPhSolucion: json["procesoHidratacionPhSolucion"].toDouble(),
        procesoHidratacionNivelSolucion: json["procesoHidratacionNivelSolucion"].toDouble(),
        procesoHidratacionFecha: DateTime.parse(json["procesoHidratacionFecha"]),
    );

    Map<String, dynamic> toJson() => {
        "procesoHidratacionId": procesoHidratacionId,
        "procesoHidratacionUsuarioControlId": procesoHidratacionUsuarioControlId,
        "procesoHidratacionEstadoSoluciones": procesoHidratacionEstadoSoluciones,
        "procesoHidratacionTiemposHidratacion": procesoHidratacionTiemposHidratacion,
        "procesoHidratacionCantidadRamos": procesoHidratacionCantidadRamos,
        "procesoHidratacionPhSolucion": procesoHidratacionPhSolucion,
        "postcosechaId": postcosechaId,
        "procesoHidratacionNivelSolucion": procesoHidratacionNivelSolucion,
        "procesoHidratacionFecha": procesoHidratacionFecha.toIso8601String(),
    };
}