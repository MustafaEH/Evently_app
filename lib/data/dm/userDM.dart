class UserDm {
  String name;
  String id;
  String email;
  List<String> favouriteEventsIds;
  String? profileImageUrl;
  DateTime? createdAt;
  DateTime? lastLoginAt;
  static UserDm? currentUser;

  UserDm({
    required this.name,
    required this.id,
    required this.email,
    required this.favouriteEventsIds,
    this.profileImageUrl,
    this.createdAt,
    this.lastLoginAt,
  }) {
    // Validation
    if (name.trim().isEmpty) {
      throw ArgumentError('User name cannot be empty');
    }
    if (email.trim().isEmpty || !email.contains('@')) {
      throw ArgumentError('Invalid email address');
    }
    if (id.trim().isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }
  }

  // Copy with method for immutability
  UserDm copyWith({
    String? name,
    String? id,
    String? email,
    List<String>? favouriteEventsIds,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserDm(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      favouriteEventsIds: favouriteEventsIds ?? this.favouriteEventsIds,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  // Check if user has favorite events
  bool get hasFavorites => favouriteEventsIds.isNotEmpty;

  // Get favorite count
  int get favoriteCount => favouriteEventsIds.length;

  // Get user initials for avatar
  String get initials {
    final nameParts = name.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  // Check if event is favorited
  bool isEventFavorited(String eventId) {
    return favouriteEventsIds.contains(eventId);
  }

  // Add event to favorites
  void addToFavorites(String eventId) {
    if (!favouriteEventsIds.contains(eventId)) {
      favouriteEventsIds.add(eventId);
    }
  }

  // Remove event from favorites
  void removeFromFavorites(String eventId) {
    favouriteEventsIds.remove(eventId);
  }

  // Clear all favorites
  void clearFavorites() {
    favouriteEventsIds.clear();
  }

  UserDm.fromJson(Map<String, dynamic> json)
    : name = json["name"] ?? '',
      id = json["id"] ?? '',
      email = json["email"] ?? '',
      favouriteEventsIds = List<String>.from(json["favouriteEventsIds"] ?? []),
      profileImageUrl = json["profileImageUrl"],
      createdAt =
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      lastLoginAt =
          json["lastLoginAt"] != null
              ? DateTime.parse(json["lastLoginAt"])
              : null;

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "email": email,
    "favouriteEventsIds": favouriteEventsIds,
    "profileImageUrl": profileImageUrl,
    "createdAt": createdAt?.toIso8601String(),
    "lastLoginAt": lastLoginAt?.toIso8601String(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserDm && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserDm(id: $id, name: $name, email: $email)';
  }
}
