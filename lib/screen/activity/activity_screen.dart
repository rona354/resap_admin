import 'package:flutter/material.dart';
import 'package:resap_admin/screen/activity/components/body.dart';

class ActivityScreen extends StatelessWidget {
  final String contract;
  static String routeName = "/activity";

  const ActivityScreen({Key key, this.contract}) : super(key: key);

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
        title: Text("Activity"),
        centerTitle: true,
      ),
      body: BodyActivity(
        contract: this.contract,
      ),
    );
  }
}
