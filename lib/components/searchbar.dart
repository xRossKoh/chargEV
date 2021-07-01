import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController messageEditingController = new TextEditingController();
     // fetch dimensions of phone
    Size size = MediaQuery.of(context).size;

    return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 0),
              child: TextField(
                controller: messageEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            );
  }
}