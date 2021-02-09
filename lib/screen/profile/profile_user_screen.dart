import 'package:flutter/material.dart';
import 'package:resap_admin/screen/profile/components/body.dart';

class ProfileUserScreen extends StatelessWidget {
  static String routeName = "/profile_user";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text("User Profile"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Body(),
    );
  }
}
