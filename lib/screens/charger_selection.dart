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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LocationAppBar(
              location: '5A Dunbar Walk',
              withCurrentLocation: true,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Flexible(
                child: StreamBuilder<List<Charger>>(
                    stream: _databaseService.allChargersList,
                    builder: (context, snapshot) {
                      List<Charger> chargers =
                          snapshot.hasData ? snapshot.data : [];

                      // print(snapshot.error);

                      List<Charger> availableChargers = chargers
                          .where((element) => !element.accepted)
                          .toList();

                      return availableChargers.length == 0
                          ? Container(
                            padding: EdgeInsets.fromLTRB(0, size.height*0.10, 0, 0),
                            constraints: BoxConstraints(maxWidth: size.width*0.8),
                              child: Text(
                                "There are no chargers available for booking.",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            )
                          : ListView.builder(
                              itemCount: availableChargers.length,
                              itemBuilder: (context, index) {
                                return ChargerCard(
                                    charger: availableChargers[index],
                                    showNickname: false);
                              });
                    })),
          ],
        ),
      ),
    );
  }
}
