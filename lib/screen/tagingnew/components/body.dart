import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/components/default_custom_button.dart';
import 'package:resap_admin/screen/components/form_error.dart';
import 'package:resap_admin/services/ServiceLocations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final String contract;

  const Body({Key key, this.contract}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  String tokenShared = "", storename = "", fulladdress = "";
  double longitude = 0.0, latitude = 0.0;
  bool isLocated = false;
  final List<String> errors = [];
  void initState() {
    _controller = new TextEditingController();
    this.longitude = 0.0;
    this.latitude = 0.0;
    this.fulladdress = "Unknown";
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
    super.initState();
    getPreferences().then(updateuserprofile);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(15)),
                  width: double.infinity,
                  // height: 90,
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Current Location :",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text("User",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("$latitude [lat]",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38)),
                          Text("$longitude [log]",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38))
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: getProportionateScreenWidth(10)),
              Text(
                "Address : ",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(fulladdress),
              SizedBox(height: getProportionateScreenWidth(20)),
              buildFullNameFormField(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Visibility(
                visible: isLocated,
                child: DefaultCustomButton(
                  text: "Submit Location",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // print("################ Submit Lokasi ${fulladdress}");
                      // print("################ Store name ${storename}");
                      // print("################ latiude ${latitude}");
                      // print("################ latiude ${longitude}");

                      ServiceLocation.tagging(storename, fulladdress, latitude,
                              longitude, tokenShared)
                          .then((value) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Success tagging"),
                                content: Text(
                                  "Location saved to server, Please change location and search for new location",
                                  style: TextStyle(color: Colors.green[700]),
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          _controller.clear();
                                          // storename = null;
                                          fulladdress = 'Unknown';
                                          isLocated = false;
                                          longitude = 0.0;
                                          latitude = 0.0;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            });
                      });
                    }
                  },
                  bgcolor: Colors.green,
                ),
              ),
              FormError(errors: errors),
              Visibility(
                visible: !isLocated,
                child: DefaultButton(
                  text: "Check Location",
                  press: () {
                    EasyLoading.show();
                    // print("################ Cek Lokasi");
                    _determinePosition().then((value) {
                      Position _position = value;

                      print("Location ===================");
                      // print("==== Latitude : " + _position.latitude.toString());
                      // print(
                      //     "==== Longitude : " + _position.longitude.toString());

                      setState(() {
                        isLocated = true;
                        longitude = _position.longitude;
                        latitude = _position.latitude;
                        EasyLoading.dismiss();
                      });
                    });
                    // EasyLoading.dismiss();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    print("Get Userpreference $token");
    return token;
  }

  void updateuserprofile(String token) {
    setState(() {
      this.tokenShared = token;
    });
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: _controller,
      autofocus: false,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => storename = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNamelocNullError)) {
          setState(() {
            errors.remove(kNamelocNullError);
          });
        } else if (errors.contains(kNamelocNullError)) {
          setState(() {
            errors.remove(kNamelocNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kNamelocNullError)) {
          setState(() {
            errors.add(kNamelocNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Location Name *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter location name",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Location point.svg",
          )),
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
    Position posisi = await Geolocator.getCurrentPosition();
    final coordinates = new Coordinates(posisi.latitude, posisi.longitude);
    debugPrint('coordinates is: $coordinates');
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    if (first.addressLine != null) {
      setState(() {
        fulladdress = first.addressLine;
      });
    }

    return posisi;
  }
}
