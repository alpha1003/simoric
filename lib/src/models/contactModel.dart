
import 'dart:convert';

ContactModel contactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
    ContactModel({
        this.id,
        this.uid,
        this.name,
        this.lastName,
        this.phoneNumber,
        this.email,

    });

    String id;
    String uid;
    String name;
    String lastName; 
    int    phoneNumber;
    String email;

    factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id          : json["id"],
        uid         : json["uid"],
        name        : json["name"],
        lastName    : json["lastName"],
        phoneNumber : json["phoneNumber"],
        email       : json["email"],
    ); 

    factory ContactModel.fromDynamic(Map<dynamic,dynamic> map) => ContactModel(
        id          : map["id"],
        uid         : map["uid"],
        name        : map["name"],
        lastName    : map["lastName"],
        phoneNumber : map["phoneNumber"],
        email       : map["email"],
    );

    Map<String, dynamic> toJson() => {
        "id"           : id,
        "uid"          : uid,
        "name"         : name,
        "lastName"     : lastName,
        "phoneNumber"  : phoneNumber,
        "email"        : email
    };
}
