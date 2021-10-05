import 'package:flutter/material.dart';
import 'package:charg_ev/services/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationAppBar extends StatefulWidget {
  const LocationAppBar({
    Key key,
    @required this.location,
    @required this.withCurrentLocation,
  }) : super(key: key);

  final String location;
  final bool withCurrentLocation;

  @override
  _LocationAppBarState createState() => _LocationAppBarState();
}

class _LocationAppBarState extends State<LocationAppBar> {
  String location = "loading";

  @override
  void initState() {
    super.initState();

    determineLastKnownPosition()
        .then((pos) => placemarkFromCoordinates(pos.latitude, pos.longitude))
        .then((placemark) {
          setState(() {
            location = placemark[0].street;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.fromLTRB(
          size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
          ),
          widget.withCurrentLocation? Text(
            "Current Location",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ): Container(),
          widget.withCurrentLocation? SizedBox(height: size.height * 0.01,): Container(),
          widget.withCurrentLocation 
            ? Text(
                location, 
                style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold)
              ) 
            : Text(
                widget.location, 
                style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold)
              ),
        ],
      ),
    );
  }
}
