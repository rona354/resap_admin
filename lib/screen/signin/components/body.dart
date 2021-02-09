import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:resap_admin/constant.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/components/form_error.dart';
import 'package:resap_admin/screen/components/no_account_text.dart';
import 'package:resap_admin/screen/forgot_password/forgot_password_screen.dart';
import 'package:resap_admin/screen/login_success/login_success_screen.dart';
import 'package:resap_admin/screen/splash/splash_screen_view.dart';
import 'package:resap_admin/services/ServiceAuthentication.dart';

import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign In with your email and password \nor sign up first to get an account",
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: getProportionateScreenHeight(20),),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  SignForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool rememberMe = false;
  bool _isHidden = true;
  bool emptyPassword = true;
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
    // EasyLoading.show();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: rememberMe,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value;
                  });
                },
              ),
              Text("Remember Me"),
              Spacer(),
              GestureDetector(
                  // onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ForgotPasswordScreen())),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              // print('form validatornya ${_formKey.currentState.validate()}');
              if (_formKey.currentState.validate()) {
                EasyLoading.show();
                _formKey.currentState.save();
                ServiceAuthentication.authByEmail(email, password)
                    .then((value) {
                  String tokencallback = value;
                  // print(
                  //     " value from login : ${tokencallback.startsWith('DioError')}");
                  if (tokencallback.startsWith('DioError')) {
                    setState(() {
                      if (errors.length < 1) {
                        errors.remove(kCredentialError);
                        errors.add(kCredentialError);
                      }
                    });
                  } else {
                    print(" value from login : ${tokencallback.toString()}");
                    saveCredentialPreference(tokencallback.toString()).then(
                        (bool committed) => Navigator.pushNamed(
                            context, SplashScreenView.routeName));
                  }
                  EasyLoading.dismiss();
                });
                // print("################ " + password);
                // if (password != "123456" && errors.length < 1) {
                //   setState(() {
                //     errors.add(kCredentialError);
                //   });
                // } else {
                //   // email
                //   var fullname = email == "muktiryan@gmail.com"
                //       ? "Ryan Muktiadhi"
                //       : "Rahmat Kartono";

                //   saveCredentialPreference(fullname).then((bool committed) =>
                //       Navigator.pushNamed(
                //           context, LoginSuccessScreen.routeName));
                // }
              }
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(80),
          ),
          NoAccountText()
        ],
      ),
    );
  }

  Future<bool> saveCredentialPreference(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return prefs.commit();
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            emptyPassword = false;
          });
        }
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
            errors.remove(kCredentialError);
          });
        } else if (value.length < 6 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
            errors.remove(kCredentialError);
          });
        }
        return null;
      },
      validator: (value) {
        // print('value validator passwordnya: $value');
        if (value.isEmpty) {
          setState(() {
            errors.remove(kPassNullError);
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 6) {
          setState(() {
            errors.remove(kShortPassError);
            errors.add(kShortPassError);
          });
          return "";
        }
        // * Return null supaya form field dianggap valid
        return null;
      },
      obscureText: _isHidden,
      decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: emptyPassword == false
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => {
                    setState(() {
                      _isHidden = !_isHidden;
                    })
                  },
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          getProportionateScreenWidth(18),
                          getProportionateScreenWidth(20),
                          getProportionateScreenWidth(18)),
                      child: Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                          size: getProportionateScreenWidth(22))),
                )
              : CustomSuffixIcon(
                  svgIcon: "assets/icons/Lock.svg",
                )),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
            errors.remove(kCredentialError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
            errors.remove(kCredentialError);
          });
        }
        return null;
      },
      validator: (value) {
        // print('value validator email: $value');
        if (value.isEmpty) {
          setState(() {
            errors.remove(kEmailNullError);
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          setState(() {
            errors.remove(kInvalidEmailError);
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        // * Return null supaya form field dianggap valid
        return null;
      },
      decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          )),
    );
  }
}
