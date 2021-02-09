import 'package:flutter/material.dart';
import 'package:resap_admin/modelsfromjson/CurrentLocation.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';
import 'package:resap_admin/screen/checkout_detail/components/body.dart';

class CheckOutDetailScreen extends StatelessWidget {
  static String routeName = "/checkoutdetail";
  final CurrentLocation args;
  final String contract;

  const CheckOutDetailScreen(
      {Key key, @required this.args, @required this.contract})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Check Out"),
        centerTitle: true,
      ),
      body: Body(
        contract: contract,
        storeItem: args,
      ),
    );
  }
}
