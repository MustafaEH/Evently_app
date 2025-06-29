import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/data/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTitle extends StatelessWidget {
  const EventTitle({super.key, required this.title, required this.eventId});

  final String title;
  final String eventId;

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
            IconButton(
              onPressed: () {
                addEventToFav();
              },
              icon: Icon(Icons.favorite_outline),
              color: ColorsManager.blue,
            ),
          ],
        ),
      ),
    );
  }

  void addEventToFav() async {
    await FirebaseService.addEventToFav(eventId);
  }
}
