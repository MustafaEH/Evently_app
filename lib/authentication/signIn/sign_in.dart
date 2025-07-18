import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/dialog_utils.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/data/firebase_service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isSecure = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AssetsManager.eventlyLogo,
                  width: 136.w,
                  height: 186.h,
                ),
                SizedBox(height: 24.h),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        prefixIcon: Icons.email,
                        label: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        controller: passwordController,
                        prefixIcon: Icons.lock,
                        label: AppLocalizations.of(context)!.password,
                        suffixIcon:
                            !isSecure ? Icons.visibility : Icons.visibility_off,
                        isSecure: isSecure,
                        onTap: () {
                          isSecure = !isSecure;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          title: AppLocalizations.of(context)!.forget_password,
                          onClick: () {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.resetPassword,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login,
                        onTap: login,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_account,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          CustomTextButton(
                            title: AppLocalizations.of(context)!.create_account,
                            onClick: () {
                              Navigator.pushNamed(
                                context,
                                RoutesManager.signup,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      buildOrWidget(),
                      SizedBox(height: 24.h),
                      loginWithGoogle(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildOrWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(thickness: 2, height: 1, color: ColorsManager.blue),
        Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            AppLocalizations.of(context)!.or,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }

  loginWithGoogle() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: REdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.blue, width: 2.sp),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.googleLogo, width: 32.w, height: 28.h),
            SizedBox(width: 16.w),
            Text(
              AppLocalizations.of(context)!.login_with_google,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    try {
      DialogUtils.showLoadingDialog("Logging in", context);
      await FirebaseService.login(
        emailController.text,
        passwordController.text,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showDialogWithMessage(
        context,
        message: "Successfully Logged in",
        posAction: () {
          DialogUtils.hideDialog(context);
          Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
        },
        positiveActionText: "done",
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showDialogWithMessage(
          context,
          message: "Wrong email or password",
          positiveActionText: "ok",
          posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
          },
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.hideDialog(context);
        DialogUtils.showDialogWithMessage(
          context,
          message: "Wrong password",
          positiveActionText: "ok",
        );
      }
    } catch (e){

      DialogUtils.showDialogWithMessage(context, message: "${e.toString()}");
    }
  }
}
