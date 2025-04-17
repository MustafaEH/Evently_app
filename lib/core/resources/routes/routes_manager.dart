import 'package:evently/authentication/signIn/sign_in.dart';
import 'package:evently/authentication/signUp/sign_up.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signup = '/signUp';
  static const String signIn = '/signIn';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (context) => const SignIn());
      case signup:
        return CupertinoPageRoute(builder: (context) => const SignUp());
    }
  }
}
