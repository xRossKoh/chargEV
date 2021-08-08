import 'package:flutter/material.dart';

class WelcomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  WelcomeAppBar(this.userName);

  final String userName;

  @override
  Size get preferredSize => Size.fromHeight(120);

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
            BackButton(),
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