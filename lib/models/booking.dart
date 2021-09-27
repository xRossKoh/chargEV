class Booking {

  String chargerId;
  String ownerUid;
  DateTime startTime;
  DateTime endTime;
  DateTime creationDate;
  double price;

  Duration get duration {
    return endTime.difference(startTime);
  }

  Booking({
      this.chargerId,
      this.ownerUid,
      this.startTime,
      this.endTime,
      this.creationDate,
      this.price});
}
