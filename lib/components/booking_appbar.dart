import 'package:flutter/material.dart';
import 'package:charg_ev/models/charger.dart';

class BookingAppBar extends StatefulWidget {
  const BookingAppBar({
    Key key,
    @required this.charger
  }) : super(key: key);

  final Charger charger;

  @override
  _BookingAppBarState createState() => _BookingAppBarState();
}

class _BookingAppBarState extends State<BookingAppBar> {
  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          Text(
            widget.charger.location,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0.5km away from you',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "SGD ${widget.charger.rate.toStringAsPrecision(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: size.width * 0.005,),
                        Text(
                          "/ kWh",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01,),
                    Text(
                      "${widget.charger.wattage} kW",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: widget.charger.type == 1? Image.asset('assets/Type 1.jpg',): Image.asset('assets/Type 2.jpg',),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

