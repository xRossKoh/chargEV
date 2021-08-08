import 'package:charg_ev/screens/wrapper.dart';
import 'package:charg_ev/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('en_SG');

  runApp(StreamProvider<User>.value(
    value: AuthService().user,
    initialData: null,
    child: MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => Wrapper()},
    ),
  ));
}
