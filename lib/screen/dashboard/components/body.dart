import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/menuitem.dart';
import 'package:resap_admin/models/information.dart';
import 'package:resap_admin/modelsfromjson/CurrentLocation.dart';
import 'package:resap_admin/modelsfromjson/DashboardStatus.dart';
import 'package:resap_admin/screen/activity/activity_screen.dart';
import 'package:resap_admin/screen/checkout_detail/checkout_detail_screen.dart';
import 'package:resap_admin/screen/components/information_card.dart';
import 'package:resap_admin/screen/dashboard/components/section_title.dart';
import 'package:resap_admin/screen/stockopname/stock_opname_screen.dart';
import 'package:resap_admin/services/DashboardService.dart';
import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'home_header.dart';

GlobalKey<_AllControllState> globalKey = GlobalKey();

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: SafeArea(
        top: true,
        child: AllControll(key: globalKey),
      ),
    );
  }
}

class AllControll extends StatefulWidget {
  AllControll({Key key}) : super(key: key);
  @override
  _AllControllState createState() => _AllControllState();
}

class _AllControllState extends State<AllControll> {
  // String tokenShare = "";
  static final josKeys1 = GlobalKey();
  static final josKeys2 = GlobalKey();
  bool isRetriveSuccess;
  List<MenuItem> menuAttend;
  List<Information> lInformation;
  int jumlahChat = 0;
  String greeting,
      userfullname,
      contract,
      nodesamount = "0",
      productsamount = "0",
      currentworkname = "default",
      currentcode = "default",
      tokenshared;
  bool iscurrentcheckin = false;
  DashboardStatus _userinfo;
  CurrentLocation _currentLocation;
  @override
  void initState() {
    super.initState();
    initialScreen();

    getPreferences().then(updateuserprofile);
    if (!iscurrentcheckin) {
      setState(() {
        menuAttend = [
          MenuItem("Activity", Icons.map_outlined, 1),
          MenuItem("Attendance Report", Icons.library_books_outlined, 2)
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: getProportionateScreenWidth(7),
            ),
            // * HOME HEADER
            HomeHeader(context, jumlahChat),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            // * CARD
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(15)),
                width: double.infinity,
                // height: 90,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(greeting,
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Text(userfullname,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: <Widget>[
                        Text(this.contract,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[100])),
                        Visibility(
                          visible: !isRetriveSuccess,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              EasyLoading.show();

                              DashboardService.reveralContract(tokenshared)
                                  .then((value) {
                                var contractnum = value;
                                this.changeStateContract(contractnum);
                              });

                              EasyLoading.dismiss();
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            color: kTextColor,
                            child: Container(
                              padding: EdgeInsets.all(1.0),
                              child: const Text('Reveral',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Row(
                  children: <Widget>[
                    MenuBtnFull(
                      title: "Productivity",
                      key: josKeys1,
                      amount: nodesamount,
                      press: () {},
                      unit: "Nodes",
                      type: 1,
                      lmenuitem: menuAttend,
                      contract: this.contract,
                      finalFunction: onCekManing,
                      store: _currentLocation,
                      optionalExt:
                          this.contract == "No Contract" ? true : false,
                    ),
                    MenuBtnFull(
                      title: "Stockist",
                      key: josKeys2,
                      amount: productsamount,
                      press: () {},
                      unit: "Unit",
                      type: 3,
                      lmenuitem: menuitems3,
                      contract: this.contract,
                      finalFunction: onCekManing,
                      store: _currentLocation,
                      optionalExt: !iscurrentcheckin,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            CardWorkLocation(
              codeWork: currentcode,
              namaWork: currentworkname,
              available: iscurrentcheckin,
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            SectionWidget(
              text: "Information",
              textmore: "More",
              press: () {},
            ),
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  ...List.generate(
                      lInformation.length,
                      (index) => InformationCard(
                            aspecRetion: 1.81,
                            width: 320,
                            infoObject: lInformation[index],
                          )),
                  SizedBox(
                    width: getProportionateScreenWidth(20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initialScreen() {
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
    print("<<<< init dashboard state >>>>");
    lInformation = [
      Information(
          bgimage: "mobilefriendly.jpg",
          title: " Mobile Friendly",
          description: ""),
      Information(
          bgimage: "uptodate.jpg", title: " Realtime Report ", description: ""),
      Information(
          bgimage: "supportfriendly.jpg",
          title: " 24/7 Support ",
          description: ""),
    ];

    isRetriveSuccess = false;
    greeting = "default";
    userfullname = "unknown";
    contract = "No Contract";
    // _isLoading = false;
    var now = new DateTime.now();
    var jam = now.hour;
    // print("<<<<$jam");
    if (jam >= 1 && jam <= 13) {
      print("<<<< Pagi ");
      print("Selamat Pagi");
      greeting = "Selamat Pagi,";
    } else if (jam > 13 && jam <= 15) {
      print("<<<< Siang ");
      greeting = "Selamat Siang,";
    } else if (jam >= 15 && jam <= 18) {
      print("<<<< Sore ");
      greeting = "Selamat Sore,";
    } else if (jam > 18 && jam <= 24) {
      print("<<<< Malam ");
      greeting = "Selamat Malam,";
    } else {
      greeting = "Selamat Pagi,";
    }
  }

  Future<bool> saveContractPreference(String contract) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("contract", contract);
    return prefs.commit();
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokeninfo = prefs.getString("token");
    // print("Get Userpreference $tokeninfo");
    return tokeninfo;
  }

  void changeStateContract(contractnum) {
    setState(() {
      isRetriveSuccess = true;
      contract = contractnum;
    });
    int locationid = int.parse(_userinfo.locfkid);
    if (locationid > 0) {
      DashboardService.checkedInCurrentLocation(
              locationid, contract, tokenshared)
          .then((value) {
        setState(() {
          _currentLocation = value;
        });
        print(" location : ${_currentLocation.locname}");
        print(" Address : ${_currentLocation.fulladdress}");
        print(" locid : ${_currentLocation.id}");
        if (_currentLocation.locname != null) {
          setState(() {
            if (_currentLocation.mactionid == "5") {
              setState(() {
                iscurrentcheckin = true;
                currentworkname = _currentLocation.locname;
                currentcode = _currentLocation.id.padLeft(4, "0");
                menuAttend = [
                  MenuItem("Check Out", Icons.access_time, 4),
                  MenuItem("Leave Request", Icons.not_accessible, 2)
                ];
              });
            } else if (_currentLocation.mactionid == "6") {
              setState(() {
                iscurrentcheckin = false;
                currentworkname = "Undefined";
                currentcode = "Code #";
                menuAttend = [
                  MenuItem("Check In", Icons.access_time, 1),
                  MenuItem("Leave Request", Icons.not_accessible, 2)
                ];
              });
            }
          });
        }
      });
    }
    EasyLoading.dismiss();
  }

  compareCurrentDate(String dateincoming) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyyMMdd');
    String formatted = formatter.format(now);
    return formatted == dateincoming ? true : false;
  }

  void updateuserprofile(String tokeninfo) {
    this.tokenshared = tokeninfo;
    // EasyLoading.show();

    DashboardService.dashboardStatus(tokeninfo).then((value) {
      _userinfo = value;
      print(" full : ${_userinfo.tnfullname}");
      print(" contract : ${_userinfo.contractcode}");
      print(" locid : ${_userinfo.locfkid}");
      if (_userinfo.contractcode != null) if (this
          .compareCurrentDate(_userinfo.contractcode.substring(0, 8))) {
        this.changeStateContract(_userinfo.contractcode);
      }
      setState(() {
        this.userfullname = _userinfo.tnfullname;
      });
    });

    DashboardService.amountNode(tokeninfo).then((value) {
      setState(() {
        nodesamount = value;
      });

      print(" banyak toko : ${nodesamount}");
    });
    DashboardService.amountProduct(tokeninfo).then((value) {
      setState(() {
        productsamount = value;
      });
      EasyLoading.dismiss();
      print(" banyak produk tenant : ${productsamount}");
    });
  }

  void onCekManing() {
    EasyLoading.dismiss();

    print("Balik cek maning $tokenshared");
    // initialScreen();
    updateuserprofile(tokenshared);
    // getCurrentWork();
    // getPreferences().then(updateuserprofile);
    // if (!iscurrentcheckin) {
    //   setState(() {
    //     menuAttend = [
    //       MenuItem("Check In", Icons.access_time, 1),
    //       MenuItem("Leave Request", Icons.not_accessible, 2)
    //     ];
    //   });
    // }
  }
}

class CardWorkLocation extends StatefulWidget {
  final String namaWork, codeWork;
  final bool available;
  const CardWorkLocation(
      {Key key, this.namaWork, this.codeWork, this.available})
      : super(key: key);

  @override
  _CardWorkLocationState createState() => _CardWorkLocationState();
}

class _CardWorkLocationState extends State<CardWorkLocation> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.available,
      child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(15)),
          width: double.infinity,
          // height: 90,
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Current Work Location",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              Text(widget.namaWork,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text("Code #${widget.codeWork}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45)),
            ],
          )),
    );
  }
}

class MenuBtnFull extends StatefulWidget {
  const MenuBtnFull({
    Key key,
    @required this.title,
    @required this.amount,
    @required this.unit,
    @required this.press,
    @required this.type,
    @required this.contract,
    this.lmenuitem,
    this.finalFunction,
    this.store,
    @required this.optionalExt,
  }) : super(key: key);
  final String title, amount, unit, contract;
  final int type;
  final GestureTapCallback press;
  final List<MenuItem> lmenuitem;
  final FutureOr finalFunction;
  final CurrentLocation store;
  final bool optionalExt;
  @override
  _MenuBtnFullState createState() => _MenuBtnFullState();
}

class _MenuBtnFullState extends State<MenuBtnFull> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: SizedBox(
          width: getProportionateScreenWidth(148),
          height: getProportionateScreenWidth(90),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1))
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: widget.optionalExt
                            ? null
                            : PopupMenuButton<int>(
                                onSelected: (value) {
                                  print(">>>>>> $value");
                                  switch (value) {
                                    case 1:
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ActivityScreen(
                                            contract: widget.contract,
                                          ),
                                        ),
                                      ).then(onGoBack);
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                elevation: 3.2,
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black26,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return widget.lmenuitem
                                      .map((MenuItem menuitem) {
                                    return PopupMenuItem(
                                      value: menuitem.realVal,
                                      child: ListTile(
                                        leading: Icon(
                                          menuitem.iconVal,
                                          size: 18,
                                          color: Colors.black38,
                                        ),
                                        title: Text(
                                          menuitem.menuVal,
                                          style:
                                              TextStyle(color: Colors.black26),
                                        ),
                                      ),
                                    );
                                  }).toList();
                                }),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          widget.amount,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(" ")),
                      Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(widget.unit)),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  FutureOr onGoBack(dynamic value) {
    print("Balik aning");
    globalKey.currentState.onCekManing();
  }
}
