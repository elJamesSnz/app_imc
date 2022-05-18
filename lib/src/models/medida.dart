import 'dart:convert';

Medida rolFromJson(String str) => Medida.fromJson(json.decode(str));

String rolToJson(Medida data) => json.encode(data.toJson());

//modelo que mapea la tabla rol de la base de datos
class Medida {
  Medida({
    this.id_user,
    this.id_imc,
    this.name,
    this.route,
    this.imc_value
  });

  int id_user;
  int id_imc;
  String name;
  String route;
  String imc_value;

  factory Medida.fromJson(Map<String, dynamic> json) => Medida(
    //id_user: json["id_user"] is int ? json['id_user'].toString() : json["id_user"],
    //id_imc: json["id_imc"] is int ? json['id_imc'].toString() : json["id_imc"],
    id_user: json["id_user"],
    id_imc: json["id_imc"],
    name: json["name"],
    route: json["route"],
    imc_value: json["imc_value"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": id_user,
    "id_imc": id_imc,
    "name": name,
    "route": route,
    "imc_value": imc_value,
  };
}
