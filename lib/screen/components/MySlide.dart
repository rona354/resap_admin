import 'package:flutter/material.dart';

class MySlide extends MaterialPageRoute {

  MySlide({WidgetBuilder builder, RouteSettings settings}):super(builder:builder, settings:settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    // return super.buildTransitions(context, animation, secondaryAnimation, child);
    Animation<Offset> custom = Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset(0.0,0.0)).animate(animation);
    return SlideTransition(position: custom,child: child);
  }
}
