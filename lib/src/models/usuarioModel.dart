// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  UsuarioModel({
    this.name,
    this.lastname,
    this.rol,
    this.age,
    this.phoneNumber,
    this.medUid,
    this.email,
  });

  String name;
  String lastname;
  String rol;
  String medUid;
  int age;
  int phoneNumber;
  String email;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        name: json["name"],
        lastname: json["lastname"],
        medUid: json["medUid"],
        rol: json["rol"],
        age: json["age"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "medUid": medUid,
        "lastname": lastname,
        "rol": rol,
        "age": age,
        "phoneNumber": phoneNumber,
        "email": email,
      };
}
