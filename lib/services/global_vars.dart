import 'package:flutter/material.dart';

class GlobalVars {
  final Color pink = Color(0xFFE9446A);
  final Color orange = Color(0xFFF6DC79);

  final LinearGradient pinkGradient = LinearGradient(
    colors: [
      Color(0xFFF679A3),
      Color(0xFFE9446A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final String _userstable = "users";
  String get usersTable => _userstable;

  String userName(String email) {
    return email.split("@")[0];
  }
}
