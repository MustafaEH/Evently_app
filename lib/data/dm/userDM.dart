class UserDm {
  String name;
  String id;
  String email;
  List<String> favouriteEventsIds;
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
        favouriteEventsIds = List<String>.from(json["favouriteEventsIds"] ?? []);

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "email": email,
    "favouriteEventsIds": favouriteEventsIds,
  };
}
