import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/models/information.dart';
import 'package:resap_admin/size_config.dart';

class InformationCard extends StatelessWidget {
  final double width, aspecRetion;
  final Information infoObject;

  const InformationCard({
    Key key,
    this.width,
    this.aspecRetion,
    this.infoObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: aspecRetion,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image:
                          new AssetImage("assets/images/${infoObject.bgimage}"),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  this.infoObject.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      backgroundColor: kPrimaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
