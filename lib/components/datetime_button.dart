import 'package:flutter/material.dart';

class DatetimeButton extends StatefulWidget {
  const DatetimeButton({
    Key key,
    @required this.displayDate,
  }) : super(key: key);

  final bool displayDate;

  @override
  _DatetimeButtonState createState() => _DatetimeButtonState();
}

class _DatetimeButtonState extends State<DatetimeButton> {

  // bool to keep track of whether button has been selected
  bool selected = false;

  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: selected? Colors.lightGreenAccent: Colors.white,
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
        onPressed: (){
          setState(() {
            selected = !selected;
          });
        },
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.height * 0.01),
        child: widget.displayDate? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sat',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.005,),
            Text(
              '26 Jun',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ): Text(
          '11.15am',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
