import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resap_admin/modelsfromjson/Product.dart';
import 'package:resap_admin/screen/stockopnamedetail/components/body.dart';
import 'package:resap_admin/screen/stockopnamedetail/components/customappbar.dart';

class StockOpnameDetailScreen extends StatelessWidget {
  static String routeName = "/stockopnamedetail";
  @override
  Widget build(BuildContext context) {
    final ProductDetailArguments arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: CustomAppBar(),
        body: Body(stock: arguments.stock, contract: arguments.contract));
  }
}

class ProductDetailArguments {
  final Product stock;
  final String contract;
  ProductDetailArguments({@required this.stock, this.contract});
}
