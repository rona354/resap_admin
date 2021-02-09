import 'package:flutter/material.dart';
import 'package:resap_admin/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kTextColorError = Colors.red;
const kTextColorSuccess = Colors.green;
const kAnimationDuration = Duration(milliseconds: 200);
const kDefaultPadding = 20.0;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kPassNewNullError = "Please Enter your New password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kProfileError =
    "Incomplete Profile Data!, please check again the continue";
const String kNamelNullError = "Please Enter your name";
const String kNamelocNullError = "Please Enter location name";
const String kMobilelNullError = "Please Enter your mobile number";
const String kReveralCodeToshort = "Reveral code is too short";
const String kReveralCodeError = "Reveral code is wrong";
const String kVerifyCodeError = "Verify code is wrong";
const String kVerifyCodeNullError = "Verify code cannot empty";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kCredentialError =
    "User and Password not Exist!,\nplease contact Administrator";
const String kbalanceNullError = "Balance amount cannot null value";
const String kactualNullError = "Actual amount cannot null value";
const String kpreviewNullError = "Preview amount cannot null value";
const String ksoldNullError = "Sold amount cannot null value";
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
