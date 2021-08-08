import 'package:flutter/material.dart';
import 'package:charg_ev/components/location_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FieldValidators{
  static String stringValidator(String val){
    return val.isEmpty? 'This field cannot be empty': null;
  }

  static String rateValidator(String val){
    return val.isEmpty? 'This field cannot be empty'
        : val.contains(',')? 'Please enter a valid decimal rate': null;
  }
}

class ChargerSetUp extends StatefulWidget {
  const ChargerSetUp({Key key}) : super(key: key);

  @override
  _ChargerSetUpState createState() => _ChargerSetUpState();
}

class _ChargerSetUpState extends State<ChargerSetUp> {

  final _formKey = GlobalKey<FormState>();

  // // text editing controllers
  TextEditingController rateEditingController = new TextEditingController();
  TextEditingController totalEditingController = new TextEditingController();
  TextEditingController wattageEditingController = new TextEditingController();
  TextEditingController typeEditingController = new TextEditingController();
  TextEditingController durationEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    // query size of screen
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            LocationAppBar(location: '5A Dunbar Walk', withCurrentLocation: false,),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: rateEditingController,
                      decoration: InputDecoration(
                        hintText: 'Rental rate',
                        suffixText: 'SGD/kWh'
                      ),
                      validator: FieldValidators.rateValidator,
                      keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   WhitelistingTextInputFormatter.digitsOnly
                      // ],
                      // onChanged: (String val){
                      //   setState(() => newCharger.setRate(double.parse(val)));
                      // },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: totalEditingController,
                      decoration: InputDecoration(
                        hintText: 'Number of available chargers',
                      ),
                      validator: FieldValidators.stringValidator,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      // onChanged: (String val){
                      //   setState(() => newCharger.setTotal(int.parse(val)));
                      // },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: wattageEditingController,
                      decoration: InputDecoration(
                        hintText: 'Wattage',
                        suffixText: 'kWh'
                      ),
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
                      decoration: InputDecoration(
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
                          lastDate: DateTime(2030)
                        );
                        // if (picked != null) {
                        //   setState(() => newCharger.setDate(picked));
                        // }
                      },
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        'Select Date',
                        // newCharger.getDate() == null? 'Select date'
                        //     : DateFormat('dd-MM-yyyy').format(newCharger.getDate()).toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      height: 50.0,
                      minWidth: 200.0,
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      controller: durationEditingController,
                      decoration: InputDecoration(
                        hintText: 'Rental Duration',
                        suffixText: 'hr(s)'
                      ),
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // await _databaseService.addCharger(newCharger);
                          Navigator.pushNamed(context, '/setup_confirmation',
                              arguments: Charger(
                                location: '5A Dunbar Walk',
                                rate: double.parse(rateEditingController.text),
                                available: int.parse(totalEditingController.text),
                                total: int.parse(totalEditingController.text),
                                wattage: int.parse(wattageEditingController.text),
                                type: int.parse(typeEditingController.text),
                                datetime: DateTime.now(),
                                duration: int.parse(durationEditingController.text),
                              ));
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
