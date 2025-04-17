import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.isSecure = false,
  });

  final String label;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onTap;
  bool isSecure;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isSecure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: widget.onTap,
          icon: Icon(widget.suffixIcon),
        ),
        prefixIcon: Icon(widget.prefixIcon),
        labelText: widget.label,
      ),
    );
  }
}
