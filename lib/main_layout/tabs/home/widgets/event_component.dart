import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/data/dm/category.dart';
import 'package:evently/data/dm/eventDM.dart';
import 'package:evently/main_layout/tabs/home/widgets/event_date.dart';
import 'package:evently/main_layout/tabs/home/widgets/event_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventComponent extends StatelessWidget {
  const EventComponent({super.key, required this.event});

  final EventDM event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: REdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 210.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(image: AssetImage(event.Category.imagePath!)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventDate(date: event.date),
          EventTitle(title: event.title, eventId: event.id!),
        ],
      ),
    );
  }
}
