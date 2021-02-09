import 'package:flutter/material.dart';
import 'package:resap_admin/size_config.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    Key key,
    @required this.iconData,
    @required this.press,
  }) : super(key: key);

  final IconData iconData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(color: Colors.white, shape: CircleBorder()),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        iconSize: 20.0,
        onPressed: press,
      ),
    );
    // return SizedBox(
    //   height: getProportionateScreenWidth(40),
    //   width: getProportionateScreenWidth(40),
    //   child: FlatButton(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(40),
    //     ),
    //     color: Colors.white,
    //     onPressed:press,
    //     child: Icon(iconData)
    //     ),
    // );
  }
}
