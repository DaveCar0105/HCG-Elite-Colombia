class AutoComplete{
  int id;
  String nombre;

  AutoComplete({this.id, this.nombre});
  AutoComplete.fromJson(Map<String,dynamic> json) {
    this.id = json['id'];
    this.nombre = json['nombre'];
  }
}