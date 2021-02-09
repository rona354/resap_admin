import 'package:dio/dio.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';

class ServiceLocation {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<List<Stores>> getStoresbyCoordinate(
      latitude, longitude, tokenid) async {
    try {
      // print("Token di cek Stores ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp =
          await dio.get(urlBase + "locations/" + latitude + "/" + longitude);
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya ****************** ${data}");

        return (data as List).map((x) => Stores.fromJson(x)).toList();
      } else {
        print("DATA Nya** ${data}");
        return List<Stores>();
      }
    } catch (e) {
      print("error ${e}");
      return List<Stores>();
    }
  }

  static Future<String> checkedIn(idstore, tokenid, contract) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      // print("Path ****************** ${urlBase}workingprocess/checkedin");
      // print(
      //     "Data ****************** { mactionid: 5, refno : ${contract}, idstore : ${idstore} }");
      final resp = await dio.post(urlBase + "workingprocess/checkedin",
          data: {"mactionid": 5, "refno": contract, "idstore": idstore});
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      print("Statusnya ****************** ${status}");
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

  static Future<String> checkedOut(idstore, tokenid, contract) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";

      final resp = await dio.post(urlBase + "workingprocess/checkedout",
          data: {"mactionid": 6, "refno": contract, "idstore": idstore});
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya after upate ****************** ${data}");
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

  static Future<String> tagging(
      storename, fulladdress, latitude, longitude, tokenid) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";

      final resp = await dio.post(urlBase + "locations/tagging", data: {
        "locname": storename,
        "fulladdress": fulladdress,
        "longitude": longitude,
        "latitude": latitude,
        "requested": 1
      });
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya after upate ****************** ${data}");
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
