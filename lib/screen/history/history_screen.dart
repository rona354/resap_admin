import 'package:flutter/material.dart';
import 'package:resap_admin/screen/history/components/body.dart';

class HistoryScreen extends StatelessWidget {
  static String routeName = "/historyscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("History"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
