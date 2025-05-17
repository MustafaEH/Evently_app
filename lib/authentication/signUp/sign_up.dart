import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  bool isSecureRePass = true;
  bool isSecurePass = true;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: ColorsManager.black,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(width: 100.w),
                  Text(
                    AppLocalizations.of(context)!.register,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Image.asset(
                AssetsManager.eventlyLogo,
                height: 160.h,
                width: 160.w,
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(
                label: AppLocalizations.of(context)!.name,
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                label: AppLocalizations.of(context)!.email,
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                isSecure: widget.isSecurePass,
                label: AppLocalizations.of(context)!.password,
                prefixIcon: Icons.lock,
                suffixIcon:
                    !widget.isSecurePass
                        ? Icons.visibility
                        : Icons.visibility_off,
                onTap: () {
                  widget.isSecurePass = !widget.isSecurePass;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                isSecure: widget.isSecureRePass,
                label: AppLocalizations.of(context)!.re_password,
                prefixIcon: Icons.lock,
                suffixIcon:
                    !widget.isSecureRePass
                        ? Icons.visibility
                        : Icons.visibility_off,

                onTap: () {
                  widget.isSecureRePass = !widget.isSecureRePass;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.create_account,
                onTap: () {},
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  CustomTextButton(
                    title: AppLocalizations.of(context)!.login,
                    onClick: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
