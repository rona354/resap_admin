import 'dart:convert';

DashboardStatus dashboardStatusFromJson(String str) =>
    DashboardStatus.fromJson(json.decode(str));

String dashboardStatusToJson(DashboardStatus data) =>
    json.encode(data.toJson());

class DashboardStatus {
  DashboardStatus({
    this.id,
    this.tnuserid,
    this.tnfullname,
    this.tnphone,
    this.tnemail,
    this.tnstatus,
    this.tnfkid,
    this.tnname,
    this.grpfkid,
    this.groupname,
    this.isadmin,
    this.expired,
    this.token,
    this.iat,
    this.contractcode,
    this.locfkid,
  });

  String id;
  String tnuserid;
  String tnfullname;
  String tnphone;
  String tnemail;
  int tnstatus;
  String tnfkid;
  String tnname;
  String grpfkid;
  String groupname;
  int isadmin;
  DateTime expired;
  String token;
  int iat;
  String contractcode;
  String locfkid;

  factory DashboardStatus.fromJson(Map<String, dynamic> json) {
    return DashboardStatus(
      id: json["id"],
      tnuserid: json["tnuserid"],
      tnfullname: json["tnfullname"],
      tnphone: json["tnphone"],
      tnemail: json["tnemail"],
      tnstatus: json["tnstatus"],
      tnfkid: json["tnfkid"],
      tnname: json["tnname"],
      grpfkid: json["grpfkid"],
      groupname: json["groupname"],
      isadmin: json["isadmin"],
      expired: DateTime.parse(json["expired"]),
      token: json["token"],
      iat: json["iat"],
      contractcode: json["contractcode"],
      locfkid: json["locfkid"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "tnuserid": tnuserid,
        "tnfullname": tnfullname,
        "tnphone": tnphone,
        "tnemail": tnemail,
        "tnstatus": tnstatus,
        "tnfkid": tnfkid,
        "tnname": tnname,
        "grpfkid": grpfkid,
        "groupname": groupname,
        "isadmin": isadmin,
        "expired": expired.toIso8601String(),
        "token": token,
        "iat": iat,
        "contractcode": contractcode,
        "locfkid": locfkid,
      };
}
