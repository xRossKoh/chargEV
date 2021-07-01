import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:flutter/services.dart';

class ChargerCard extends StatefulWidget {
  const ChargerCard({
    Key key,
    @required this.charger,
  }) : super(key: key);

  final Charger charger;

  @override
  _ChargerCardState createState() => _ChargerCardState();
}

class _ChargerCardState extends State<ChargerCard> {
  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.all(size.width * 0.05),
      child: FlatButton(
        onPressed: (){
          Navigator.pushNamed(context, '/booking', arguments: widget.charger);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.charger.location,
                    style: TextStyle(
                      fontSize: 15,
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
                  Text(
                    "${widget.charger.available} / ${widget.charger.total} chargers available (${widget.charger.wattage} kW)",
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
      ),
    );
  }
}
