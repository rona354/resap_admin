import 'package:dio/dio.dart';

class ServiceTenantMember {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<String> updateProfileWOP(
      tnuserid, tnfullname, tnemail, tnphone, isadmin, tokenid) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp =
          await dio.put(urlBase + "tenantsmember/updatewopass/1", data: {
        "tnuserid": tnuserid,
        "tnfullname": tnfullname,
        "tnemail": tnemail,
        "tnphone": tnphone,
        "tnstatus": 1,
        "isadmin": 0
      });
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      print("Statusnya ****************** ${tokenid}");
      if (200 == status) {
        print("Datanya ****************** ${data}");
        // var strShortVCode = data[0];
        return data.toString();
      } else {
        print("DATA Nya** ${data}");
        return "0";
      }
    } catch (e) {
      return "0";
    }
  }

  static Future<String> updateProfileWP(tnuserid, tnfullname, tnemail, tnphone,
      isadmin, newpassw, tokenid) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp =
          await dio.put(urlBase + "tenantsmember/updatewpass/1", data: {
        "tnuserid": tnuserid,
        "tnfullname": tnfullname,
        "tnemail": tnemail,
        "tnphone": tnphone,
        "tnstatus": 1,
        "isadmin": 0,
        "newpassw": newpassw
      });
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      print("Statusnya ****************** ${tokenid}");
      if (200 == status) {
        print("Datanya ****************** ${data}");
        // var strShortVCode = data[0];
        return data.toString();
      } else {
        print("DATA Nya** ${data}");
        return "0";
      }
    } catch (e) {
      return "0";
    }
  }
}
