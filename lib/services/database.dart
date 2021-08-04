import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:intl/intl.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // collection reference for userInfo
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('UserInfo');

  // add charger booking
  Future addChargerBooking (Charger charger, DateTime datetime) async {
    return await userCollection.doc(uid).collection('chargerBooking').add({
      'location': charger.location,
      'rate': charger.rate,
      'available': charger.available,
      'total': charger.total,
      'wattage': charger.wattage,
      'type': charger.type,
      'date': DateFormat('dd-MM-yyyy').format(datetime),
      'time': DateFormat('kk:mm'),
    });
  }

  // add charger
  Future addCharger (Charger charger, DateTime datetime, int duration) async {
    return await userCollection.doc(uid).collection('chargerLoaner').add({
      'location': charger.location,
      'rate': charger.rate,
      'available': charger.available,
      'total': charger.total,
      'wattage': charger.wattage,
      'type': charger.type,
      'date': DateFormat('dd-MM-yyyy').format(datetime),
      'time': DateFormat('kk:mm'),
      'duration': duration,
    });
  }

}