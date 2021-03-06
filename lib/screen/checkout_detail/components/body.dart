import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/modelsfromjson/CurrentLocation.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';
import 'package:resap_admin/services/ServiceLocations.dart';
import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final String contract;
  final CurrentLocation storeItem;

  const Body({Key key, @required this.storeItem, @required this.contract})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CurrentLocation nodeobject;
  File _file;

  bool isRetriveSuccess;
  String storeid;
  String currenttime, fileselfie, buttonSendSelfie = "Submit Selfie";
  bool _isSelfie = false;
  bool _isSelfieSubmit = true;
  bool _isCheckingIn = true;
  bool _isError = false;
  bool _isSuccess = false;
  String tokenPreference;
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
    getPreferences().then((value) {
      tokenPreference = value;
      // print("token : ${tokenPreference}");
    });
    var now = new DateTime.now();
    currenttime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    nodeobject = widget.storeItem;
    this.storeid = nodeobject.id;
    // this.storename = nodeobject.nodename;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Checkout From"),
            content: Container(
              height: 60,
              child: Column(
                children: [
                  Text(
                    this.nodeobject.locname,
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  ),
                  Text(
                    "$currenttime",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Confirm"),
                onPressed: () {
                  Navigator.of(context).pop();
                  EasyLoading.show();
                  ServiceLocation.checkedOut(
                          nodeobject.id, tokenPreference, widget.contract)
                      .then((value) {
                    var _result = value;
                    print(
                        "############## Hasil save update : ${_result.toString()} ");
                    setState(() {
                      _isCheckingIn = false;
                      _isSelfie = true;
                      _isSuccess = true;
                    });
                  });
                  EasyLoading.dismiss();
                },
              )
            ],
          );
        },
      );
    }

    void _sendingSelfie() {
      // setState(() {});
      EasyLoading.show();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          print(">>>> Sending Checkout");
          buttonSendSelfie = "Selfie submited";
          _isSelfieSubmit = false;
          _isCheckingIn = false;
          _isSelfie = false;
          _isSuccess = true;
          // _isLoading = false;
          EasyLoading.dismiss();
        });
      });
    }

    _save() async {
      GallerySaver.saveImage(_file.path, albumName: "ResapFotos")
          .then((dynamic value) {
        var valueTmp = value.toString();
        // print("Saved to gallery $valueTmp");
      });
      // print(result);
    }

    Future captuteImageWCamera() async {
      final imageFile = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);
      if (imageFile == null) return;

      // Step 3: Get directory where we can duplicate selected file.
      // Directory tempDir = await getTemporaryDirectory();
      // String tempPath = tempDir.path;
      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // String appDocPath = appDocDir.path;

      final String hasilfoto = imageFile.absolute.path;
      // print(">>>>> temp base :  $tempPath\n");
      // print(">>>>> app base :  $appDocPath\n");
      // print("\n>>>>> Hasil Foto :  $hasilfoto\n");
      setState(() {
        // file = imageFile as Future<File>;
        _file = imageFile;
        _save();
      });
    }

    return FlutterEasyLoading(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(15)),
                width: double.infinity,
                // height: 90,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.nodeobject.locname,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(this.nodeobject.fulladdress,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.contract,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent)),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    disabledColor: Colors.grey,
                    onPressed: _isCheckingIn ? () => _showDialog() : null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10)),
                    color: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 60,
                        ),
                        Text("Check Out"),
                        Text(currenttime)
                      ],
                    ),
                  ),
                  FlatButton(
                    disabledColor: Colors.grey,
                    onPressed: _isSelfie ? () => captuteImageWCamera() : null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10)),
                    color: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.camera, size: 60),
                        Text("Selfie"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Visibility(
              visible: _isSuccess,
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(15)),
                  width: double.infinity,
                  // height: 90,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Success check out",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
            Visibility(
              visible: _isError,
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(15)),
                  width: double.infinity,
                  // height: 90,
                  decoration: BoxDecoration(
                      color: Colors.redAccent[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Check in Failure",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
            _file == null
                ? Image.asset('assets/images/displayimage.png',
                    height: getProportionateScreenHeight(265),
                    width: getProportionateScreenWidth(235))
                : Image.file(_file,
                    height: getProportionateScreenHeight(265),
                    width: getProportionateScreenWidth(235)),
            FlatButton(
              disabledColor: Colors.grey,
              onPressed: _isSelfieSubmit ? () => _sendingSelfie() : null,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(7)),
              color: Colors.orange,
              child: Text(
                buttonSendSelfie,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    // print("Splash get preverence : $token");

    return token;
  }
}
