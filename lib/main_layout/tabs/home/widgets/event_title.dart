import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/data/dm/userDM.dart';
import 'package:evently/data/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTitle extends StatefulWidget {
  const EventTitle({super.key, required this.title, required this.eventId});

  final String title;
  final String eventId;

  @override
  State<EventTitle> createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  @override
  void didUpdateWidget(EventTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.eventId != widget.eventId) {
      _checkFavoriteStatus();
    }
  }

  void _checkFavoriteStatus() {
    if (UserDm.currentUser != null) {
      setState(() {
        isFavorite = UserDm.currentUser!.favouriteEventsIds.contains(
          widget.eventId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 8, horizontal: 9),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _toggleFavorite();
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: isFavorite ? Colors.red : ColorsManager.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() async {
    if (UserDm.currentUser == null) return;

    setState(() {
      isFavorite = !isFavorite;
    });

    if (isFavorite) {
      await FirebaseService.addEventToFav(widget.eventId);
    } else {
      await FirebaseService.removeEventFromFav(widget.eventId);
    }
  }
}
