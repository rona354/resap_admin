import 'package:flutter/material.dart';
import 'package:resap_admin/screen/signupcomplete/components/body.dart';

class SignUpCompleteScreen extends StatelessWidget {
  static String routeName = "/sign_up_complete";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
