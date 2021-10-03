import 'package:flutter/material.dart';
import 'package:charg_ev/components/booking_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:intl/intl.dart';
import 'package:charg_ev/models/booking.dart' as model;

class Booking extends StatefulWidget {
  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  static List generateDisplayTime (Charger charger){
    List displayTimeDropdown = [];
    
    for (int i = 0; i < charger.duration; i++){
      displayTimeDropdown.add(charger.startDateTime.add(Duration(hours: i)));
    }

    return displayTimeDropdown;
  }

  static List generateDisplayDuration (Charger charger){
    List displayDurationDropdown = [];

    for (int i = 1; i <= charger.duration; i++){
      displayDurationDropdown.add(i.toString());
    }

    return displayDurationDropdown;
  }

  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    // fetch arguments passed from charger selection screen
    Charger charger = ModalRoute.of(context).settings.arguments;

    String selectedStartTime;
    String selectedDuration;

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
              'Start Time',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            DropdownButton(
              hint: selectedStartTime == null?
              Text("Select start time for booking"):
              Text(selectedStartTime),
              value: selectedStartTime,
              items: generateDisplayTime(charger)
                  .map((time) => new DropdownMenuItem(
                  value: DateFormat("HH:mm").format(time),
                  child: Text(DateFormat("HH:mm").format(time))
              )).toList(),
              onChanged: (selected){
                // setState(() {
                //   selectedStartTime = selected;
                // });
                selectedStartTime = selected;
              },
            ),
            SizedBox(height: size.height * 0.03,),
            Text(
              'Duration',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.02,),
            DropdownButton(
              hint: selectedDuration == null?
              Text("Select duration of booking"):
              Text(selectedDuration),
              value: selectedDuration,
              items: generateDisplayDuration(charger)
                  .map((duration) => new DropdownMenuItem(
                  value: duration,
                  child: Text(duration)
              )).toList(),
              onChanged: (selected){
                // setState(() {
                //   selectedDuration = selected;
                // });
                selectedDuration = selected;
              },
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
                      onPressed: () {
                        String date = DateFormat('yyyy-MM-dd').format(charger.startDateTime);
                        String dateAndTime = date + " " + selectedStartTime;
                        DateTime startTime = DateTime.parse(dateAndTime);

                        Navigator.pushReplacementNamed(
                            context, '/confirm_booking',
                            arguments: {
                              'booking': model.Booking(
                                  chargerId: charger.ownerUid,
                                  startTime: startTime,
                                  endTime: startTime.add(Duration(hours: int.parse(selectedDuration))),
                                  creationDate: DateTime.now(),
                                  price: charger.rate),
                              'charger': charger
                            });
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