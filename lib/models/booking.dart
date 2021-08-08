class Booking {

  String chargerId;
  String chargerLocationName;
  DateTime startTime;
  DateTime endTime;
  String user;
  double price;
  DateTime creationDate;

  Duration get duration {
    return endTime.difference(startTime);
  }

  Booking(
      {this.chargerId,
      this.startTime,
      this.endTime,
      this.user,
      this.chargerLocationName,
      this.price,
      this.creationDate});
}
