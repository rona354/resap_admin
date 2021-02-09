import 'package:dio/dio.dart';
import 'package:resap_admin/modelsfromjson/CurrentLocation.dart';
import 'package:resap_admin/modelsfromjson/DashboardStatus.dart';

class DashboardService {
  static const String urlBase = 'https://resap.kmselaras.com/apiresap/v1/';
  static Future<DashboardStatus> dashboardStatus(tokenid) async {
    try {
      // print("Token di service DB ************* ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "workingprocess/dashboardstatus");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya ****************** ${data}");
        return DashboardStatus.fromJson(data);
      } else {
        print("DATA Nya** ${data}");
        return DashboardStatus();
      }
    } catch (e) {
      print("error ${e}");
      return DashboardStatus();
    }
  }

  static Future<CurrentLocation> checkedInCurrentLocation(
      storeid, contract, tokenid) async {
    try {
      // print(
      //     "Token di service checkedInCurrentLocation ************* ${tokenid}");
      // print(urlBase +
      //     "workingprocess/dashboardischeckin/" +
      //     storeid.toString() +
      //     "/" +
      //     contract);
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase +
          "workingprocess/dashboardischeckin/" +
          storeid.toString() +
          "/" +
          contract);
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya ****************** ${data}");
        return CurrentLocation.fromJson(data);
      } else {
        print("DATA Nya** ${data}");
        return CurrentLocation();
      }
    } catch (e) {
      print("error ${e}");
      return CurrentLocation();
    }
  }

  static Future<String> reveralContract(tokenid) async {
    try {
      // print("Token di service ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "workingprocess/contract");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        // print("Datanya ****************** ${data}");
        // return DashboardStatus.fromJson(data);
        return data['contract'];
      } else {
        print("DATA Nya** ${data}");
        return "No Contract";
      }
    } catch (e) {
      print("error ${e}");
      return "No Contract";
    }
  }

  static Future<String> amountNode(tokenid) async {
    try {
      // print("Token di service ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp = await dio.get(urlBase + "locations/countstores");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya ****************** ${data}");
        // return DashboardStatus.fromJson(data);
        return data['amount'];
      } else {
        print("DATA Nya** ${data}");
        return "0";
      }
    } catch (e) {
      print("error ${e}");
      return "0";
    }
  }

  static Future<String> amountProduct(tokenid) async {
    try {
      // print("Token di service ****************** ${tokenid}");
      Dio dio = new Dio();
      dio.options.headers["authorization"] = "token ${tokenid}";
      final resp =
          await dio.get(urlBase + "stockproduct/countproduct/bytenant");
      var jsonData = resp.data;
      var status = jsonData['status'];
      var data = jsonData['data'];
      // print("Statusnya ****************** ${status}");
      if (200 == status) {
        print("Datanya ****************** ${data}");
        // return DashboardStatus.fromJson(data);
        return data['amount'];
      } else {
        print("DATA Nya** ${data}");
        return "0";
      }
    } catch (e) {
      print("error ${e}");
      return "0";
    }
  }
}
//       {
//     "status": 200,
//     "data": {
//         "id": "18",
//         "tnuserid": "ryanmuktiadhi",
//         "tnfullname": "Ryan Muktiadhi",
//         "tnphone": "085694463308",
//         "tnemail": "muktiadhiryan@gmail.com",
//         "tnstatus": 1,
//         "tnfkid": "1",
//         "tnname": "PT Kusumatama Mitra Selaras",
//         "grpfkid": "4",
//         "groupname": "Marchendiser 2",
//         "isadmin": 0,
//         "expired": "2021-01-20T16:33:23.861Z",
//         "token": "2021004001018",
//         "iat": 1611074003,
//         "contractcode": null,
//         "locfkid": null
//     }
// }
