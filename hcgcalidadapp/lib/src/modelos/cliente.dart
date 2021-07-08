
import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    this.clienteId,
    this.clienteNombre,
    this.elite
  });

  int clienteId;
  String clienteNombre;
  int elite;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    clienteId: json["clienteId"],
    clienteNombre: json["clienteNombre"],
    elite: json["elite"],
  );

  Map<String, dynamic> toJson() => {
    "clienteId": clienteId,
    "clienteNombre": clienteNombre,
    "elite": elite,
  };
}
