import 'package:flutter/material.dart';
import 'package:charg_ev/components/booking_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:charg_ev/components/datetime_button.dart';
import 'package:intl/intl.dart';

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

    // fetch arguments passed from charger selection screen
    Charger charger = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BookingAppBar(charger: charger),
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
            Text(
              '${DateFormat('EEEE, dd-MM-yyyy').format(charger.startDateTime)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
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
                    DatetimeButton(displayTime: '11:00am',),
                    DatetimeButton(displayTime: '11:15am',),
                    DatetimeButton(displayTime: '11:30am',),
                    DatetimeButton(displayTime: '11:45am',),
                  ],
                ),
                SizedBox(height: size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatetimeButton(displayTime: '12:00pm',),
                    DatetimeButton(displayTime: '12:15pm',),
                    DatetimeButton(displayTime: '12:30pm',),
                    DatetimeButton(displayTime: '12:45pm',),
                  ],
                ),
                SizedBox(height: size.height * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatetimeButton(displayTime: '1:00pm',),
                    DatetimeButton(displayTime: '1:15pm',),
                    DatetimeButton(displayTime: '1:30pm',),
                    DatetimeButton(displayTime: '1:45pm',),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(size.width * 0.05, 0, size.width * 0.05, size.height * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: size.width,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/confirm_booking');
                      },
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.height * 0.01),
                      child: Text(
                        'CONFIRM SELECTION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
