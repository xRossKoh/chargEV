import 'package:flutter/material.dart';

class WelcomeAppBar extends StatelessWidget {
  WelcomeAppBar(this.userName);

  final String userName;

  @override
  Widget build(BuildContext context) {

    // query size of screen
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.fromLTRB(
            size.width * 0.05, size.height * 0.03, size.width * 0.05, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ModalRoute.of(context).canPop) BackButton(),
            Text(
              'Hello, $userName',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ],
        ));
  }
}
