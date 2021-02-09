import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resap_admin/constant.dart';
import 'package:resap_admin/screen/components/default_button.dart';
import 'package:resap_admin/screen/signin/sign_in_screen.dart';
import 'package:resap_admin/screen/splash/components/splash_content.dart';
import 'package:resap_admin/screen/splash/splash_screen.dart';
import 'package:resap_admin/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Reporting System Application",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "Report your worked, in real time",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Tagging location and Report the Events",
      "image": "assets/images/splash_3.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]["text"]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length, (index) => buildDot(index: index)),
                    ),
                    Spacer(),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        // Navigator.push(context, PageRouteBuilder(
                        //   pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
                        //   transitionsBuilder: (context, animation, secondaryAnimation, child){
                        //     return SlideTransition(
                        //       position: Tween<Offset>(
                        //         begin: const Offset(1.0, 0.0),
                        //         end: Offset.zero,
                        //       ).animate(animation),
                        //       child: SlideTransition(
                        //         position: Tween<Offset>(
                        //         begin: Offset.zero,
                        //         end: const Offset(1.0, 0.0),
                        //         ).animate(secondaryAnimation),
                        //         child:child)
                        //     );
                        //   }
                        // ));
                        Navigator.popAndPushNamed(
                            context, SignInScreen.routeName);
                        // Navigator.push(context, CupertinoPageRoute(builder: (context) => SignInScreen()));
                      },
                    ),
                    Spacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kPrimaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
