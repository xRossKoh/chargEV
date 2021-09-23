import 'package:charg_ev/models/booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:duration/duration.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({Key key, this.booking}) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatterA = DateFormat.yMMMd("en_SG").addPattern('jm', ', ');
    DateFormat dateFormatterB = DateFormat.jm("en_SG");

    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(children: [
          Divider(
            thickness: 1,
          ),
          ListTile(
            title: Text(
              booking.chargerLocation,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                    'From ${dateFormatterA.format(booking.startTime)} to ${dateFormatterB.format(booking.endTime)}\n(${prettyDuration(booking.duration, tersity: DurationTersity.minute)})',
                    style: TextStyle(fontSize: 16)),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                          text: 'Amount paid: ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      TextSpan(
                          text:
                              '${NumberFormat.currency(name: 'SGD').format(booking.price)}')
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
