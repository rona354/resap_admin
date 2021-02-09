import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/modelsfromjson/Product.dart';
import 'package:resap_admin/screen/components/custom_sufix_icon.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/components/form_error.dart';
import 'package:resap_admin/services/ServiceWorking.dart';
import 'package:resap_admin/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final Product stock;
  final String contract;
  const Body({Key key, @required this.stock, @required this.contract})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String tokenshared;
  String balance = "0";
  String actual = "0";
  String preview = "0";
  String sold = "0";
  final List<String> errors = [];

  TextEditingController _actualcontroller = TextEditingController();
  TextEditingController _previewcontroller = TextEditingController();
  TextEditingController _soldcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() {
    //   this.balance = 0;this.actual = 0;
    // });
    getPreferences().then(updateuserprofile);
    _actualcontroller.text = this.actual;
    _previewcontroller.text = this.preview;
    _soldcontroller.text = this.sold;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(10)),
          child: Column(
            children: [
              SizedBox(
                width: getProportionateScreenWidth(238),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Image.network(widget.stock.absolutepath),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              Text(
                "${widget.contract}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              Text(
                "${widget.stock.prodname}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Balance Amount",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Text("${balance} Unit"),
                ],
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              buildactualFormField(),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              buildpreviewFormField(),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              buildsoldFormField(),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              DefaultButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState.validate()) {
                    print("################ Validate Ok .... ${errors.length}");
                    if (errors.length < 1) {
                      _formKey.currentState.save();
                      // print("################ Actual ${this.actual}");
                      //                   String balance = "0";
                      // String actual = "0";
                      // String preview = "0";
                      // String sold = "0";

                      ServiceWorking.stockopnameIn(actual, preview, balance,
                          widget.stock.id, tokenshared, widget.contract);
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              FormError(errors: errors)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildactualFormField() {
    return TextFormField(
      controller: _actualcontroller,
      onTap: () => _actualcontroller.selection = TextSelection(
          baseOffset: 0, extentOffset: _actualcontroller.text.length),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => actual = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kactualNullError)) {
          setState(() {
            errors.remove(kactualNullError);
          });
        } else if (errors.contains(kactualNullError)) {
          setState(() {
            errors.remove(kactualNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kactualNullError)) {
          setState(() {
            errors.add(kactualNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Actual Unit",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter actual unit amount",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/receipt.svg",
          )),
    );
  }

  TextFormField buildpreviewFormField() {
    return TextFormField(
      controller: _previewcontroller,
      onTap: () => _previewcontroller.selection = TextSelection(
          baseOffset: 0, extentOffset: _previewcontroller.text.length),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => preview = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kpreviewNullError)) {
          setState(() {
            errors.remove(kpreviewNullError);
          });
        } else if (errors.contains(kpreviewNullError)) {
          setState(() {
            errors.remove(kpreviewNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kpreviewNullError)) {
          setState(() {
            errors.add(kpreviewNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Display Unit",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter display unit amount",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Shop Icon.svg",
          )),
    );
  }

  TextFormField buildsoldFormField() {
    return TextFormField(
      controller: _soldcontroller,
      onTap: () => _soldcontroller.selection = TextSelection(
          baseOffset: 0, extentOffset: _soldcontroller.text.length),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => sold = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(ksoldNullError)) {
          setState(() {
            errors.remove(ksoldNullError);
          });
        } else if (errors.contains(ksoldNullError)) {
          setState(() {
            errors.remove(ksoldNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(ksoldNullError)) {
          setState(() {
            errors.add(ksoldNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Sold Unit",
          labelStyle: TextStyle(fontSize: getProportionateScreenWidth(16)),
          hintText: "Enter sold amount",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Cash.svg",
          )),
    );
  }

  Future<String> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokeninfo = prefs.getString("token");
    return tokeninfo;
  }

  void updateuserprofile(String tokeninfo) {
    setState(() {
      this.tokenshared = tokeninfo;
    });
  }
}
