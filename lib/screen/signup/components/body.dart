import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resap_admin/modelsfromjson/groupcode.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/components/form_error.dart';
import 'package:resap_admin/screen/signupcomplete/sign_up_complete.dart';
import 'package:resap_admin/services/ServiceRegistration.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

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
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Fill your Profile Account then Submit, or ask the Administrator for Company Verification Code",
                    textAlign: TextAlign.left,
                  ),
                  // SizedBox(height: getProportionateScreenHeight(20),),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  SignUpForm(),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String baseurl = 'https://resap.kmselaras.com/apiresap/v1/';
  final _formKey = GlobalKey<FormState>();
  bool isRetriveSuccess = false;
  String email;
  String password;
  String conpassword;
  String fullName;
  String reveralCode;
  String mobile;
  String companyCode;
  String groupName = "Undefined";
  String tenantname = "Undefined";
  final Map<int, String> listGroup = {};
  final List<String> errors = [];
  List<Groupcode> _lgroupCode;

  void getGroupTenant(code) async {
    var codeStr = code;
    errors.remove(kReveralCodeError);
    EasyLoading.show();
    ServiceRegistration.getGroupcode(codeStr).then((value) {
      _lgroupCode = value;

      if (_lgroupCode.length > 0) {
        EasyLoading.dismiss();
        print(_lgroupCode[0].tnname);
        setState(() {
          tenantname = this._lgroupCode[0].tnname;
          groupName = this._lgroupCode[0].groupname;
          isRetriveSuccess = true;
          errors.remove(kEmailNullError);
          errors.remove(kNamelNullError);
          errors.remove(kMobilelNullError);
          errors.remove(kInvalidEmailError);
          errors.remove(kPassNullError);
          errors.remove(kReveralCodeError);
        });
      } else {
        EasyLoading.dismiss();
        setState(() {
          errors.add(kReveralCodeError);
        });
      }

      // setState(() {});
    });
  }

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            buildFullNameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            buildMobileFormField(),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Visibility(
                visible: !isRetriveSuccess, child: buildReveralCodeFormField()),
            Visibility(
                visible: !isRetriveSuccess,
                child: SizedBox(
                  height: getProportionateScreenHeight(15),
                )),
            Visibility(
              visible: !isRetriveSuccess,
              child: DefaultButton(
                text: "Retrive Code",
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print("################ " + reveralCode);
                    getGroupTenant(reveralCode);
                  }
                },
              ),
            ),
            //Button Retrive Code
            // SizedBox(height: getProportionateScreenHeight(15),),

            Visibility(
              visible: isRetriveSuccess,
              child: Stack(
                children: <Widget>[
                  //notifikasi
                  Container(
                    width: getProportionateScreenWidth(400),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(1, 1))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  child: Icon(
                                    Icons.flag,
                                    color: Colors.white,
                                  )),
                              Text(
                                groupName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  child: Icon(
                                    Icons.ac_unit,
                                    color: Colors.white,
                                  )),
                              Text(tenantname,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
                visible: isRetriveSuccess,
                child: SizedBox(
                  height: getProportionateScreenHeight(15),
                )),
            Visibility(
              child: buildPasswordFormField(),
              visible: isRetriveSuccess,
            ),
            Visibility(
                visible: isRetriveSuccess,
                child: SizedBox(
                  height: getProportionateScreenHeight(15),
                )),
            Visibility(
              child: buildConPasswordFormField(),
              visible: isRetriveSuccess,
            ),
            Visibility(
                visible: isRetriveSuccess,
                child: SizedBox(
                  height: getProportionateScreenHeight(15),
                )),
            Visibility(
              visible: isRetriveSuccess,
              child: DefaultButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // print("################ Password : " + password);
                    if (password != conpassword && errors.length < 1) {
                      setState(() {
                        errors.add(kMatchPassError);
                      });
                    } else if (errors.length < 1) {
                      EasyLoading.show();
                      var username = fullName.toLowerCase();
                      username = username.replaceAll(' ', '');
                      var tenantStr = reveralCode.substring(4, 7);
                      var codeGroupStr = reveralCode.substring(7, 10);
                      // print(
                      //     "tnuserid:${username}, tnfullname:${fullName}, tnsecret:${password}, tnemail:${email}, tnphone:${mobile}, tnstatus:0, grpfkid:${int.parse(codeGroupStr)}, tnfkid:${int.parse(tenantStr)}");
                      ServiceRegistration.saveProfile(
                              username,
                              fullName,
                              password,
                              email,
                              mobile,
                              0,
                              int.parse(codeGroupStr),
                              int.parse(tenantStr))
                          .then((value) {
                        String _idconregittoken = value;
                        print("################ Numberr Token Id : " +
                            _idconregittoken);
                        if (int.parse(_idconregittoken) > 0) {
                          Navigator.pushNamed(
                              context, SignUpCompleteScreen.routeName);
                        }
                        EasyLoading.dismiss();
                      });
                    } else {}
                  }
                },
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            FormError(errors: errors),
          ],
        ),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fullName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNamelNullError)) {
          setState(() {
            errors.remove(kNamelNullError);
          });
        } else if (errors.contains(kNamelNullError)) {
          setState(() {
            errors.remove(kNamelNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kNamelNullError)) {
          setState(() {
            errors.add(kNamelNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Full Name *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your Fullname",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/User.svg",
          )),
    );
  }

  TextFormField buildReveralCodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => reveralCode = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kReveralCodeError)) {
          setState(() {
            errors.remove(kReveralCodeError);
            errors.remove(kReveralCodeError);
          });
        } else if (errors.contains(kReveralCodeError)) {
          setState(() {
            errors.remove(kReveralCodeError);
            errors.remove(kReveralCodeError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kReveralCodeError)) {
          setState(() {
            errors.add(kReveralCodeError);
          });
        } else if (!errors.contains(kReveralCodeError)) {
          setState(() {
            errors.add(kReveralCodeError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Reveral Code",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter reveral code",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Bell.svg",
          )),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
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
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 6 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your new password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  TextFormField buildConPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => conpassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kMatchPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        } else if (password == conpassword) {
          errors.remove(kMatchPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
        } else if (value.length < 6 && !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Confirm Password *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Confirm your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
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
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Email *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Mail.svg",
          )),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => mobile = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kMobilelNullError)) {
          setState(() {
            errors.remove(kMobilelNullError);
          });
        } else if (errors.contains(kMobilelNullError)) {
          setState(() {
            errors.remove(kMobilelNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kMobilelNullError)) {
          setState(() {
            errors.add(kMobilelNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Mobile Phone *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your mobile number",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Phone.svg",
          )),
    );
  }
}
