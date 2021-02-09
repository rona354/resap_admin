import 'package:flutter/material.dart';
import 'package:resap_admin/screen/components/roundbackbutton.dart';
import 'package:resap_admin/size_config.dart';

class CustomAppBar extends PreferredSize {
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenWidth(10)),
        child: Row(
          children: [
            RoundedIcon(
              iconData: Icons.arrow_back_ios,
              press: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
