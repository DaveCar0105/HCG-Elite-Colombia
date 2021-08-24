import 'dart:convert';
import 'package:hcgcalidadapp/src/basedatos/database_error.dart';
import 'package:hcgcalidadapp/src/constantes.dart';
import 'package:hcgcalidadapp/src/modelos/circulo_calidad.dart';
import 'package:hcgcalidadapp/src/modelos/control.dart';
import 'package:hcgcalidadapp/src/modelos/error.dart';
import 'package:hcgcalidadapp/src/modelos/proceso_maritimo.dart';
import 'package:hcgcalidadapp/src/modelos/reporte_sincronizacion.dart';
import 'package:http/http.dart' as http;

class SincServices{
  static Future<List<Control>> postReportesEmpaque(ReporteSincronizacionEmpaque reporte) async{
    final co = Constantes();
    List<Control> lista = [];
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/empaque');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      var listaRetorno = jsonDecode(respuesta.body);
      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        for(int i=0;i<listaRetorno.length;i++){
          lista.add(
              Control.fromJson(listaRetorno[i])
          );
        }
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
      }
      return lista;
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Empaque: '+ex.toString();
      await DatabaseError.addError(errorT);
      return lista;
    }
  }
  static Future<List<Control>> postReporteBanda(var reporte) async{
    final co = Constantes();
    List<Control> lista = [];
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/banda');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      var listaRetorno = jsonDecode(respuesta.body);
      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        for(int i=0;i<listaRetorno.length;i++){
          lista.add(
              Control.fromJson(listaRetorno[i])
          );
        }
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
      }
      return lista;
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Banda: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return lista;
    }
  }
  static Future<bool> postReporteEcuador(var reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/ecuador');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);

      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        return true;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return false;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Ecuador: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return false;
    }
  }
  static Future<bool> postReporteAlistamiento(var reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/alistamiento');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);

      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        return true;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return false;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Banda: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return false;
    }
  }
  static Future<bool> postReporteBoncheo(var reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/boncheo');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);

      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        return true;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return false;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Banda: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return false;
    }
  }
  static Future<bool> postReporteEcommerce(var reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/ecommerce');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);

      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        return true;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return false;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Banda: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return false;
    }
  }
  static Future<List<Control>> postReportesRamo(ReporteSincronizacionRamo reporte) async{
    final co = Constantes();
    List<Control> lista = [];
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/ramos');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      var listaRetorno = jsonDecode(respuesta.body);
      if(respuesta.statusCode>=200 && respuesta.statusCode<=299){
        for(int i=0;i<listaRetorno.length;i++){
          lista.add(
              Control.fromJson(listaRetorno[i])
          );
        }
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
      }
      return lista;
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Ramos: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return lista;
    }
  }

  static Future<int> postCirculoCalidad(List<CirculoCalidadInformacionGeneral> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/circuloCalidad');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Circulo-Calidad: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }

  static Future<int> postProcesoMaritimo(List<ProcesoMaritimo> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/procesoMaritimo');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Proceso-Maritimo: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }

  static Future<int> postActividad(List<Actividade> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/actividad');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }

    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Actividad: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }

  static Future<int> postTemperatura(List<RegistroTemperatura> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/temperatura');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }

    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Temperatura: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }
  static Future<int> postHidratacion(List<RegistroHidratacion> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/hidratacion');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Hidratacion: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }

  static Future<int> postAllProcesoMaritimo(List<ProcesoMaritimo> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/ProcesoMaritimo');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'Proceso Maritimo: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }

  static Future<int> postProcesoEmpaque(List<ProcesoEmpaque> reporte) async{
    final co = Constantes();
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Sincro/pempaque');
      var respuesta = await http.post(url,body: jsonEncode(reporte),headers: header);
      if(respuesta.statusCode>=200 && respuesta.statusCode <=299){
        return respuesta.statusCode;
      }else{
        ErrorT errorT = new ErrorT();
        errorT.errorDetalle = (respuesta.statusCode.toString() + ' - ' + respuesta.body.toString());
        await DatabaseError.addError(errorT);
        return respuesta.statusCode;
      }
    }catch(ex){
      ErrorT errorT = new ErrorT();
      errorT.errorDetalle = 'P.Empaque: ' + ex.toString();
      await DatabaseError.addError(errorT);
      return 0;
    }
  }



}