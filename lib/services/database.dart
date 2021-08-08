import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:intl/intl.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference for userInfo
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userInfo');

  // add charger booking
  Future addBooking (Charger charger) async {
    return await userCollection.doc(this.uid).collection('booking').add({
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
  Future addCharger (Charger charger) async {
    return await userCollection.doc(this.uid).collection('charger').add({
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

}