import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.code,
    this.prodname,
    this.description,
    this.barcode,
    this.idfktenant,
    this.createdAt,
    this.updatedAt,
    this.absolutepath,
  });

  String id;
  String code;
  String prodname;
  String description;
  String barcode;
  String idfktenant;
  DateTime createdAt;
  dynamic updatedAt;
  String absolutepath;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        code: json["code"],
        prodname: json["prodname"],
        description: json["description"],
        barcode: json["barcode"],
        idfktenant: json["idfktenant"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        absolutepath: json["absolutepath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "prodname": prodname,
        "description": description,
        "barcode": barcode,
        "idfktenant": idfktenant,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "absolutepath": absolutepath,
      };
}
