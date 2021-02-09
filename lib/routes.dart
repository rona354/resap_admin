import 'package:flutter/material.dart';

import 'screen/checkin/check_in_screen.dart';
import 'screen/checkin_detail/check_in_detail_screen.dart';
import 'screen/checkout_detail/checkout_detail_screen.dart';
import 'screen/dashboard/dashboard.dart';
import 'screen/forgot_password/forgot_password_screen.dart';
import 'screen/history/history_screen.dart';
import 'screen/login_success/login_success_screen.dart';
import 'screen/messaging/messaging_screen.dart';
import 'screen/profile/profile_user_screen.dart';
import 'screen/signin/sign_in_screen.dart';
import 'screen/signup/sign_up_screen.dart';
import 'screen/signupcomplete/sign_up_complete.dart';
import 'screen/signupsuccess/sign_up_success.dart';
import 'screen/splash/splash_screen.dart';
import 'screen/splash/splash_screen_view.dart';
import 'screen/stockopname/stock_opname_screen.dart';
import 'screen/stockopnamedetail/stock_opname_detail_screen.dart';
import 'screen/tagingnew/tagging_location_screen.dart';

//All of our route will be here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SplashScreenView.routeName: (context) => SplashScreenView(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SignUpCompleteScreen.routeName: (context) => SignUpCompleteScreen(),
  SignUpSuccessScreen.routeName: (context) => SignUpSuccessScreen(),
  DashboardScreen.routeName: (context) => DashboardScreen(),
  CheckInScreen.routeName: (context) => CheckInScreen(),
  CheckInDetailScreen.routeName: (context) => CheckInDetailScreen(
        args: null,
      ),
  CheckOutDetailScreen.routeName: (context) => CheckOutDetailScreen(
        args: null,
      ),
  TaggingLocationScreen.routeName: (context) => TaggingLocationScreen(),
  MessagingScreen.routeName: (context) => MessagingScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  ProfileUserScreen.routeName: (context) => ProfileUserScreen(),
  StockOpnameScreen.routeName: (context) => StockOpnameScreen(),
  StockOpnameDetailScreen.routeName: (context) => StockOpnameDetailScreen()
};

// SignInScreen()
