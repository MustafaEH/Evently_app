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

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSecureRePass = true;
  bool isSecurePass = true;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

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
                controller: nameController,
                label: AppLocalizations.of(context)!.name,
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: emailController,
                label: AppLocalizations.of(context)!.email,
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: passwordController,
                isSecure: isSecurePass,
                label: AppLocalizations.of(context)!.password,
                prefixIcon: Icons.lock,
                suffixIcon:
                    !isSecurePass ? Icons.visibility : Icons.visibility_off,
                onTap: () {
                  isSecurePass = !isSecurePass;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                controller: rePasswordController,
                isSecure: isSecureRePass,
                label: AppLocalizations.of(context)!.re_password,
                prefixIcon: Icons.lock,
                suffixIcon:
                    !isSecureRePass ? Icons.visibility : Icons.visibility_off,

                onTap: () {
                  isSecureRePass = !isSecureRePass;
                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.create_account,
                onTap: createAccount,
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

  void createAccount() async {
    try {
      DialogUtils.showLoadingDialog("Registering", context);
      await FirebaseService.registerUser(
        name: nameController.text,
        emailAddress: emailController.text,
        password: passwordController.text,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showDialogWithMessage(
        context,
        message: "Successfully Registered",
        posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.signIn);
        },
        positiveActionText: "OK",
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        DialogUtils.showDialogWithMessage(
          context,
          message: 'The password provided is too weak.',
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showDialogWithMessage(
          context,
          message: 'The account already exists for that email.',
          positiveActionText: "Try Again",
          posAction: () {
            DialogUtils.hideDialog(context);
          },
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
