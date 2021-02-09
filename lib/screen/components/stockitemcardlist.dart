import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resap_admin/modelsfromjson/Product.dart';

import 'package:resap_admin/screen/stockopnamedetail/stock_opname_detail_screen.dart';
import 'package:resap_admin/size_config.dart';
import 'package:flutter/cupertino.dart';

class StockOpnameCard extends StatelessWidget {
  const StockOpnameCard({
    Key key,
    @required this.product,
    @required this.contract,
  }) : super(key: key);
  final Product product;
  final String contract;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
      child: InkWell(
        onTap: () {
          // print("Click ${stock.idstock}");
          // Navigator.push(
          //     context,
          //     CupertinoPageRoute(
          //         builder: (context) => StockOpnameDetailScreen(), settings: RouteSettings));
          Navigator.pushNamed(context, StockOpnameDetailScreen.routeName,
                  arguments: ProductDetailArguments(
                      stock: product, contract: contract))
              .then(onGoBack);
        },
        child: Row(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(88),
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15)),
                  child:
                      Image.network(product.absolutepath, fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.prodname,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text.rich(TextSpan(
                    text: "#${contract}",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.green,
                        fontSize: 12)))
              ],
            )
          ],
        ),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    print("Balik Abis Detail");
  }
}
// text:
//                         "Bal: ${stock.jmlbalance}, Act: ${stock.jmlactual}, Dep: ${stock.jmldecreas}, Sold: ${stock.jmlsold}",
