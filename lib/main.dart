import 'package:charg_ev/screens/charger_category.dart';
import 'package:flutter/material.dart';
import 'package:charg_ev/screens/charger_selection.dart';
import 'package:charg_ev/screens/booking.dart';
import 'package:charg_ev/screens/confirm_booking.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/yay',
  routes: {
    '/': (context) => ChargerSelection(),
    '/booking': (context) => Booking(),
    '/confirm_booking': (context) => ConfirmBooking(),
    '/yay': (context) => ChargerCategory(),
  },
));