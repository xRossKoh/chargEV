import 'package:charg_ev/components/app_drawer.dart';
import 'package:charg_ev/components/booking_tile.dart';
import 'package:charg_ev/components/welcome_appbar.dart';
import 'package:charg_ev/models/booking.dart';
import 'package:charg_ev/models/user_info.dart';
import 'package:charg_ev/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// List<Booking> testBookings = [
//   Booking(chargerId: '1', chargerLocationName: '5A Dunbar Walk', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.6, user: 'hello'),
//   Booking(chargerId: '2', chargerLocationName: '100 Sengkang Drive', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.2, user: 'hello'),
//   Booking(chargerId: '1', chargerLocationName: '5A Dunbar Walk', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.6, user: 'hello'),
//   Booking(chargerId: '2', chargerLocationName: '100 Sengkang Drive', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.2, user: 'hello'),
//   Booking(chargerId: '1', chargerLocationName: '5A Dunbar Walk', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.6, user: 'hello'),
//   Booking(chargerId: '2', chargerLocationName: '100 Sengkang Drive', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.2, user: 'hello'),
//   Booking(chargerId: '1', chargerLocationName: '5A Dunbar Walk', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.6, user: 'hello'),
//   Booking(chargerId: '2', chargerLocationName: '100 Sengkang Drive', startTime: DateTime.now(), endTime: DateTime.now(), price: 5.2, user: 'hello'),    
// ];

class MyBookings extends StatelessWidget {
  const MyBookings({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final UserInfo user = Provider.of<UserInfo>(context);

    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            WelcomeAppBar(user),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text('My Bookings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                    StreamBuilder<List<Booking>>(
                        stream: DatabaseService(uid: user.uid).bookingList,
                        builder: (context, snapshot) {
                          List<Booking> bookings =
                              snapshot.hasData ? snapshot.data : [];
            
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: bookings.length, //testBookings.length,
                                itemBuilder: (context, index) {
                                  return BookingTile( //booking: testBooking
                                    booking: bookings[index]
                                  
                                  );
                                }),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
