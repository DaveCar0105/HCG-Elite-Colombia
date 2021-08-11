import 'dart:convert';

CalculoMuestra calculoMuestraFromJson(String str) =>
    CalculoMuestra.fromJson(json.decode(str));

String calculoMuestraToJson(CalculoMuestra data) => json.encode(data.toJson());

class CalculoMuestra {
  CalculoMuestra({this.RamosTotales, this.NivelDeConfianza, this.MargenDeError}){
    listaNivelConfianza = new List<NivelConfianza>();
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 50,valor: 0.67));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 80,valor: 1.28));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 90,valor: 1.65));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 95,valor: 1.96));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 96,valor: 2.05));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 97,valor: 2.17));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 98,valor: 2.33));
    listaNivelConfianza.add(new NivelConfianza(nivelConfianza: 99,valor: 2.58));
  }

  int RamosTotales;
  double NivelDeConfianza;
  double MargenDeError;
  List<NivelConfianza> listaNivelConfianza;

  factory CalculoMuestra.fromJson(Map<String, dynamic> json) => CalculoMuestra(
      RamosTotales: json["RamosTotales"],
      NivelDeConfianza: json["NivelDeConfianza"],
      MargenDeError: json["MargenDeError"]);

  Map<String, dynamic> toJson() => {
        "RamosTotales": RamosTotales,
        "NivelDeConfianza": NivelDeConfianza,
        "MargenDeError": MargenDeError
      };


  String calcularMuestra(){
    double resultado = 0;
    double z = 0;
    double n = 0;
    double p = 0.5;
    double q = 0.5;
    double totalPQ = p * q;
    double e = 0;
    try{
      n = this.RamosTotales.toDouble();
      e = this.MargenDeError / 100;
      for(NivelConfianza nivelConfianza in listaNivelConfianza){
        if(nivelConfianza.nivelConfianza>=this.NivelDeConfianza){
          z = nivelConfianza.valor;
          break;
        }
      }
      double numerador = n * z * z * totalPQ;
      double denominadorPrimero = z * z * totalPQ;
      double denominadorSegundo = e * e * ( n - 1);
      double denominador = denominadorPrimero + denominadorSegundo;
      resultado =  numerador / denominador;
    } catch(e){}
    return resultado.toStringAsFixed(0);
  }
}


class NivelConfianza {
  NivelConfianza({this.nivelConfianza, this.valor});

  int nivelConfianza;
  double valor;

  factory NivelConfianza .fromJson(Map<String, dynamic> json) => NivelConfianza (
    nivelConfianza: json["nivelConfianza"],
    valor: json["valor"]
  );

  Map<String, dynamic> toJson() => {
    "nivelConfianza": nivelConfianza,
    "valor": valor
  };
}
