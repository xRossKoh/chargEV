import 'package:charg_ev/models/user_info.dart';
import 'package:charg_ev/screens/authentication/authenticate.dart';
import 'package:charg_ev/screens/booking.dart';
import 'package:charg_ev/screens/charger_category.dart';
import 'package:charg_ev/screens/charger_selection.dart';
import 'package:charg_ev/screens/charger_setup.dart';
import 'package:charg_ev/screens/setup_confirmation.dart';
import 'package:charg_ev/screens/my_bookings.dart';
import 'package:charg_ev/screens/my_chargers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'confirm_booking.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInfo user = Provider.of<UserInfo>(context);

    //return authenticate or dashboard
    return user == null
        ? Authenticate()
        : MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (context) => ChargerCategory(),
              '/charger_selection': (context) => ChargerSelection(),
              '/booking': (context) => Booking(),
              '/confirm_booking': (context) => ConfirmBooking(),
              '/my_bookings': (context) => MyBookings(),
              '/my_chargers': (context) => MyChargers(),
              '/charger_setup': (context) => ChargerSetUp(),
              '/setup_confirmation': (context) => SetUpConfirmation(),
            });
  }
}
