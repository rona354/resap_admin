import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/screen/dashboard/components/body.dart';
import 'package:resap_admin/screen/history/history_screen.dart';
import 'package:resap_admin/screen/messaging/messaging_screen.dart';
import 'package:resap_admin/screen/profile/profile_user_screen.dart';
import 'package:resap_admin/screen/tagingnew/tagging_location_screen.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "/dashboard";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _userName = "undefined";
  @override
  void initState() {
    // getPreferences().then(updateuserprofile);
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to exit'),
          actions: [
            FlatButton(
              child: Text('Yes'),
              onPressed: () => {
                Future.delayed(const Duration(milliseconds: 1000), () {
                  exit(0);
                })
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: Scaffold(
        body: Body(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(9.0, 0.0, 9.0, 25.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Container(
              color: Colors.black54.withOpacity(0.10),
              child: TabBar(
                onTap: (index) {
                  print(">>> Index Bar $index");
                  switch (index) {
                    case 0:
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  TaggingLocationScreen())).then(onGoBack);
                      break;
                    case 2:
                      // Navigator.pushNamed(context, MessagingScreen.routeName);
                      Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => MessagingScreen()))
                          .then(onGoBack);
                      break;
                    case 3:
                      // Navigator.pushNamed(context, HistoryScreen.routeName);
                      Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => HistoryScreen()))
                          .then(onGoBack);
                      break;
                    case 4:
                      // Navigator.pushNamed(context, ProfileUserScreen.routeName);
                      Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ProfileUserScreen()))
                          .then(onGoBack);
                      break;
                    default:
                  }
                },
                labelStyle: TextStyle(fontSize: 8.0),
                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                labelColor: kPrimaryColor,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.home,
                      size: 24.0,
                    ),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.location_on,
                      size: 24.0,
                    ),
                    text: 'Location',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.chat,
                      size: 24.0,
                    ),
                    text: 'Chat',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.history,
                      size: 24.0,
                    ),
                    text: 'History',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      size: 24.0,
                    ),
                    text: 'Profile',
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    print("Balik aning master");
    _tabController.index = 0;
    globalKey.currentState.onCekManing();
  }
}
