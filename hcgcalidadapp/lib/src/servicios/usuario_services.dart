import 'dart:convert';
import 'package:hcgcalidadapp/src/constantes.dart';
import 'package:hcgcalidadapp/src/preferencias.dart';
import 'package:http/http.dart' as http;

class LoginServices{

  final co = Constantes();
  final pref = new Preferences();

  Future<int> postLogin(String user,String password) async{
    Map<String, String> header = {'Accept': "application/json",'content-type': "application/json"};
    try{
      var url = Uri.http(co.url, '/api/Usuarios/$user/$password');
      final respuesta = await http.get(url,headers: header);
      var jsonResponse = json.decode(respuesta.body);
      return int.parse(jsonResponse.toString());
    }catch(ex){
      return 0;
    }
  }
}