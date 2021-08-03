import 'package:flutter/material.dart';

// contains appearance and metric constants for app

const textInputDecoration = InputDecoration(
    fillColor: Color(0xFFE0E0E0),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0)));

final Image businessLogo = Image.asset('assets/chargEV_logo.jpg');
