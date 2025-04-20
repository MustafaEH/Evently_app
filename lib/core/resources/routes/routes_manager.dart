import 'package:evently/authentication/reset_password/reset_password.dart';
import 'package:evently/authentication/signIn/sign_in.dart';
import 'package:evently/authentication/signUp/sign_up.dart';
import 'package:evently/main_layout/main_layout.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signup = '/signUp';
  static const String signIn = '/signIn';
  static const String resetPassword = '/resetPassword';
  static const String mainLayout = '/mainLayout';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (context) => const SignIn());
      case signup:
        return CupertinoPageRoute(builder: (context) =>  SignUp());
      case resetPassword:
        return CupertinoPageRoute(builder: (context) => const ResetPassword());
      case mainLayout:
        return CupertinoPageRoute(builder: (context) => const MainLayout());
    }
    return null;
  }
}
