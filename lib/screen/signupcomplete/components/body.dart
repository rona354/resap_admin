import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/components/form_error.dart';
import 'package:resap_admin/screen/dashboard/dashboard.dart';
import 'package:resap_admin/screen/forgot_password/forgot_password_screen.dart';
import 'package:resap_admin/screen/signupsuccess/sign_up_success.dart';
import 'package:resap_admin/screen/splash/splash_screen_view.dart';
import 'package:resap_admin/services/ServiceRegistration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Verify User",
                  style: headingStyle,
                ),
                Text(
                  "Input the verification code from your email to validate and continue",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                CompleteValidationForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteValidationForm extends StatefulWidget {
  @override
  _CompleteValidationFormState createState() => _CompleteValidationFormState();
}

class _CompleteValidationFormState extends State<CompleteValidationForm> {
  final _formKey = GlobalKey<FormState>();
  bool isRetriveSuccess = false;
  String verifyCode;
  final List<String> errors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.instance
      ..contentPadding = EdgeInsets.all(5)
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.green
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..backgroundColor = kPrimaryColor
      ..radius = 100.0
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildVerifyCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          DefaultButton(
            text: "Continue",
            press: () {
              EasyLoading.show();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                // print("################ " + verifyCode);
                // if (verifyCode != "123456" && errors.length < 1) {
                //   setState(() {
                //     errors.add(kVerifyCodeError);
                //   });
                // } else {
                //   setState(() {
                //     isRetriveSuccess = true;
                //     errors.remove(kVerifyCodeError);
                //     Navigator.pushNamed(context, SignUpSuccessScreen.routeName);
                //   });
                // }
                ServiceRegistration.verifyProfile(verifyCode).then((value) {
                  String tokencallback = value;
                  if (tokencallback != "0") {
                    saveCredentialPreference(tokencallback).then(
                        (bool committed) => Navigator.pushNamed(
                            context, SplashScreenView.routeName));

                    EasyLoading.dismiss();
                  } else {
                    EasyLoading.dismiss();
                    if (errors.length < 1) {
                      setState(() {
                        errors.add(kVerifyCodeError);
                      });
                    }
                  }
                });
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ForgotPasswordScreen())),
                  child: Text(
                    "Resend",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
              Text(
                ", If did not get Verify code",
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          FormError(errors: errors),
        ],
      ),
    );
  }

  Future<bool> saveCredentialPreference(String tokeninfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(tokeninfo);
    prefs.setString("token", tokeninfo);
    return prefs.commit();
  }

  TextFormField buildVerifyCodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => verifyCode = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kVerifyCodeError)) {
          setState(() {
            errors.remove(kVerifyCodeError);
          });
        } else if (errors.contains(kVerifyCodeNullError)) {
          setState(() {
            errors.remove(kVerifyCodeNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kVerifyCodeNullError)) {
          setState(() {
            errors.add(kVerifyCodeNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Verification Code",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your Code",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Parcel.svg",
          )),
    );
  }
}
