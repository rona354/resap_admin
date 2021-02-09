import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/components/default_custom_button.dart';
import 'package:resap_admin/screen/components/form_error.dart';
import 'package:resap_admin/screen/splash/splash_screen_view.dart';
import 'package:resap_admin/services/ServiceAuthentication.dart';
import 'package:resap_admin/services/ServiceTenantMember.dart';
import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _ctrlEmail, _ctrlFullName, _ctrlMobile;
  String email;
  String password;
  String conpassword;
  String tokenshared;
  String fullName;
  String reveralCode;
  String mobile;
  String companyCode;
  bool isChangePassword = false;

  final Map<int, String> listGroup = {};
  final List<String> errors = [];
  @override
  void dispose() {
    // TODO: implement dispose
    _ctrlFullName.dispose();
    _ctrlEmail.dispose();
    _ctrlMobile.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isChangePassword = false;
    _ctrlEmail = new TextEditingController();
    _ctrlFullName = new TextEditingController();
    _ctrlMobile = new TextEditingController();
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
    getPreferences().then(updateuserprofile);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
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
                  visible: isChangePassword, child: buildPasswordFormField()),
              Visibility(
                visible: isChangePassword,
                child: SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
              ),
              Visibility(
                  visible: isChangePassword,
                  child: buildConPasswordFormField()),
              Visibility(
                visible: isChangePassword,
                child: SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
              ),
              DefaultCustomButton(
                press: () {
                  setState(() {
                    isChangePassword = isChangePassword ? false : true;
                    if (isChangePassword == false) {
                      errors.remove(kPassNullError);
                      errors.remove(kPassNewNullError);
                      errors.remove(kShortPassError);
                    }
                  });
                },
                bgcolor: Colors.yellow[700],
                text: isChangePassword ? "Cancel" : "Change Password?",
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              DefaultButton(
                press: () {
                  EasyLoading.show();
                  print(
                      "################# Submit with change password ${isChangePassword}");
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // print("################ Email ${email}");
                    // print("################ fullname ${fullName}");
                    // print("################ mobile ${mobile}");
                    // print("################ password ${password}");
                    // print("################ password ${conpassword}");
                    if (isChangePassword) {
                      var username = fullName.toLowerCase();
                      username = username.replaceAll(' ', '');
                      ServiceTenantMember.updateProfileWP(username, fullName,
                              email, mobile, 0, conpassword, tokenshared)
                          .then((value) {
                        var _value = value;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Success Update Profile"),
                                content: Text(
                                  "This application will be restart!",
                                  style: TextStyle(color: Colors.green[700]),
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            SplashScreenView.routeName);
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            });
                      });
                    } else {
                      var username = fullName.toLowerCase();
                      username = username.replaceAll(' ', '');
                      ServiceTenantMember.updateProfileWOP(
                              username, fullName, email, mobile, 0, tokenshared)
                          .then((value) {
                        var _value = value;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Success Update Profile"),
                                content: Text(
                                  "This application will be restart!",
                                  style: TextStyle(color: Colors.green[700]),
                                ),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            SplashScreenView.routeName);
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            });
                      });
                    }
                  }
                },
                text: "Submit Changes",
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: DefaultCustomButton(
                  press: () => showDialogSignout(context),
                  bgcolor: Colors.red[700],
                  text: "Sign Out and Clear Data",
                ),
              ),
              FormError(errors: errors),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: _ctrlFullName,
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
            // errors.remove(kCredentialError);
          });
        } else if (value.length < 6 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
            // errors.remove(kCredentialError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty &&
            !errors.contains(kPassNullError) &&
            isChangePassword) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 6 &&
            !errors.contains(kShortPassError) &&
            isChangePassword) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Old Password *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your old password",
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
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty &&
            !errors.contains(kPassNewNullError) &&
            isChangePassword) {
          setState(() {
            errors.add(kPassNewNullError);
          });
        } else if (value.length < 6 &&
            !errors.contains(kPassNewNullError) &&
            isChangePassword) {
          setState(() {
            errors.add(kPassNewNullError);
          });
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          labelText: "New Password *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Insert new password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Lock.svg",
          )),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _ctrlEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
            // errors.remove(kCredentialError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
            // errors.remove(kCredentialError);
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
      controller: _ctrlMobile,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => mobile = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kMobilelNullError)) {
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
          labelText: "Mobile *",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter your mobile",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Phone.svg",
          )),
    );
  }

  void updateuserprofile(String tokeninfo) {
    setState(() {
      this.tokenshared = tokeninfo;
      ServiceAuthentication.getProfileByToken(tokeninfo).then((value) {
        var _value = value;
        print("############### Inside Update Profile ${_value.tnemail}");
        _ctrlFullName.value = TextEditingValue(text: _value.tnfullname);
        _ctrlEmail.value = TextEditingValue(text: _value.tnemail);
        _ctrlMobile.value = TextEditingValue(text: _value.tnphone);
      });
      EasyLoading.dismiss();
    });
  }

  void showDialogSignout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Signing Out"),
          content: Text(
              "If you signout your data would be deleted from this app, Are you sure?"),
          actions: [
            FlatButton(
              child: Text("YES"),
              onPressed: () async {
                //Put your code here which you want to execute on Yes button click.
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<String> getPreferences() async {
    EasyLoading.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokeninfo = prefs.getString("token");
    // print("Get Userpreference $tokeninfo");
    return tokeninfo;
  }
}
