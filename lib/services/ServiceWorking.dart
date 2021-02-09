import 'package:dio/dio.dart';

class ServiceWorking {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<String> stockopnameIn(
      fixedamt, realamt, balanceamt, locfkid, tokenid, contract) async {
    try {
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.post(urlBase + "workingprocess/soinsert", data: {
        "mactionid": 14,
        "fixedamt": fixedamt,
        "realamt": realamt,
        "balanceamt": balanceamt,
        "locfkid": locfkid,
        "contractcode": contract
      });
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
}
