import 'package:charg_ev/constants.dart';
import 'package:charg_ev/screens/location_selector.dart';
import 'package:flutter/material.dart';
import 'package:charg_ev/components/location_appbar.dart';
import 'package:charg_ev/models/charger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

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

  //TODO ensure postal codes are integers only
  static String postalCodeValidator(String val) {
    return val.length != 6 ? 'Please input a valid postal code' : null;
  }
}

class ChargerSetUp extends StatefulWidget {
  const ChargerSetUp({Key key}) : super(key: key);

  @override
  _ChargerSetUpState createState() => _ChargerSetUpState();
}

class _ChargerSetUpState extends State<ChargerSetUp> {
  final _formKey = GlobalKey<FormState>();

  bool isAddressSet = false;
  LatLng coords;

  // // text editing controllers
  TextEditingController rateEditingController = new TextEditingController();
  TextEditingController totalEditingController = new TextEditingController();
  TextEditingController wattageEditingController = new TextEditingController();
  TextEditingController typeEditingController = new TextEditingController();
  TextEditingController durationEditingController = new TextEditingController();
  TextEditingController nicknameEditingController =
      new TextEditingController(text: 'My Charger');
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  MapController displayMapController = MapController();

  @override
  void initState() {
    super.initState();
    postalCodeController.addListener(() {
      if (postalCodeController.text.length == 6 &&
          addressEditingController.text.isEmpty) {
        locationFromAddress(postalCodeController.text).then((data) {
          setState(() {
            coords = LatLng(data[0]?.latitude, data[0]?.longitude);
          });
          return placemarkFromCoordinates(
              data[0]?.latitude, data[0]?.longitude);
        }).then((placemarks) {
          String street = placemarks[0].street;
          addressEditingController.value = TextEditingValue(text: street);
          setState(() {
            isAddressSet = true;
          });
        }).catchError((error) {
          print(error);
          //TODO handle this error in validator
          if (error is NoResultFoundException) {
            postalCodeController.value = TextEditingValue.empty;
          }
        });
      }
    });
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              LocationAppBar(
                location: 'Setup a New Charger',
                withCurrentLocation: false,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(size.width * 0.05,
                    size.height * 0.03, size.width * 0.05, 0),
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
                          controller: postalCodeController,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Postal Code'),
                          validator: FieldValidators.postalCodeValidator),
                      if (isAddressSet) ...[
                        SizedBox(height: size.height * 0.01),
                        TextFormField(
                          controller: addressEditingController,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Address'),
                          //validator: FieldValidators.postalCodeValidator
                        ),
                        SizedBox(height: size.height * 0.01),
                        Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: FlutterMap(
                                    mapController: displayMapController,
                                    options: MapOptions(
                                        center: coords,
                                        zoom: 16.5,
                                        interactiveFlags: InteractiveFlag.none),
                                    layers: [
                                      new TileLayerOptions(
                                          urlTemplate:
                                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                          subdomains: ['a', 'b', 'c']),
                                    ],
                                  )),
                              Icon(Icons.location_pin),
                            ]),
                        ElevatedButton(
                          child: Text("Set Precise Location"),
                          onPressed: () async {
                            LatLng targetCoordinate = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationSelector(
                                        initialCoords:
                                            displayMapController.center)));
                            targetCoordinate ??= coords;
                            displayMapController.move(
                                targetCoordinate, displayMapController.zoom);
                          },
                        )
                      ],
                      SizedBox(height: size.height * 0.01),
                      TextFormField(
                        controller: rateEditingController,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Rental rate', suffixText: 'SGD/kWh'),
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
                        decoration: textInputDecoration.copyWith(
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
                                  location: addressEditingController.text,
                                  rate:
                                      double.parse(rateEditingController.text),
                                  available:
                                      int.parse(totalEditingController.text),
                                  total: int.parse(totalEditingController.text),
                                  wattage:
                                      int.parse(wattageEditingController.text),
                                  type: int.parse(typeEditingController.text),
                                  datetime: DateTime.now(),
                                  duration:
                                      int.parse(durationEditingController.text),
                                ));
                            if (result == true) {
                              Navigator.pushReplacementNamed(
                                  context, '/my_chargers');
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
      ),
    );
  }
}
