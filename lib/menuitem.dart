import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItem {
  String menuVal;
  int realVal;
  IconData iconVal;
  MenuItem(this.menuVal, this.iconVal, this.realVal);
}

final List<MenuItem> menuitems1 = [
  MenuItem("Check In", Icons.access_time, 1),
  MenuItem("Leave Request", Icons.not_accessible, 2)
];

final List<MenuItem> menuitems2 = [
  MenuItem("Notes", Icons.note_add_outlined, 4),
];
final List<MenuItem> menuitems3 = [
  MenuItem("Stock Opname", Icons.wallet_giftcard, 5),
];
final List<MenuItem> menuitems4 = [
  MenuItem("Tag New Location", Icons.maps_ugc, 6),
];
