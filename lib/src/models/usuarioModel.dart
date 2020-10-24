// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        this.id,
        this.name,
        this.lastname,
        this.age,
        this.phoneNumber,
        this.email,
    });

    String id;
    String name;
    String lastname;
    int age;
    int phoneNumber; 
    String email;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id          : json["id"],
        name      : json["name"],
        lastname    : json["lastname"],
        age        : json["age"],
        phoneNumber : json["phoneNumber"],
        email       : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id"          : id,
        "name"      : name,
        "lastname"    : lastname,
        "age"        : age,
        "phoneNumber" : phoneNumber,
        "email"       : email,
    };
}
