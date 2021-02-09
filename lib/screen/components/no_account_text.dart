import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resap_admin/screen/forgot_password/forgot_password_screen.dart';
import 'package:resap_admin/screen/signup/sign_up_screen.dart';

import '../../constant.dart';
import '../../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
            onTap: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SignUpScreen())),
            child: Text(
              "Sign Up ",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor),
            )),
      ],
    );
  }
}
