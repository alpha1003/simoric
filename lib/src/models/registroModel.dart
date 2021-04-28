import 'dart:convert';

RegistroModel registroModelFromJson(String str) =>
    RegistroModel.fromJson(json.decode(str));

String contactModelToJson(RegistroModel data) => json.encode(data.toJson());

class RegistroModel {
  RegistroModel({this.fecha, this.alerta, this.bpm, this.id});

  String fecha;
  String alerta;
  int bpm;
  String id;

  factory RegistroModel.fromJson(Map<String, dynamic> json) => RegistroModel(
        fecha: json["fecha"],
        id: json["id"],
        alerta: json["alerta"],
        bpm: json["bpm"],
      );

  factory RegistroModel.fromDynamic(Map<dynamic, dynamic> map) => RegistroModel(
        fecha: map["fecha"],
        id: map["id"],
        alerta: map["alerta"],
        bpm: map["bpm"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "fecha": fecha, "alerta": alerta, "bpm": bpm};
}
