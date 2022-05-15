import 'dart:convert';

Medida rolFromJson(String str) => Medida.fromJson(json.decode(str));

String rolToJson(Medida data) => json.encode(data.toJson());

//modelo que mapea la tabla rol de la base de datos
class Medida {
  Medida({
    this.id,
    this.altura,
    this.peso,
    this.imc,
  });

  String id;
  String altura;
  String peso;
  String imc;

  factory Medida.fromJson(Map<String, dynamic> json) => Medida(
    id: json["id"] is int ? json['id'].toString() : json["id"],
    altura: json["name"],
    peso: json["image"],
    imc: json["route"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": altura,
    "image": peso,
    "route": imc,
  };
}
