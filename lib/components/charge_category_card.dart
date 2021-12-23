import 'package:flutter/material.dart';

class ChargeCategoryCard extends StatelessWidget {
  const ChargeCategoryCard(
      {Key key,

        //maybe make a new class to encapsulate this info
        @required this.displayImage,
        @required this.categoryName,
        @required this.count})
      : super(key: key);

  final Image displayImage;
  final String categoryName;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/charger_selection');
          }, //some kind of handler here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 1,
                  child: FittedBox(
                    child: displayImage,
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                child: Text(categoryName,
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              //   child: Text(' (${count.toString()}) '),
              // )
            ],
          )),
    );
  }
}