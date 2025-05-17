class EventDM {
  final String title;
  final String description;
  final String Category;
  final String imagePath;
  final DateTime date;
  final DateTime time;
  final int? lat;
  final int? lng;

  EventDM({
    required this.title,
    required this.description,
    required this.Category,
    required this.imagePath,
    required this.date,
    required this.time,
    this.lat,
    this.lng,
  });
}
