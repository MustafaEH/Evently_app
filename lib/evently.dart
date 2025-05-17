import 'package:evently/config/theme/theme_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      builder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManager.router,
            initialRoute: RoutesManager.signIn,
            theme: ThemeManager.light,
            darkTheme: ThemeManager.dark,
            themeMode: configProvider.currentTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('en'), // English
              Locale('ar'), // Spanish
            ],
            locale: Locale(configProvider.currentLanguage),
          ),
    );
  }
}
