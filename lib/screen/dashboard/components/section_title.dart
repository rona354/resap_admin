import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    Key key,
    @required this.text,
    this.textmore,
    @required this.press,
  }) : super(key: key);
  final String text, textmore;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black),),
          GestureDetector(
              onTap: press,
              child: Text(textmore,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: Colors.black26),))
        ],
      ),
    );
  }
}