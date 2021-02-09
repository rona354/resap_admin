import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/modelsfromjson/Product.dart';
import 'package:resap_admin/screen/stockopname/components/liststocks.dart';
import 'package:resap_admin/services/ServiceProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String contract;

  const Body({Key key, @required this.contract}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> products = [];
  String tokenshared;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EasyLoading.instance
      ..contentPadding = EdgeInsets.all(5)
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.green
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..backgroundColor = kPrimaryColor
      ..radius = 100.0
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false;
    print("<<<< init stockopname state >>>> ${widget.contract}");
    getPreferences().then(updateuserprofile);
    EasyLoading.show();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Expanded(
              child:
                  ListStocks(listProducts: products, contract: widget.contract))
        ],
      ),
    );
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokeninfo = prefs.getString("token");
    // print("Get Userpreference $tokeninfo");
    return tokeninfo;
  }

  void updateuserprofile(String tokeninfo) {
    this.tokenshared = tokeninfo;
    EasyLoading.show();
    ServiceProduct.getProductbyTenant(tokenshared).then((value) {
      // var lProd = value;
      setState(() {
        products = value;
      });
      EasyLoading.dismiss();
      // print("object    ${products.toString()}");
    });
  }
}
