import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
        
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
                SizedBox(width: 80.w),
                Text(
                  "Forget Password",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AssetsManager.resetPasswordLogo, height: 400.h),
                  SizedBox(height: 24.h),
                  CustomElevatedButton(text: "Reset Password"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

