import 'dart:async';
import 'package:charg_ev/components/location_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class LocationSelector extends StatefulWidget {
  final LatLng initialCoords;

  const LocationSelector({Key key, @required this.initialCoords})
      : super(key: key);

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  //controllers
  MapController mapController;

  //postal code
  List<Location> address;

  //map states
  StreamSubscription subscription;
  LatLng centerLatLng;
  List<Placemark> placemarks;
  double zoomLevel;

  void _setCenterLatLng(LatLng center) {
    setState(() {
      centerLatLng = center;
    });
  }

  void _setPlacemark(Future<List<Placemark>> x) {
    x.then((data) {
      setState(() {
        placemarks = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    mapController.onReady.then((_) {
      subscription = mapController.mapEventStream.listen((event) {
        if (event is MapEventMove) {
          _setCenterLatLng(event.center);
          setState(() {
            zoomLevel = event.zoom;
          });
        }
        if (event is MapEventMoveEnd) {
          _setPlacemark(placemarkFromCoordinates(
              centerLatLng.latitude, centerLatLng.longitude));
        }
      });
    });

    _setCenterLatLng(widget.initialCoords);

    _setPlacemark(placemarkFromCoordinates(
        centerLatLng.latitude, centerLatLng.longitude));
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Set precise location'),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 500,
              child: Stack(alignment: AlignmentDirectional.center, children: [
                FlutterMap(
                  mapController: mapController,
                  options: new MapOptions(
                      center: widget.initialCoords,
                      zoom: 15.0,
                      maxZoom: 18.4,
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                  ],
                ),
                Icon(Icons.location_pin),
              ]),
            ),
            Text(
                "Latitude: ${centerLatLng.latitude},\nLongitude: ${centerLatLng.longitude}"),
            placemarks != null
                ? Text("Street: ${placemarks[0].street}")
                : Text(""),
            placemarks != null
                ? Text("Postal Code: ${placemarks[0].postalCode}")
                : Text(""),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, centerLatLng);
                },
                child: Text('CONFIRM LOCATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )))
          ],
        )));
  }
}
