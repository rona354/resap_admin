import 'dart:convert';

List<Stores> storesFromJson(String str) =>
    List<Stores>.from(json.decode(str).map((x) => Stores.fromJson(x)));

String storesToJson(List<Stores> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stores {
  Stores({
    this.id,
    this.locname,
    this.fulladdress,
    this.distance,
    this.absolutepath,
    this.idobjbytyp,
  });

  String id;
  String locname;
  String fulladdress;
  double distance;
  String absolutepath;
  String idobjbytyp;

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        id: json["id"],
        locname: json["locname"],
        fulladdress: json["fulladdress"],
        distance: json["distance"].toDouble(),
        absolutepath: json["absolutepath"],
        idobjbytyp: json["idobjbytyp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "locname": locname,
        "fulladdress": fulladdress,
        "distance": distance,
        "absolutepath": absolutepath,
        "idobjbytyp": idobjbytyp,
      };
}
