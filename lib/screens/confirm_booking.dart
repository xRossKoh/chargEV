import 'package:flutter/material.dart';
import 'package:charg_ev/components/booking_appbar.dart';
import 'package:charg_ev/models/charger.dart';

// TODO consult team on whether need the current location text for this page, can possibly use the same app bar as in booking

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({Key key}) : super(key: key);

  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BookingAppBar(charger: Charger(location: 'Greenfield Terrace', rate: 0.20, available: 2, total: 5, wattage: 10, type: 1),),
            SizedBox(height: size.height * 0.03,),
            Text(
              'Selected time slots',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            Text(
              'Date',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
