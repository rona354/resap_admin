import 'dart:convert';

CurrentLocation currentLocationFromJson(String str) =>
    CurrentLocation.fromJson(json.decode(str));

String currentLocationToJson(CurrentLocation data) =>
    json.encode(data.toJson());

class CurrentLocation {
  CurrentLocation({
    this.id,
    this.trxDate,
    this.mactionid,
    this.checkin,
    this.checkout,
    this.locname,
    this.fulladdress,
    this.latitude,
    this.longitude,
  });

  String id;
  DateTime trxDate;
  String mactionid;
  DateTime checkin;
  dynamic checkout;
  String locname;
  String fulladdress;
  double latitude;
  double longitude;

  factory CurrentLocation.fromJson(Map<String, dynamic> json) =>
      CurrentLocation(
        id: json["id"],
        trxDate: DateTime.parse(json["trx_date"]),
        mactionid: json["mactionid"],
        checkin: DateTime.parse(json["checkin"]),
        checkout: json["checkout"],
        locname: json["locname"],
        fulladdress: json["fulladdress"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trx_date": trxDate.toIso8601String(),
        "mactionid": mactionid,
        "checkin": checkin.toIso8601String(),
        "checkout": checkout,
        "locname": locname,
        "fulladdress": fulladdress,
        "latitude": latitude,
        "longitude": longitude,
      };
}
