import 'package:charg_ev/constants.dart';
import 'package:flutter/material.dart';
import 'package:charg_ev/components/location_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FieldValidators {
  static String stringValidator(String val) {
    return val.isEmpty ? 'This field cannot be empty' : null;
  }

  static String rateValidator(String val) {
    return val.isEmpty
        ? 'This field cannot be empty'
        : val.contains(',')
            ? 'Please enter a valid decimal rate'
            : null;
  }
}

class ChargerSetUp extends StatefulWidget {
  const ChargerSetUp({Key key}) : super(key: key);

  @override
  _ChargerSetUpState createState() => _ChargerSetUpState();
}

class _ChargerSetUpState extends State<ChargerSetUp> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate;
  TimeOfDay selectedTime;

  // // text editing controllers
  TextEditingController rateEditingController = new TextEditingController();
  TextEditingController totalEditingController = new TextEditingController();
  TextEditingController wattageEditingController = new TextEditingController();
  TextEditingController typeEditingController = new TextEditingController();
  TextEditingController durationEditingController = new TextEditingController();
  TextEditingController nicknameEditingController =
      new TextEditingController(text: 'My Charger');

  @override
  void dispose() {
    rateEditingController.dispose();
    totalEditingController.dispose();
    wattageEditingController.dispose();
    typeEditingController.dispose();
    durationEditingController.dispose();
    nicknameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // query size of screen
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            LocationAppBar(
              location: '5A Dunbar Walk',
              withCurrentLocation: false,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nicknameEditingController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Give a name for this charger'),
                      validator: (val) =>
                          val.isEmpty ? 'Give a name for this charger' : null,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: rateEditingController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Rental rate', suffixText: 'SGD/kWh'),
                      validator: FieldValidators.rateValidator,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: wattageEditingController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Wattage', suffixText: 'kWh'),
                      validator: FieldValidators.stringValidator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      // onChanged: (String val){
                      //   setState(() => newCharger.setWattage(int.parse(val)));
                      // },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: typeEditingController,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Charger type',
                      ),
                      validator: FieldValidators.stringValidator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      // onChanged: (String val){
                      //   setState(() => newCharger.setType(int.parse(val)));
                      // },
                    ),
                    SizedBox(height: size.height * 0.01),
                    FlatButton.icon(
                      onPressed: () async {
                        final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        selectedDate == null?
                        'Select Date':
                        DateFormat('dd-MM-yyyy').format(selectedDate),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      height: 50.0,
                      minWidth: 200.0,
                    ),
                    SizedBox(height: size.height * 0.01),
                    FlatButton.icon(
                      onPressed: () async {
                        final TimeOfDay picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        );
                        if (picked != null) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      icon: Icon(Icons.schedule),
                      label: Text(
                        selectedTime == null?
                        'Select Time':
                        selectedTime.toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      height: 50.0,
                      minWidth: 200.0,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: durationEditingController,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Rental Duration', suffixText: 'hr(s)'),
                      validator: FieldValidators.stringValidator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      // onChanged: (String val){
                      //   setState(() => newCharger.setDuration(int.parse(val)));
                      // },
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // await _databaseService.addCharger(newCharger);
                          dynamic result = await Navigator.pushNamed(
                              context, '/setup_confirmation',
                              arguments: Charger(
                                nickname: nicknameEditingController.text,
                                location: '5A Dunbar Walk',
                                rate: double.parse(rateEditingController.text),
                                wattage: int.parse(wattageEditingController.text),
                                type: int.parse(typeEditingController.text),
                                startDateTime: new DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute
                                ),
                                duration: int.parse(durationEditingController.text),
                              ));
                          if (result == true) {
                            Navigator.pushReplacementNamed(context, '/my_chargers');
                          } 
                        }
                      },
                      child: Text(
                        'Confirm charger',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
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
