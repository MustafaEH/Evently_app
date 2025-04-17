import 'package:evently/config/theme/theme_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      builder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManager.router,
            initialRoute: RoutesManager.signup,
            theme: ThemeManager.light,
            themeMode: ThemeMode.light,
            darkTheme: ThemeManager.dark,
          ),
    );
  }
}
