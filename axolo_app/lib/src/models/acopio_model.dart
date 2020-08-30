import 'dart:convert';

List<AcopioModel> acopioModelFromJson(String str) => List<AcopioModel>.from(
    json.decode(str).map((x) => AcopioModel.fromJson(x)));

String acopioModelToJson(List<AcopioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AcopioModel {
  AcopioModel({
    this.id,
    this.cateogory,
    this.name,
    this.phone,
    this.picture,
    this.lat,
    this.lng,
  });

  int id;
  String cateogory;
  String name;
  String phone;
  String picture;
  double lat;
  double lng;

  factory AcopioModel.fromJson(Map<String, dynamic> json) => AcopioModel(
        id: json["id"],
        cateogory: json["cateogory"],
        name: json["name"],
        phone: json["phone"],
        picture: json["picture"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cateogory": cateogory,
        "name": name,
        "phone": phone,
        "picture": picture,
        "lat": lat,
        "lng": lng,
      };
}
