import 'package:flutter/material.dart';
import 'package:resap_admin/screen/checkin/components/body.dart';

class CheckInScreen extends StatelessWidget {
  final String contract;
  static String routeName = "/checkin";

  const CheckInScreen({Key key, this.contract}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
          },
        ),
        title: Text("Check Into"),
        centerTitle: true,
      ),
      body: Body(contract: this.contract),
    );
  }
}
