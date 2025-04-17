import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: Padding(
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
                ),
                SizedBox(width: 100.w),
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Image.asset(AssetsManager.eventlyLogo, height: 160.h),
            SizedBox(height: 24.h),
            CustomTextFormField(label: "Name", prefixIcon: Icons.person),
            SizedBox(height: 16.h),
            CustomTextFormField(label: "Email", prefixIcon: Icons.email),
            SizedBox(height: 16.h),
            CustomTextFormField(
              isSecure: widget.isSecurePass,
              label: "Password",
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
              label: "Re Password",
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
            CustomElevatedButton(text: "Create Account"),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account? ",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.copyWith(fontSize: 16.sp),
                ),
                CustomTextButton(
                  title: "Login",
                  onClick: () {
                    Navigator.pushNamed(context, RoutesManager.signIn);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
