import 'package:flutter/material.dart';
import 'package:charg_ev/components/booking_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:flutter/painting.dart';
import 'package:charg_ev/services/database.dart';
import 'package:charg_ev/models/booking.dart';
import 'package:charg_ev/models/user_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

    // fetching booking data from previous booking selection page. data is
    // passed in as a Map<String, Object>, where the keys are "booking" and
    // "charger" respectively.
    final Charger charger = ModalRoute.of(context).settings.arguments;

    // setting up database service
    final UserInfo user = Provider.of<UserInfo>(context);
    DatabaseService _databaseService = new DatabaseService(uid: user.uid);

    DateTime startTime = charger.startDateTime;
    DateTime endTime = charger.startDateTime.add(Duration(hours: charger.duration));

    Booking booking = new Booking(
      chargerId: charger.chargerId,
      startTime: startTime,
      endTime: endTime,
      creationDate: DateTime.now(),
      price: 1
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingAppBar(charger: charger),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
              child: Text(
                'Selected time slot',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
              child: Text(
                'Date',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.02, size.width * 0.05, 0),
              child: Text(
                DateFormat('EEEE, dd-MM-yyyy').format(charger.startDateTime),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
              child: Text(
                'Time',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.02, size.width * 0.05, 0),
              child: Text(
                "${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Estimated Total Cost',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: size.height * 0.02,),
                    Text(
                      'SGD 1.00',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
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
                      onPressed: () async {
                        await _databaseService.addBooking(booking);
                        await _databaseService.updateCharger(user.uid);
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.height * 0.01),
                      child: Text(
                        'CONFIRM BOOKING',
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
