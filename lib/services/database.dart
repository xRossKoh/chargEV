import 'package:charg_ev/models/booking.dart';
import 'package:charg_ev/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charg_ev/models/charger.dart';

class DatabaseService {
  final String uid;
  final String chargerId;
  DatabaseService({this.uid, this.chargerId});

  /// Collection reference for user info
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userInfo');

  /// Collection reference for all chargers
  final CollectionReference chargerCollection =
      FirebaseFirestore.instance.collection('chargers');

  /// Adds user's new charger to database
  Future addCharger(Charger charger) async {
    return await chargerCollection.add({
      'ownerUid': uid,
      'nickname': charger.nickname,
      'location': charger.location,
      'coordinates': charger.coordinates,
      'rate': charger.rate,
      'wattage': charger.wattage,
      'type': charger.type,
      'startDateTime': charger.startDateTime,
      'duration': charger.duration,
      'accepted': charger.accepted,
      'acceptedUid': charger.acceptedUid
    });
  }

  Future updateCharger(String uid) async{
    return await chargerCollection.doc(chargerId).update({
      "accepted": true,
      "acceptedUid": uid
    });
  }

  /// Adds user's new booking to database
  Future addBooking(Booking booking) async {
    return await userCollection.doc(uid)
        .collection('bookings').add({
        'chargerId': booking.chargerId,
        'startTime': booking.startTime,
        'endTime': booking.endTime,
        'price': booking.price,
        'creationDate': booking.creationDate
    });
  }

  /// Adds display name of new user to database
  Future addUserInfo(UserInfo userInfo) async {
    return await userCollection.doc(uid).set({
      'displayName': userInfo.displayName,
    }, SetOptions(merge: true));
  }

  /// Gets user's uid and display name from database
  Future<UserInfo> get userInfo async {
    String displayName = await userCollection
        .doc(uid)
        .get()
        .then((doc) => doc.get('displayName'))
        .catchError((onError) => null);

    return displayName == null
        ? UserInfo(uid: uid)
        : UserInfo(uid: uid, displayName: displayName);
  }

  /// Gets list of all chargers from database
  Stream<List<Charger>> get allChargersList {
    return chargerCollection
        .where("ownerUid", isNotEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshotToChargersList(snapshot));
  }

  /// Gets list of user's chargers from database
  Stream<List<Charger>> get myChargersList {
    return chargerCollection
        .where('ownerUid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshotToChargersList(snapshot));
  }

  /// Gets list of user's bookings from database
  Stream<List<Booking>> get myBookingsList {
    return userCollection
        .doc(uid)
        .collection('bookings')
        .snapshots() //Stream<QuerySnapShot> => Stream<List<Docs>> => Stream<List<Booking>>
        .map((snapshot) => snapshotToMyBookingsList(snapshot));
  }

  /// Utility function to convert database snapshot to Booking instance
  List<Booking> snapshotToMyBookingsList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Booking(
            chargerId: doc.get('chargerId'),
            startTime: doc.get('startTime'),
            endTime: doc.get('endTime'),
            creationDate: doc.get('creationDate'),
            price: doc.get('price')
          ))
        .toList();
  }

  List<Charger> snapshotToChargersList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Charger(
              ownerUid: doc.get('ownerUid'),
              chargerId: doc.id,
              nickname: doc.get('nickname') ?? 'My Charger',
              location: doc.get('location'),
              coordinates: doc.get('coordinates'),
              rate: doc.get('rate'),
              type: doc.get('type'),
              wattage: doc.get('wattage'),
              startDateTime: DateTime.parse(doc.get("startDateTime").toDate().toString()),
              duration: doc.get('duration'),
              accepted: doc.get('accepted'),
              acceptedUid: doc.get('acceptedUid')
            ))
        .toList();
  }
}
