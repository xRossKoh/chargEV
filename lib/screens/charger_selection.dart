import 'package:flutter/material.dart';
import 'package:charg_ev/components/location_appbar.dart';
import 'package:charg_ev/components/charger_card.dart';
import 'package:charg_ev/models/charger.dart';

// TODO complete search function

class ChargerSelection extends StatefulWidget {
  const ChargerSelection({Key key}) : super(key: key);

  @override
  _ChargerSelectionState createState() => _ChargerSelectionState();
}

class _ChargerSelectionState extends State<ChargerSelection> {
  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    TextEditingController messageEditingController = new TextEditingController();

    List<Charger> chargers = [
      Charger(location: 'Greenfield Terrace', rate: 0.20, available: 2, total: 5, wattage: 10, type: 1, datetime: DateTime.now()),
      Charger(location: 'Telok Kurau Lorong J', rate: 0.20, available: 2, total: 2, wattage: 7, type: 2, datetime: DateTime.now()),
      Charger(location: 'Greenfield Lane', rate: 0.20, available: 3, total: 15, wattage: 10, type: 1, datetime: DateTime.now()),
      Charger(location: '2 Frankel Avenue', rate: 0.20, available: 10, total: 15, wattage: 8, type: 2, datetime: DateTime.now()),
      Charger(location: '256 East Coast Road', rate: 0.20, available: 3, total: 7, wattage: 7, type: 1, datetime: DateTime.now()),
      Charger(location: '6 Simei Ave', rate: 0.20, available: 2, total: 2, wattage: 15, type: 2, datetime: DateTime.now()),
      Charger(location: '36 Bedok Road', rate: 0.20, available: 6, total: 7, wattage: 8, type: 2, datetime: DateTime.now()),
      Charger(location: '59 Pasir Ris Drive', rate: 0.20, available: 3, total: 7, wattage: 10, type: 1, datetime: DateTime.now()),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LocationAppBar(location: '5A Dunbar Walk', withCurrentLocation: true,),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 0),
              child: TextField(
                controller: messageEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: chargers.length,
                itemBuilder: (context, index){
                  return ChargerCard(charger: chargers[index],);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
