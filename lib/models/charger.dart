// class for information on charging station

class Charger{

  String location;
  double rate;
  int available;
  int total;
  int wattage;
  int type;
  DateTime datetime;
  int duration;

  Charger({this.location, this.rate, this.available, this.total, this.wattage, this.type, this.datetime, this.duration});

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