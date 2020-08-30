class ScanModel {
  ScanModel({this.uuid, this.producto, this.descripcion, this.imagen}) {}

  String uuid;
  String producto;
  String descripcion;
  String imagen;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        uuid: json["uuid"],
        producto: json["name"],
        descripcion: json["details"],
        imagen: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid.toString(),
        "producto": producto.toString(),
        "descripcion": descripcion.toString(),
        "imagen": imagen.toString()
      };
}
