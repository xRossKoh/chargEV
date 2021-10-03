class Booking {

  String chargerId;
  DateTime startTime;
  DateTime endTime;
  DateTime creationDate;
  double price;

  Duration get duration {
    return endTime.difference(startTime);
  }

  Booking({
      this.chargerId,
      this.startTime,
      this.endTime,
      this.creationDate,
      this.price});
}
