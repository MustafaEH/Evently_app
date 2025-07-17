import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/data/dm/category.dart';
import 'package:evently/data/dm/eventDM.dart';
import 'package:evently/data/dm/userDM.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static CollectionReference<EventDM> getEventsCollection() {
    FirebaseFirestore dp = FirebaseFirestore.instance;
    CollectionReference<EventDM> eventsCollection = dp
        .collection("events")
        .withConverter<EventDM>(
          fromFirestore:
              (snapshot, options) => EventDM.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );

    return eventsCollection;
  }

  static Future<void> addEventToFireStore(EventDM event) async {
    try {
      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      DocumentReference<EventDM> eventDoc = eventsCollection.doc();

      // Set creation metadata
      final eventWithMetadata = event.copyWith(
        id: eventDoc.id,
        createdBy: UserDm.currentUser?.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await eventDoc.set(eventWithMetadata);
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  static Future<void> updateEvent(EventDM event) async {
    try {
      if (event.id == null) {
        throw Exception('Event ID is required for update');
      }

      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      final eventWithMetadata = event.copyWith(updatedAt: DateTime.now());

      await eventsCollection.doc(event.id).update(eventWithMetadata.toJson());
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  static Future<void> deleteEvent(String eventId) async {
    try {
      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      await eventsCollection.doc(eventId).delete();
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  static Future<List<EventDM>> getEventsFromFireStore() async {
    try {
      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      QuerySnapshot<EventDM> querySnapshot = await eventsCollection.get();
      List<EventDM> events =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      return events;
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }

  static Future<List<EventDM>> getEvents() async {
    try {
      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      var documentsSnapshots = await eventsCollection.get();
      return documentsSnapshots.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }

  static Stream<List<EventDM>> getEventsRealTime(CategoryDM category) async* {
    try {
      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      Stream<QuerySnapshot<EventDM>> eventDocSnapshotStream =
          eventsCollection
              .orderBy("date")
              .where(
                "categoryId",
                isEqualTo: category.id == "1" ? null : category.id,
              )
              .snapshots();
      var eventsList = eventDocSnapshotStream.map(
        (event) => event.docs.map((docSnapshot) => docSnapshot.data()).toList(),
      );

      yield* eventsList;
    } catch (e) {
      yield [];
    }
  }

  static Stream<List<EventDM>> getFavoriteEventsRealTime() async* {
    try {
      if (UserDm.currentUser == null) {
        yield [];
        return;
      }

      CollectionReference<EventDM> eventsCollection = getEventsCollection();
      List<String> favoriteIds = UserDm.currentUser!.favouriteEventsIds;

      if (favoriteIds.isEmpty) {
        yield [];
        return;
      }

      Stream<QuerySnapshot<EventDM>> eventDocSnapshotStream =
          eventsCollection
              .where(FieldPath.documentId, whereIn: favoriteIds)
              .orderBy("date")
              .snapshots();

      var eventsList = eventDocSnapshotStream.map(
        (event) => event.docs.map((docSnapshot) => docSnapshot.data()).toList(),
      );

      yield* eventsList;
    } catch (e) {
      yield [];
    }
  }

  static Future<void> addEventToFav(String eventId) async {
    try {
      if (UserDm.currentUser == null) {
        throw Exception('User not logged in');
      }

      UserDm currentUser = UserDm.currentUser!;
      if (!currentUser.favouriteEventsIds.contains(eventId)) {
        currentUser.favouriteEventsIds.add(eventId);
        var usersCollection = getUserCollection();
        await usersCollection.doc(currentUser.id).set(currentUser);
      }
    } catch (e) {
      throw Exception('Failed to add event to favorites: $e');
    }
  }

  static Future<void> removeEventFromFav(String eventId) async {
    try {
      if (UserDm.currentUser == null) {
        throw Exception('User not logged in');
      }

      UserDm currentUser = UserDm.currentUser!;
      currentUser.favouriteEventsIds.remove(eventId);
      var usersCollection = getUserCollection();
      await usersCollection.doc(currentUser.id).set(currentUser);
    } catch (e) {
      throw Exception('Failed to remove event from favorites: $e');
    }
  }

  static Future<void> registerUser({
    required String emailAddress,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      UserDm user = UserDm(
        name: name,
        id: credential.user!.uid,
        email: emailAddress,
        favouriteEventsIds: [],
      );

      await addUserToFireStore(user);
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  static Future<void> login(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      UserDm userDm = await getUserFromFireStore(credential.user!.uid);
      UserDm.currentUser = userDm;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      UserDm.currentUser = null;
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  static Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }

  static getUserCollection() {
    FirebaseFirestore dp = FirebaseFirestore.instance;
    CollectionReference<UserDm> userCollection = dp
        .collection("users")
        .withConverter<UserDm>(
          fromFirestore:
              (snapshot, options) => UserDm.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
    return userCollection;
  }

  static Future<void> addUserToFireStore(UserDm user) async {
    try {
      var userCollection = getUserCollection();
      await userCollection.doc(user.id).set(user);
    } catch (e) {
      throw Exception('Failed to add user to Firestore: $e');
    }
  }

  static Future<UserDm> getUserFromFireStore(String uid) async {
    try {
      var userCollection = getUserCollection();
      var userDoc = await userCollection.doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      return userDoc.data()!;
    } catch (e) {
      throw Exception('Failed to get user from Firestore: $e');
    }
  }

  static Future<void> updateUserProfile({String? name, String? email}) async {
    try {
      if (UserDm.currentUser == null) {
        throw Exception('User not logged in');
      }

      UserDm currentUser = UserDm.currentUser!;
      final updatedUser = UserDm(
        id: currentUser.id,
        name: name ?? currentUser.name,
        email: email ?? currentUser.email,
        favouriteEventsIds: currentUser.favouriteEventsIds,
      );

      await addUserToFireStore(updatedUser);
      UserDm.currentUser = updatedUser;
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }
}
