import 'package:charg_ev/models/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference for userInfo
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userInfo');


  // add charger booking
  Future addChargerBooking(Charger charger, DateTime datetime) async {
    return await userCollection.doc(uid).collection('chargerBooking').add({

      'location': charger.location,
      'rate': charger.rate,
      'available': charger.available,
      'total': charger.total,
      'wattage': charger.wattage,
      'type': charger.type,
      'date': DateFormat('dd-MM-yyyy').format(charger.datetime),
      'time': DateFormat('kk:mm').format(charger.datetime),
      'duration': charger.duration,
    });
  }

  // add charger for booking
  Future addCharger(Charger charger) async {
    return await userCollection.doc(this.uid).collection('chargers').add({
      'location': charger.location,
      'rate': charger.rate,
      'available': charger.available,
      'total': charger.total,
      'wattage': charger.wattage,
      'type': charger.type,
      'date': DateFormat('dd-MM-yyyy').format(charger.datetime),
      'time': DateFormat('kk:mm').format(charger.datetime),
      'duration': charger.duration,
    });
  }

  //get List of Chargers
  Stream<List<Charger>> get chargerList {
    return userCollection.doc(uid).collection('chargers').snapshots()
        .map((snapshot) => snapshotToChargerList(snapshot));
  }

  //get List of Bookings
  Stream<List<Booking>> get bookingList {
    return userCollection
        .doc(uid)
        .collection('chargerBookings')
        .snapshots() //Stream<QuerySnapShot> => Stream<List<Docs>> => Stream<List<Booking>>
        .map((snapshot) => snapshotToBookingsList(snapshot));
  }

  //utility functions
  List<Booking> snapshotToBookingsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Booking(
        chargerId: doc.get('chargerId'),
        startTime: doc.get('startTime'),
        endTime: doc.get('endTime'),
        user: uid)).toList();
  }

  List<Charger> snapshotToChargerList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Charger(
          location: doc.get('location'),
          rate: doc.get('rate'),
          type: doc.get('type'),
          wattage: doc.get('wattage'),
          total: doc.get('total'),
          available: doc.get('available'),
        )).toList();
  }
}
