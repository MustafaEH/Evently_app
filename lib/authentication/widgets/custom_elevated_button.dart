import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, this.onTap});
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 16),
        backgroundColor: ColorsManager.blue,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
