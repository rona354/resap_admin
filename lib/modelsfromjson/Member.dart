import 'dart:convert';

Member memberFromJson(String str) => Member.fromJson(json.decode(str));

String memberToJson(Member data) => json.encode(data.toJson());

class Member {
  Member({
    this.id,
    this.tnuserid,
    this.tnfullname,
    this.tnsecret,
    this.tnemail,
    this.tnphone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.tnstatus,
    this.tnfkid,
    this.grpfkid,
    this.isadmin,
  });

  String id;
  String tnuserid;
  String tnfullname;
  String tnsecret;
  String tnemail;
  String tnphone;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  int tnstatus;
  String tnfkid;
  String grpfkid;
  int isadmin;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        tnuserid: json["tnuserid"],
        tnfullname: json["tnfullname"],
        tnsecret: json["tnsecret"],
        tnemail: json["tnemail"],
        tnphone: json["tnphone"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        tnstatus: json["tnstatus"],
        tnfkid: json["tnfkid"],
        grpfkid: json["grpfkid"],
        isadmin: json["isadmin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tnuserid": tnuserid,
        "tnfullname": tnfullname,
        "tnsecret": tnsecret,
        "tnemail": tnemail,
        "tnphone": tnphone,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "tnstatus": tnstatus,
        "tnfkid": tnfkid,
        "grpfkid": grpfkid,
        "isadmin": isadmin,
      };
}
