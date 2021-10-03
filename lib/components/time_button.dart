import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeButton extends StatefulWidget {
  const TimeButton({
    Key key,
    @required this.displayTime,
    this.booked
  }) : super(key: key);

  final DateTime displayTime;
  final bool booked;

  @override
  _TimeButtonState createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {

  // bool to keep track of whether button has been selected
  bool selected = false;

  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.1),
      // padding: ,
      decoration: BoxDecoration(
        color: widget.booked? Colors.red: (selected? Colors.lightGreenAccent: Colors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: FlatButton(
        onPressed: widget.booked? null: (){
          setState(() {
            selected = !selected;
          });

        },
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.height * 0.01),
        child: Text(
          DateFormat("HH:mm").format(widget.displayTime),
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

