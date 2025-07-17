import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/resources/constant_manager.dart';
import 'package:evently/data/dm/category.dart';

class EventDM {
  String? id;
  final String title;
  final String description;
  final CategoryDM Category;
  final DateTime date;
  final int? lat;
  final int? lng;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EventDM({
    this.id,
    required this.title,
    required this.description,
    required this.Category,
    required this.date,
    this.lat,
    this.lng,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  }) {
    // Validation
    if (title.trim().isEmpty) {
      throw ArgumentError('Event title cannot be empty');
    }
    if (description.trim().isEmpty) {
      throw ArgumentError('Event description cannot be empty');
    }
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      throw ArgumentError('Event date cannot be in the past');
    }
  }

  // Copy with method for immutability
  EventDM copyWith({
    String? id,
    String? title,
    String? description,
    CategoryDM? Category,
    DateTime? date,
    int? lat,
    int? lng,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EventDM(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      Category: Category ?? this.Category,
      date: date ?? this.date,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Check if event is in the past
  bool get isPast => date.isBefore(DateTime.now());

  // Check if event is today
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Check if event is upcoming (not past and not today)
  bool get isUpcoming => !isPast && !isToday;

  // Get formatted date string
  String get formattedDate {
    if (isToday) return 'Today';
    if (isPast) return 'Past Event';
    return '${date.day}/${date.month}/${date.year}';
  }

  // Get formatted time string
  String get formattedTime {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "categoryId": Category.id,
      "date": Timestamp.fromDate(date),
      "lat": lat,
      "lng": lng,
      "createdBy": createdBy,
      "createdAt": createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      "updatedAt": updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  EventDM.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      title = json["title"] ?? '',
      description = json["description"] ?? '',
      date = (json["date"] as Timestamp).toDate(),
      lat = json["lat"],
      lng = json["lng"],
      createdBy = json["createdBy"],
      createdAt =
          json["createdAt"] != null
              ? (json["createdAt"] as Timestamp).toDate()
              : null,
      updatedAt =
          json["updatedAt"] != null
              ? (json["updatedAt"] as Timestamp).toDate()
              : null,
      Category = ConstantManager.categories.firstWhere(
        (category) => category.id == json["categoryId"],
        orElse: () => ConstantManager.categories.first,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventDM && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'EventDM(id: $id, title: $title, date: $date)';
  }
}
