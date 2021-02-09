import 'package:flutter/material.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/dashboard/dashboard.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4,
        ),
        Text(
          "Sign Up Success",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black38),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () {
              Navigator.pushNamed(context, DashboardScreen.routeName);
            },
          ),
        ),
        Spacer()
      ],
    );
  }
}
