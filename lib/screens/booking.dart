import 'package:flutter/material.dart';
import 'package:charg_ev/components/booking_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:charg_ev/components/datetime_button.dart';

// TODO make dates and times dynamic

class Booking extends StatefulWidget {
  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
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
              'Date',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DatetimeButton(displayDate: true,),
                DatetimeButton(displayDate: true,),
                DatetimeButton(displayDate: true,),
                DatetimeButton(displayDate: true,),
              ],
            ),
            SizedBox(height: size.height * 0.03,),
            Text(
              'Time',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                  ],
                ),
                SizedBox(height: size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                  ],
                ),
                SizedBox(height: size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                    DatetimeButton(displayDate: false,),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
