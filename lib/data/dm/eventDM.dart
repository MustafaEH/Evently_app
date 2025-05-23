import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/data/dm/category.dart';

class EventDM {
  String? id;
  final String title;
  final String description;
  final CategoryDM Category;

  // final String imagePath;
  final DateTime date;

  // final DateTime time;
  final int? lat;
  final int? lng;

  EventDM({
    this.id = "",
    required this.title,
    required this.description,
    required this.Category,
    // required this.imagePath,
    required this.date,
    // required this.time,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      // "time": time,
      "id": id,
      "title": title,
      "description": description,
      "categoryId": Category.id,
      "date": Timestamp.fromDate(date),
    };
  }

  EventDM.fromJson(Map<String, dynamic> json)
    : this(
        // time: json["time"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: (json["date"] as Timestamp).toDate(),
        Category: ConstantManager.categories.firstWhere(
          (category) => category.id == json["categoryId"],
        ),
      );
}
