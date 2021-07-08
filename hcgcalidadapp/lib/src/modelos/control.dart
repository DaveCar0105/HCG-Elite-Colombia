// To parse this JSON data, do
//
//     final control = controlFromJson(jsonString);

import 'dart:convert';

Control controlFromJson(String str) => Control.fromJson(json.decode(str));

String controlToJson(Control data) => json.encode(data.toJson());

class Control {
  Control({
    this.id,
  });

  int id;

  factory Control.fromJson(Map<String, dynamic> json) => Control(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
