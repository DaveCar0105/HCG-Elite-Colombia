import 'dart:convert';

ProcesoEmpaques procesoEmpaqueFromJson(String str) => ProcesoEmpaques.fromJson(json.decode(str));

String procesoEmpaqueToJson(ProcesoEmpaques data) => json.encode(data.toJson());

class ProcesoEmpaques {
    ProcesoEmpaques({
        this.procesoEmpaqueId,
        this.procesoEmpaqueUsuarioControlId,
        this.procesoEmpaqueAltura,
        this.procesoEmpaqueCajas,
        this.procesoEmpaqueSujeccion,
        this.procesoEmpaqueMovimientos,
        this.procesoEmpaqueTemperaturaCuartoFrio,
        this.procesoEmpaqueTemperaturaCajas,
        this.procesoEmpaqueTemperaturaCamion,
        this.procesoEmpaqueApilamiento,
        this.procesoEmpaqueFecha,
        this.postcosechaId
    });

    int procesoEmpaqueId;
    int procesoEmpaqueUsuarioControlId;
    int procesoEmpaqueAltura;
    int procesoEmpaqueCajas;
    int procesoEmpaqueSujeccion;
    int procesoEmpaqueMovimientos;
    int procesoEmpaqueTemperaturaCuartoFrio;
    int procesoEmpaqueTemperaturaCajas;
    int procesoEmpaqueTemperaturaCamion;
    int procesoEmpaqueApilamiento;
    DateTime procesoEmpaqueFecha;
    int postcosechaId;

    factory ProcesoEmpaques.fromJson(Map<String, dynamic> json) => ProcesoEmpaques(
        procesoEmpaqueId: json["procesoEmpaqueId"],
        procesoEmpaqueUsuarioControlId: json["procesoEmpaqueUsuarioControlId"],
        procesoEmpaqueAltura: json["procesoEmpaqueAltura"],
        procesoEmpaqueCajas: json["procesoEmpaqueCajas"],
        procesoEmpaqueSujeccion: json["procesoEmpaqueSujeccion"],
        procesoEmpaqueMovimientos: json["procesoEmpaqueMovimientos"],
        procesoEmpaqueTemperaturaCuartoFrio: json["procesoEmpaqueTemperaturaCuartoFrio"],
        procesoEmpaqueTemperaturaCajas: json["procesoEmpaqueTemperaturaCajas"],
        procesoEmpaqueTemperaturaCamion: json["procesoEmpaqueTemperaturaCamion"],
        procesoEmpaqueApilamiento: json["procesoEmpaqueApilamiento"],
        postcosechaId: json["postcosechaId"],
        procesoEmpaqueFecha: DateTime.parse(json["temperaturaFecha"]),
    );

    Map<String, dynamic> toJson() => {
        "procesoEmpaqueId": procesoEmpaqueId,
        "procesoEmpaqueUsuarioControlId": procesoEmpaqueUsuarioControlId,
        "procesoEmpaqueAltura": procesoEmpaqueAltura,
        "procesoEmpaqueCajas": procesoEmpaqueCajas,
        "postcosechaId": postcosechaId,
        "procesoEmpaqueSujeccion": procesoEmpaqueSujeccion,
        "procesoEmpaqueMovimientos": procesoEmpaqueMovimientos,
        "procesoEmpaqueTemperaturaCuartoFrio": procesoEmpaqueTemperaturaCuartoFrio,
        "procesoEmpaqueTemperaturaCajas": procesoEmpaqueTemperaturaCajas,
        "procesoEmpaqueTemperaturaCamion": procesoEmpaqueTemperaturaCamion,
        "procesoEmpaqueApilamiento": procesoEmpaqueApilamiento,
        "temperaturaFecha": procesoEmpaqueFecha.toIso8601String(),
    };
}