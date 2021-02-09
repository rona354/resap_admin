import 'dart:convert';

List<Groupcode> groupcodeFromJson(String str) =>
    List<Groupcode>.from(json.decode(str).map((x) => Groupcode.fromJson(x)));

String groupcodeToJson(List<Groupcode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Groupcode {
  Groupcode({
    this.id,
    this.groupname,
    this.tnfkid,
    this.tnname,
    this.createdAt,
  });

  String id;
  String groupname;
  String tnfkid;
  String tnname;
  DateTime createdAt;

  factory Groupcode.fromJson(Map<String, dynamic> json) => Groupcode(
        id: json["id"],
        groupname: json["groupname"],
        tnfkid: json["tnfkid"],
        tnname: json["tnname"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupname": groupname,
        "tnfkid": tnfkid,
        "tnname": tnname,
        "created_at": createdAt.toIso8601String(),
      };
}
