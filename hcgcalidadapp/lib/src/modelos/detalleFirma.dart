import 'dart:convert';

DetalleFirma detalleFirmaFromJson(String str) => DetalleFirma.fromJson(json.decode(str));

String detalleFirmaToJson(DetalleFirma data) => json.encode(data.toJson());

class DetalleFirma {
    DetalleFirma({
        this.detalleFirmaId,
        this.detalleFirmaCodigo,
        this.firmaId,
    });

    int detalleFirmaId;
    String detalleFirmaCodigo;
    int firmaId;

    factory DetalleFirma.fromJson(Map<String, dynamic> json) => DetalleFirma(
        detalleFirmaId: json["detalleFirmaId"],
        detalleFirmaCodigo: json["detalleFirmaCodigo"],
        firmaId: json["firmaID"],
    );

    Map<String, dynamic> toJson() => {
        "detalleFirmaId": detalleFirmaId,
        "detalleFirmaCodigo": detalleFirmaCodigo,
        "firmaID": firmaId,
    };
}
