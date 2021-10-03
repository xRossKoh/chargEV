import 'package:charg_ev/components/app_drawer.dart';
import 'package:charg_ev/components/charge_category_card.dart';
import 'package:charg_ev/components/welcome_appbar.dart';
import 'package:charg_ev/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    final UserInfo user = Provider.of<UserInfo>(context);

    return Scaffold(
        drawer: AppDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              WelcomeAppBar(user),
              GridView.builder(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.05, 0, size.width * 0.05, 0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8),
                itemCount: chargerCategories.length,
                itemBuilder: (context, index) => ChargeCategoryCard(
                    displayImage: chargerCategories[index]['displayImage'],
                    categoryName: chargerCategories[index]['categoryName'],
                    count: chargerCategories[index]['count']),
              )
            ],
          ),
        ));
  }
}