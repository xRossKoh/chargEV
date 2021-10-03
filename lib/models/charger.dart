// class for information on charging station

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';


class Charger {
  String ownerUid; //owner
  String chargerId;
  String nickname;
  String location;
  GeoPoint coordinates;
  double rate;
  // int available;
  // int total;
  int wattage;
  int type;
  DateTime startDateTime;
  int duration;

  Charger({
    this.ownerUid,
    this.chargerId,
    this.nickname,
    this.location,
    this.coordinates,
    this.rate,
    this.wattage,
    this.type,
    this.startDateTime,
    this.duration,
  });

  // void initializeTimeslots() {
  //   this.timeslots = new List(duration);
  //   for (int i = 0; i < duration; i++) {
  //     timeslots[i] = "";
  //   }
  // }

  static GeoPoint latLngToGeoPoint(LatLng coords) {
    return new GeoPoint(coords.latitude, coords.longitude);
  }

// void setLocation (String val){
  //   this.location = val;
  // }
  //
  // void setRate (double val){
  //   this.rate = val;
  // }
  //
  // void setTotal (int val){
  //   this.total = val;
  // }
  //
  // void setWattage (int val){
  //   this.wattage = val;
  // }
  //
  // void setType (int val){
  //   this.type = val;
  // }
  //
  // void setDate (DateTime val){
  //   this.datetime = val;
  // }
  //
  // void setDuration (int val){
  //   this.duration = duration;
  // }
  //
  // DateTime getDate (){
  //   return this.datetime;
  // }

}
