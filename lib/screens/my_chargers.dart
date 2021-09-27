import 'package:charg_ev/components/app_drawer.dart';
import 'package:charg_ev/components/charger_card.dart';
import 'package:charg_ev/components/welcome_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:charg_ev/models/user_info.dart';
import 'package:charg_ev/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// List<Charger> testChargers = [
//   Charger(location: 'Greenfield Terrace', rate: 0.20, available: 2, total: 5, wattage: 10, type: 1),
//   Charger(location: 'Telok Kurau Lorong J', rate: 0.20, available: 2, total: 2, wattage: 7, type: 2),
//   Charger(location: 'Greenfield Lane', rate: 0.20, available: 3, total: 15, wattage: 10, type: 1),
//   Charger(location: '2 Frankel Avenue', rate: 0.20, available: 10, total: 15, wattage: 8, type: 2),
//   Charger(location: '256 East Coast Road', rate: 0.20, available: 3, total: 7, wattage: 7, type: 1),
//   Charger(location: '6 Simei Ave', rate: 0.20, available: 2, total: 2, wattage: 15, type: 2),
//   Charger(location: '36 Bedok Road', rate: 0.20, available: 6, total: 7, wattage: 8, type: 2),
//   Charger(location: '59 Pasir Ris Drive', rate: 0.20, available: 3, total: 7, wattage: 10, type: 1),
// ];

class MyChargers extends StatelessWidget {
  const MyChargers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInfo user = Provider.of<UserInfo>(context);

    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            WelcomeAppBar(user),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text('My Chargers',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300)),
                    ),
                    StreamBuilder<List<Charger>>(
                        stream: DatabaseService(uid: user.uid).myChargersList,
                        builder: (context, snapshot) {
                          List<Charger> chargers =
                              snapshot.hasData ? snapshot.data : [];
                              
                          //print(snapshot.error);
                          return Expanded(
                            child: ListView.builder(
                                itemCount:
                                    chargers.length, //testChargers.length,
                                itemBuilder: (context, index) {
                                  return ChargerCard(
                                      //testChargers[index]);
                                      charger: chargers[index], showNickname: false,);
                                }),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
