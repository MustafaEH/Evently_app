import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.title, required this.onClick});
  final String title;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onClick,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
