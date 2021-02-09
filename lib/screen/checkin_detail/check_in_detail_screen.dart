import 'package:flutter/material.dart';
import 'package:resap_admin/models/nodestoreinfo.dart';
import 'package:resap_admin/modelsfromjson/Stores.dart';
import 'package:resap_admin/screen/checkin_detail/components/body.dart';

class CheckInDetailScreen extends StatelessWidget {
  static String routeName = "/checkindetail";
  // final NodeStoreInfo args;
  final Stores args;
  final String contract;

  const CheckInDetailScreen(
      {Key key, @required this.args, @required this.contract})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // NodeStore args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Check Into"),
        centerTitle: true,
      ),
      body: Body(
        contract: contract,
        storeItem: args,
      ),
    );
  }
}
