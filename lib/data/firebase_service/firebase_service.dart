import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/data/dm/category.dart';
import 'package:evently/data/dm/eventDM.dart';

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
        eventsCollection.orderBy("date").snapshots();
    var eventsList = eventDocSnapshotStream.map(
      (event) => event.docs.map((docSnapshot) => docSnapshot.data()).toList(),
    );

    yield* eventsList;
  }
}
