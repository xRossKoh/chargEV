import 'package:charg_ev/models/charger.dart';
import 'package:flutter/material.dart';

class MyChargerTile extends StatelessWidget {
  const MyChargerTile({Key key, this.charger}) : super(key: key);

  final Charger charger;

  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: InkWell(
        onTap: (){},
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
                    charger.nickname,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,

                    ),
                  ),
                  Text(
                    charger.location,
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
                        "SGD ${charger.rate.toStringAsPrecision(2)}",
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
                    "${charger.available} / ${charger.total} chargers available (${charger.wattage} kW)",
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
              child: charger.type == 1? Image.asset('assets/Type 1.jpg',): Image.asset('assets/Type 2.jpg',),
            ),
          ],
        ),
      ),
    );
  }
}
