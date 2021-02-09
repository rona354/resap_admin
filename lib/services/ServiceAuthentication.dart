import 'package:dio/dio.dart';
import 'package:resap_admin/modelsfromjson/Member.dart';

class ServiceAuthentication {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<String> authByEmail(email, password) async {
    try {
      // print("Token di service ****************** ${tokenid}");

      final resp = await Dio().post(urlBase + "auth/getauthemail",
          data: {"credential": email, "secret": password});
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya ****************** ${data}");
        return data['token'];
      } else {
        print("DATA Nya** ${data}");
        return null;
      }
    } catch (e) {
      print("error ${e}");
      return e.toString();
    }
  }

  static Future<String> authByPreference(tokenid) async {
    try {
      // print("Token di service authByPreference ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.post(urlBase + "auth/getauthbytoken");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya authByPreference****************** ${data}");

        return data['token'];
      } else {
        print("DATA Nya** ${data}");
        return data;
      }
    } catch (e) {
      print("error ${e}");
      return e.toString();
    }
  }

  static Future<Member> getProfileByToken(tokenid) async {
    try {
      // print("Token di service authByPreference ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "tenantsmember/bytoken/1");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya authByPreference****************** ${data}");
        return Member.fromJson(data);
      } else {
        print("DATA Nya** ${data}");
        return Member();
      }
    } catch (e) {
      print("error ${e}");
      return new Member();
    }
  }

  static Future<Member> getAdminByToken(tokenid) async {
    try {
      // print("Token di service authByPreference ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "tenantsmember/getadminbytoken/1");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya getAdminByToken****************** ${data}");
        return Member.fromJson(data);
      } else {
        print("DATA Nya** ${data}");
        return Member();
      }
    } catch (e) {
      print("error ${e}");
      return new Member();
    }
  }
}
