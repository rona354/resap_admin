import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../size_config.dart';
class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key, this.text, this.image,
  }) : super(key: key);
  final String text, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.title.copyWith(
                  fontWeight: FontWeight.bold), children: [
            TextSpan(text: "Re", style: TextStyle(color: kPrimaryColor, fontSize: 34),),
            TextSpan(text:"SAp", style: TextStyle(color: Colors.black45, fontSize: 34))
          ]),
        ),
        Text(text, textAlign: TextAlign.center,),
        Spacer(flex: 2,),
        Image.asset(image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),)
      ],
    );
  }
}