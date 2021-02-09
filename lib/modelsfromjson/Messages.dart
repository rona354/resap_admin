import 'dart:convert';

List<Messages> messagesFromJson(String str) =>
    List<Messages>.from(json.decode(str).map((x) => Messages.fromJson(x)));

String messagesToJson(List<Messages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messages {
  Messages({
    this.iduser,
    this.title,
    this.body,
    this.typecode,
    this.status,
    this.idtowhom,
    this.datemessage,
  });

  String iduser;
  String title;
  String body;
  String typecode;
  int status;
  String idtowhom;
  DateTime datemessage;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        iduser: json["iduser"],
        title: json["title"],
        body: json["body"],
        typecode: json["typecode"],
        status: json["status"],
        idtowhom: json["idtowhom"],
        datemessage: DateTime.parse(json["datemessage"]),
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser,
        "title": title,
        "body": body,
        "typecode": typecode,
        "status": status,
        "idtowhom": idtowhom,
        "datemessage": datemessage.toIso8601String(),
      };
}
