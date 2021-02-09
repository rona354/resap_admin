import 'dart:math';

import 'package:dio/dio.dart';
import 'package:resap_admin/modelsfromjson/groupcode.dart';

class ServiceRegistration {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<List<Groupcode>> getGroupcode(code) async {
    try {
      var codeStr = code;
      final resp =
          await Dio().get(urlBase + "tenantsgroup/retrivegroup/${codeStr}");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        return (data as List).map((x) => Groupcode.fromJson(x)).toList();
      } else {
        print("DATA Nya** ${data}");
        return List<Groupcode>();
      }
    } catch (e) {
      return List<Groupcode>();
    }
  }

  // { "tnuserid":"usertn5", "tnfullname":"User TN 5","tnsecret":"manage","tnemail":"usr05@kmselaras.com","tnphone":"0898889988","tnstatus":1,"grpfkid":4,"isadmin":0, "tnfkid": 1}
//   {
//     "status": 200,
//     "data": [
//         {
//             "id": "2",
//             "idmember": "5",
//             "tokenid": 210051,
//             "created_at": "2021-01-18T15:30:48.133Z",
//             "updated_at": null
//         }
//     ]
// }
  static Future<String> saveProfile(tnuserid, tnfullname, tnsecret, tnemail,
      tnphone, tnstatus, grpfkid, tnfkid) async {
    try {
      final resp = await Dio().post(urlBase + "tenantsmember", data: {
        "tnuserid": tnuserid,
        "tnfullname": tnfullname,
        "tnsecret": tnsecret,
        "tnemail": tnemail,
        "tnphone": tnphone,
        "tnstatus": 0,
        "grpfkid": 4,
        "isadmin": 0,
        "tnfkid": tnfkid
      });
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya ****************** ${data[0]}");
        var strShortVCode = data[0];
        return strShortVCode['id'];
      } else {
        print("DATA Nya** ${data}");
        return "0";
      }
    } catch (e) {
      return "0";
    }
  }

  static Future<String> verifyProfile(tokenid) async {
    try {
      final resp = await Dio()
          .post(urlBase + "auth/verifyauth", data: {"tokenid": tokenid});
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya ****************** ${data}");
        var strShortVCode = data;
        return strShortVCode['token'];
      } else {
        print("DATA Nya** ${data}");
        return "0";
      }
    } catch (e) {
      return "0";
    }
  }
}
