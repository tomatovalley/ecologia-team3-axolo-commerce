class ScanModel {
  ScanModel(
      {this.uuid, this.fecha, this.producto, this.descripcion, this.imagen}) {}

  String uuid;
  String fecha;
  String producto;
  String descripcion;
  String imagen;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        uuid: json["uuid"],
        fecha: json["fecha"],
        producto: json["producto"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "fecha": fecha,
        "producto": producto,
        "descripcion": descripcion,
        "imagen": imagen
      };
}
