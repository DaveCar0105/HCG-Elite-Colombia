import 'dart:convert';

PostCosecha postCosechaFromJson(String str) => PostCosecha.fromJson(json.decode(str));

String postCosechaToJson(PostCosecha data) => json.encode(data.toJson());

class PostCosecha {
  PostCosecha({
    this.postCosechaId,
    this.postCosechaNombre,
    this.elite
  });

  int postCosechaId;
  String postCosechaNombre;
  int elite;

  factory PostCosecha.fromJson(Map<String, dynamic> json) => PostCosecha(
    postCosechaId: json["postCosechaId"],
    postCosechaNombre: json["postCosechaNombre"],
    elite: json["elite"],
  );

  Map<String, dynamic> toJson() => {
    "postCosechaId": postCosechaId,
    "postCosechaNombre": postCosechaNombre,
    "elite":elite
  };
}
