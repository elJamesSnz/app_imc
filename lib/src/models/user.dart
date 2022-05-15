import 'dart:convert';

import 'package:app_delivery_flutter/src/models/medida.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String password;
  String sessionToken;
  String image;
  List<Medida> medidas = [];

  User({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.sessionToken,
    this.image,
    this.medidas
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    //Validación para ver si el id es entero. Si es entero, se hace un toString
    id: json["id"] is int ? json['id'].toString() : json["id"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    sessionToken: json["session_token"],
    image: json["image"],
    //Validación para ver si la lista de roles es nula. Si no lo es, se debe mapear a una lista de tipo Rol.
    medidas: json["medidas"] == null ? [] : List<Medida>.from(json['medidas'].map((model) => Medida.fromJson(model))) ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "session_token": sessionToken,
    "image": image,
    "medidas": medidas,
  };
}
