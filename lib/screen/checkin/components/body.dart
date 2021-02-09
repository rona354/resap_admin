import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/models/nodestore.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';
import 'package:resap_admin/screen/checkin/components/liststores.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/dashboard/dashboard.dart';
import 'package:resap_admin/services/ServiceLocations.dart';
import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  final String contract;
  const Body({Key key, this.contract}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(child: SearchForm(contract: this.contract));
  }
}

class SearchForm extends StatefulWidget {
  final String contract;

  const SearchForm({Key key, this.contract}) : super(key: key);
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  // List<NodeStore> nodes;
  List<Stores> _lStores = [];
  String tokenshared;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("####################### ${widget.contract}");
    getPreferences().then(updateuserprofile);
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
    print(">>>>>>>>>>>> Initial Check In Page");
    EasyLoading.show();
    _determinePosition().then((value) {
      Position _position = value;
      // print("Location ===================");
      // print("==== Latitude : " + _position.latitude.toString());
      // print("==== Longitude : " + _position.longitude.toString());
      ServiceLocation.getStoresbyCoordinate(_position.latitude.toString(),
              _position.longitude.toString(), tokenshared)
          .then((value) {
        List<Stores> lStores = value;

        print("################# Banyak data ${lStores.length}");

        if (lStores.length > 0) {
          setState(() {
            _lStores = lStores;
          });
        } else {
          setState(() {
            _lStores = [];
          });
        }
        EasyLoading.dismiss();
      });
    });
    // setState(() {
    //   nodes = liststores;
    // });
  }

  String searchString;
  final List<String> errors = [];
  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print(">>>>>>>>>>>>>>>>>>>> BACK PRESS DETECTED");
        Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10)),
            child: buildVerifyCodeFormField(),
          ),
          // new Expanded(child: ListStores(contract: widget.contract, nodes: nodes))
          new Expanded(
              child: ListStores(
            contract: widget.contract,
            listStores: _lStores,
          ))
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void updateuserprofile(String tokeninfo) {
    EasyLoading.show();
    setState(() {
      this.tokenshared = tokeninfo;
    });

    EasyLoading.dismiss();
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokeninfo = prefs.getString("token");
    // print("Get Userpreference $tokeninfo");
    return tokeninfo;
  }

  TextFormField buildVerifyCodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => searchString = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kVerifyCodeError)) {
          setState(() {
            errors.remove(kVerifyCodeError);
          });
        } else if (errors.contains(kVerifyCodeError)) {
          setState(() {
            errors.remove(kVerifyCodeError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kVerifyCodeError)) {
          setState(() {
            errors.add(kVerifyCodeError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Search your Checkpoint",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Search Icon.svg",
          )),
    );
  }
}
