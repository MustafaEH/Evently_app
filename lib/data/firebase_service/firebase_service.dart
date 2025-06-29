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

  static addEventToFireStore(EventDM event) async {
    CollectionReference<EventDM> eventsCollection = getEventsCollection();

    DocumentReference<EventDM> eventDoc = eventsCollection.doc();
    event.id = eventDoc.id;
    eventDoc.set(event);
  }

  static getEventsFromFireStore() async {
    CollectionReference<EventDM> eventsCollection = getEventsCollection();
    QuerySnapshot<EventDM> querySnapshot = await eventsCollection.get();
    List<EventDM> events = querySnapshot.docs.map((doc) => doc.data()).toList();
    return events;
  }

  static Future<List<EventDM>> getEvents() async {
    CollectionReference<EventDM> eventsCollection = getEventsCollection();
    var documentsSnapshots = await eventsCollection.get();
    // documentsSnapshots.docs.map((doc) => doc.data());
    return documentsSnapshots.docs.map((doc) => doc.data()).toList();
  }

  static Stream<List<EventDM>> getEventsRealTime(CategoryDM category) async* {
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
  }

  static Future<void> addEventToFav(String eventId) {
    UserDm currentUser = UserDm.currentUser!;
    currentUser.favouriteEventsIds.add(eventId);
    var usersCollection = getUserCollection();
    return usersCollection.doc(currentUser.id).set(currentUser);
  }

  static Future<void> registerUser({
    required String emailAddress,
    required String password,
    required String name,
  }) async {
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
    addUserToFireStore(user);
  }

  static Future<void> login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    UserDm userDm = await getUserFromFireStore(credential.user!.uid);
    UserDm.currentUser = userDm;
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

  static Future<void> addUserToFireStore(UserDm user) {
    var userCollection = getUserCollection();
    return userCollection.doc(user.id).set(user);
  }

  static Future<UserDm> getUserFromFireStore(String uid) async {
    var userCollection = getUserCollection();
    var userDoc = await userCollection.doc(uid).get();
    return userDoc.data()!;
  }
}
