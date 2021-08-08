// class for information on charging station

class Charger {
  String location;
  double rate;
  int available;
  int total;
  int wattage;
  int type;
  String uid; //owner
  String nickname;

  Charger(
      {this.location,
      this.rate,
      this.available,
      this.total,
      this.wattage,
      this.type,
      this.uid,
      this.nickname = 'Charger Name'
});
}
