import 'package:dio/dio.dart';
import 'package:resap_admin/modelsfromjson/Messages.dart';

class ServiceMessaging {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<List<Messages>> getMessageClientbyToken(tokenid) async {
    try {
      // print("Token di cek Stores ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "messaging");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya ***** Messages ******** ${data}");
        return (data as List).map((x) => Messages.fromJson(x)).toList();
      } else {
        print("DATA Nya** ${data}");
        return List<Messages>();
      }
    } catch (e) {
      print("error ${e}");
      return List<Messages>();
    }
  }

  static Future<List<Messages>> sendTextMessageClientbyToken(
      tokenid, message, towhomid) async {
    try {
      // print("Token di cek Stores ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.post(urlBase + "messaging/fromclienttext", data: {
        "body": message,
        "typecode": "TEXT",
        "status": 1,
        "idtowhom": towhomid
      });
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya ***** Messages ******** ${data}");
        return (data as List).map((x) => Messages.fromJson(x)).toList();
      } else {
        print("DATA Nya** ${data}");
        return List<Messages>();
      }
    } catch (e) {
      print("error ${e}");
      return List<Messages>();
    }
  }
}
