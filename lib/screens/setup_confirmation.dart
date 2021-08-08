import 'package:flutter/material.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:intl/intl.dart';
import 'package:charg_ev/services/database.dart';

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
    DatabaseService _databaseService = new DatabaseService();

    // fetching charger data from previous charger set up page
    Charger charger = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.05, size.height * 0.03, size.width * 0.05, size.height * 0.03),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.electrical_services,
                            size: 20,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            '${charger.total}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            '|',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            '${charger.wattage}',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            'kWh',
                            style: TextStyle(
                              fontSize: 20,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 20,
                            color: Colors.green[800],
                          ),
                          SizedBox(width: size.width * 0.03),
                          Text(
                            '${charger.rate}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Text(
                            'SGD / kWh',
                            style: TextStyle(
                              color: Colors.grey[400],
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
                      Expanded(
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                                '${DateFormat('dd/MM/yyyy, kk:mm').format(charger.datetime)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
                              Text(
                                'Duration: ${charger.duration}hrs',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
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
                          Navigator.pop(context);
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
      ),
    );
  }
}
