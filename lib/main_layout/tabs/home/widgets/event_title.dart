import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTitle extends StatelessWidget {
  const EventTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 8, horizontal: 9),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.favorite, color: ColorsManager.blue),
          ],
        ),
      ),
    );
  }
}
