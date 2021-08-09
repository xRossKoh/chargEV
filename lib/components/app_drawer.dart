import 'package:charg_ev/models/user_info.dart';
import 'package:charg_ev/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserInfo user = Provider.of<UserInfo>(context);

    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Hello, ${user.displayName}', style: TextStyle(fontSize: 30))),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('View My Bookings'),
              onTap: () {
                Navigator.pushNamed(context, '/my_bookings');
              }
            ),
            ListTile(
              leading: Icon(Icons.ev_station),
              title: Text('Manage Chargers'),
              onTap: () {
                Navigator.pushNamed(context, '/my_chargers');
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Setup new Charger'),
              onTap: () {
                Navigator.pushNamed(context, '/charger_setup');
              }
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Sign Out'),
                onTap: _auth.signOut,
            ),
          ],
        )
    );
  }
}
