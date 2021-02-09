import 'package:flutter/material.dart';
import 'package:resap_admin/modelsfromjson/Product.dart';
import 'package:resap_admin/screen/components/stockitemcardlist.dart';

class ListStocks extends StatelessWidget {
  final List<Product> listProducts;
  final String contract;
  const ListStocks({Key key, this.listProducts, this.contract})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProducts.length,
        itemBuilder: (context, index) {
          return StockOpnameCard(
            product: listProducts[index],
            contract: contract,
          );
        });
    // return Column(
    //   children: [StockOpnameCard()],
    // );
  }
}
