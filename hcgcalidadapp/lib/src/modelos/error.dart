import 'dart:convert';

ErrorT errorFromJson(String str) => ErrorT.fromJson(json.decode(str));

String errorToJson(ErrorT data) => json.encode(data.toJson());

class ErrorT {
  ErrorT({
    this.errorId,
    this.errorDetalle,
  });

  int errorId;
  String errorDetalle;

  factory ErrorT.fromJson(Map<String, dynamic> json) => ErrorT(
    errorId: json["errorId"],
    errorDetalle: json["errorDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "errorId": errorId,
    "errorDetalle": errorDetalle,
  };
}
