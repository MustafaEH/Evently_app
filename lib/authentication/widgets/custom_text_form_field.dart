import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.label,
     this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.isSecure = false,
    this.hint,  this.lines = 1,
  });

  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onTap;
  bool isSecure;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      minLines: lines,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      obscureText: isSecure,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(suffixIcon),
          color: ColorsManager.grey,
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: ColorsManager.grey) : null,
        labelText: label,
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
      ),
    );
  }
}
