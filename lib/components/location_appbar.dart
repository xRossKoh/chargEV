import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {

    // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
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
          Text(
            widget.location,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
