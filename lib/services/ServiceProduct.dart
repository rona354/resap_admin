import 'package:dio/dio.dart';
import 'package:resap_admin/modelsfromjson/Product.dart';

class ServiceProduct {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<List<Product>> getProductbyTenant(tokenid) async {
    try {
      // print("Token di cek Stores ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "stockproduct");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya ***** Product ******** ${data}");
        return (data as List).map((x) => Product.fromJson(x)).toList();
      } else {
        print("DATA Nya** ${data}");
        return List<Product>();
      }
    } catch (e) {
      print("error ${e}");
      return List<Product>();
    }
  }
}
