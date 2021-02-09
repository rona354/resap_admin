import 'package:flutter/material.dart';
import 'package:resap_admin/screen/login_success/components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: Text("Login Success"),
      ),
      body: Body(),
    );
  }
}
