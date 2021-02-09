import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resap_admin/screen/login_success/components/icon_btn_with_counter.dart';

import '../../../constant.dart';
import '../../../size_config.dart';

Padding HomeHeader(BuildContext context, int jml) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: Container(
            width: SizeConfig.screenWidth * 0.65,
            height: 55,
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "RE",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "SAP",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "ADMIN",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        IconButtonWithCounter(
          svgSrc: "assets/icons/Bell.svg",
          numOfItems: jml,
          press: () {},
        )
      ],
    ),
  );
}
