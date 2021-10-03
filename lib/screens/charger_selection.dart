import 'package:flutter/material.dart';
import 'package:charg_ev/components/location_appbar.dart';
import 'package:charg_ev/components/charger_card.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:charg_ev/models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:charg_ev/services/database.dart';
import 'package:provider/provider.dart';

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

    // setting up database service
    final UserInfo user = Provider.of<UserInfo>(context);
    DatabaseService _databaseService = new DatabaseService(uid: user.uid);

    TextEditingController messageEditingController = new TextEditingController();

    // List<Charger> chargers = [
    //   Charger(location: 'Greenfield Terrace', rate: 0.20, wattage: 10, type: 1, startDateTime: DateTime.now()),
    //   Charger(location: 'Telok Kurau Lorong J', rate: 0.20, wattage: 7, type: 2, startDateTime: DateTime.now()),
    //   Charger(location: 'Greenfield Lane', rate: 0.20, wattage: 10, type: 1, startDateTime: DateTime.now()),
    //   Charger(location: '2 Frankel Avenue', rate: 0.20, wattage: 8, type: 2, startDateTime: DateTime.now()),
    //   Charger(location: '256 East Coast Road', rate: 0.20, wattage: 7, type: 1, startDateTime: DateTime.now()),
    //   Charger(location: '6 Simei Ave', rate: 0.20, wattage: 15, type: 2, startDateTime: DateTime.now()),
    //   Charger(location: '36 Bedok Road', rate: 0.20, wattage: 8, type: 2, startDateTime: DateTime.now()),
    //   Charger(location: '59 Pasir Ris Drive', rate: 0.20, wattage: 10, type: 1, startDateTime: DateTime.now()),
    // ];


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LocationAppBar(location: '5A Dunbar Walk', withCurrentLocation: true,),
            SizedBox(height: size.height * 0.03,),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.grey[300],
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(20),
            //       topRight: Radius.circular(20),
            //       bottomLeft: Radius.circular(20),
            //       bottomRight: Radius.circular(20),
            //     ),
            //   ),
            //   margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
            //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 0),
            //   child: TextField(
            //     controller: messageEditingController,
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       hintText: 'Search',
            //     ),
            //   ),
            // ),
            Flexible(
              child: StreamBuilder<List<Charger>>(
                stream: _databaseService.allChargersList,
                    builder: (context, snapshot) {
                      List<Charger> chargers =
                          snapshot.hasData ? snapshot.data : [];

                      // print(snapshot.error);

                  return ListView.builder(
                      itemCount: chargers.length,
                      itemBuilder: (context, index){
                        return ChargerCard(charger: chargers[index], showNickname: false,);
                      }
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}
