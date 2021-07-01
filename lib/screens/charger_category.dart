import 'package:charg_ev/components/searchbar.dart';
import 'package:flutter/material.dart';

//==============================================================//

///screen
class ChargerCategory extends StatelessWidget {
  const ChargerCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> chargerCategories = [
      {
        'displayImage': Image.asset('assets/fast_charger.jpg'),
        'categoryName': "Fast Chargers",
        'count': 4134
      },
      {
        'displayImage': Image.asset('assets/slow_charger.jpg'),
        'categoryName': "Slow Chargers",
        'count': 649
      }
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: WelcomeAppBar(),
        body: Column(
          children: [
            SearchBar(),
            GridView.builder(
              padding: EdgeInsets.fromLTRB(
            size.width * 0.05, 0 , size.width * 0.05, 0),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8
                    ),
              itemCount: chargerCategories.length,
              itemBuilder: (context, index) => ChargeCategoryCard(
                  displayImage: chargerCategories[index]['displayImage'],
                  categoryName: chargerCategories[index]['categoryName'],
                  count: chargerCategories[index]['count']),
            )
          ],
        ));
  }
}

//==============================================================//

//App bar for this page
class WelcomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const WelcomeAppBar({Key key}) : super(key: key);

  @override
  _WelcomeAppBarState createState() => _WelcomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(120);
}

class _WelcomeAppBarState extends State<WelcomeAppBar> {
  String userName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.fromLTRB(
            size.width * 0.05, 25 + size.height * 0.03, size.width * 0.05, 0),
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

//==============================================================//

///The items that are to be displayed in a grid
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
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                  child: FittedBox(child: displayImage, fit: BoxFit.cover, clipBehavior: Clip.hardEdge,)),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 0, 5),
                child: Text(categoryName,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Text(' (${count.toString()}) '),
              )
            ],
          )),
    );
  }
}
