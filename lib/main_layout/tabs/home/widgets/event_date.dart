import 'package:evently/core/extensions/date_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDate extends StatelessWidget {
  const EventDate({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          children: [
            Text(date.day.toString(),style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16.sp,
            ),),
            Text(date.getMonthName,style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14.sp,
            ))
          ],
        ),
      ),
    );
  }
}
