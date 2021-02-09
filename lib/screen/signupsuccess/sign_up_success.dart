import 'package:flutter/material.dart';
import 'package:resap_admin/screen/signupsuccess/components/body.dart';

class SignUpSuccessScreen extends StatelessWidget {
  static String routeName = "/sign_up_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: Text("Sign Up Success"),
      ),
      body: Body(),
    );
  }
}
