import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static final Preferences _instancia = new Preferences._internal();
  Preferences._internal();
  SharedPreferences _prefs;

  factory Preferences(){
    return _instancia;
  }

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get userId{
    return _prefs.getInt('userId3')??0;
  }

  set userId(int value){
    _prefs.setInt('userId3', value);
  }

  get sinc{
    return _prefs.getBool('sincros3')??false;
  }
  set sinc(bool value){
    _prefs.setBool('sincros3', value);
  }

  get fechaIns{
    return _prefs.getString('fechaInst3')??'';
  }
  
  set fechaIns(String value){
    _prefs.setString('fechaInst3', value);
  }
}