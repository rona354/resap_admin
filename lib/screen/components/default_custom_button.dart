import 'package:flutter/material.dart';
import '../../size_config.dart';

class DefaultCustomButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color bgcolor;

  const DefaultCustomButton({Key key, this.text, this.press, this.bgcolor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: bgcolor,
        onPressed: press,
        child: Text(text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white)),
      ),
    );
  }
}
