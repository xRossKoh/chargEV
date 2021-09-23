import 'package:charg_ev/models/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:intl/intl.dart';
import 'package:charg_ev/services/database.dart';
import 'package:provider/provider.dart';

class SetUpConfirmation extends StatefulWidget {
  const SetUpConfirmation({Key key}) : super(key: key);

  @override
  _SetUpConfirmationState createState() => _SetUpConfirmationState();
}

class _SetUpConfirmationState extends State<SetUpConfirmation> {
  @override
  Widget build(BuildContext context) {

    // query size of screen
    Size size = MediaQuery.of(context).size;

    // setting up database service
    final UserInfo user = Provider.of<UserInfo>(context);
    DatabaseService _databaseService = new DatabaseService(uid: user.uid);

    // fetching charger data from previous charger set up page
    Charger charger = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.03),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.03),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.lightBlue,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 8),
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red[200],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      '${charger.location}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: size.height * 0.01),
                    // Number of chargers and wattage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Icon(
                        //   Icons.electrical_services,
                        //   size: 20,
                        // ),
                        // SizedBox(width: size.width * 0.02),
                        // Text(
                        //   '${charger.total}',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 20,
                        //   ),
                        // ),
                        // SizedBox(width: size.width * 0.02),
                        // Text(
                        //   '|',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold
                        //   ),
                        // ),
                        // SizedBox(width: size.width * 0.02),
                        Text(
                          '${charger.wattage}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          'kWh',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[500],
                          ),
                        ),
                        //TODO can possibly add a fast/slow display
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: size.height * 0.01),
                    // rate
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 20,
                          color: Colors.green[800],
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          charger.rate.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          'SGD / kWh',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'Type ${charger.type}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            charger.type == 1? 'assets/Type 1.jpg': 'assets/Type 2.jpg',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01, vertical: size.height * 0.01),
                      child: Column(
                        children: [
                          Text(
                            '${DateFormat('dd/MM/yyyy, kk:mm').format(charger.date)}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            'Duration: ${charger.duration} hr(s)',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                      onPressed: () async {
                        await _databaseService.addCharger(charger);
                        Navigator.pop(context, true);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: size.height * 0.01),
                      child: Text(
                        'CONFIRM CHARGER SETUP',
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
