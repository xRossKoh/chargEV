// class for information on charging station

import 'package:flutter/material.dart';

class Charger {
  String ownerUid; //owner
  String nickname;
  String location;
  double rate;
  // int available;
  // int total;
  int wattage;
  int type;
  DateTime startDateTime;
  int duration;
  List<String> timeslots;

  Charger({
    this.ownerUid,
    this.nickname,
    this.location,
    this.rate,
    this.wattage,
    this.type,
    this.startDateTime,
    this.duration,
    this.timeslots,
  });

  void initializeTimeslots(){
    this.timeslots = new List(duration);
    for (int i = 0; i < duration; i++){
      timeslots[i] = "";
    }
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
