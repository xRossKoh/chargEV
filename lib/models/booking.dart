class Booking {

  String chargerId;
  String ownerUserId;
  DateTime startTime;
  DateTime endTime;
  DateTime creationDate;
  double price;

  Duration get duration {
    return endTime.difference(startTime);
  }

  Booking({
      this.chargerId,
      this.ownerUserId,
      this.startTime,
      this.endTime,
      this.creationDate,
      this.price});
}
