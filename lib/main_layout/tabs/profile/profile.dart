import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/main_layout/tabs/profile/widgets/customDropDown.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = "english";
  String selectedTheme = "light";

  @override
  Widget build(BuildContext context) {
    ConfigProvider configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(56.r)),
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Image.asset(AssetsManager.routeLogo),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mustafa Ehab",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "mustafaehab060@gmail.com",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Customdropdown(
                dropDownItems: [
                  DropdownMenuItem(value: "english", child: Text("English")),
                  DropdownMenuItem(value: "arabic", child: Text("عربى")),
                ],
                dropDownTitle: AppLocalizations.of(context)!.language,
                viewedText: configProvider.isEnglish ? "english" : "arabic",
                onChange: (newLang) {
                  // selectedLanguage = newLang ?? "english";
                  configProvider.changeLanguage(
                    newLang == "english" ? "en" : "ar",
                  );
                },
              ),
              SizedBox(height: 8.h),
              Customdropdown(
                dropDownItems: [
                  DropdownMenuItem(value: "light", child: Text("Light")),
                  DropdownMenuItem(value: "dark", child: Text("Dark")),
                ],
                dropDownTitle: AppLocalizations.of(context)!.theme,
                viewedText: configProvider.isLightMode ? "light" : "dark",
                onChange: (newTheme) {
                  // selectedTheme = newTheme!;
                  configProvider.changeTheme(
                    newTheme == "light" ? ThemeMode.light : ThemeMode.dark,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
