import 'package:flutter/material.dart';
import 'package:resap_admin/screen/stockopname/components/body.dart';

class StockOpnameScreen extends StatelessWidget {
  final String contract;
  static String routeName = "/stock_opname";

  const StockOpnameScreen({Key key, @required this.contract}) : super(key: key);
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
        title: Text("Stock List"),
        centerTitle: true,
      ),
      body: Body(
        contract: this.contract,
      ),
    );
  }
}
