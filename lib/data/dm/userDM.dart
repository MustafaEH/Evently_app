import 'package:evently/data/dm/eventDM.dart';

class UserDm {
  String name;
  String id;
  String email;
  List<EventDM> favouriteEventsIds;
  static UserDm? currentUser;

  UserDm({
    required this.name,
    required this.id,
    required this.email,
    required this.favouriteEventsIds,
  });

  UserDm.fromJson(Map<String, dynamic> json)
    : name = json["name"],
      id = json["id"],
      email = json["email"],
      favouriteEventsIds =
          (json["favouriteEventsIds"] as List)
              .map((e) => EventDM.fromJson(e))
              .toList();

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "email": email,
    "favouriteEventsIds": favouriteEventsIds,
  };

}
