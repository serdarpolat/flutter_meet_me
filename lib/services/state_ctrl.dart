import 'package:flutter/material.dart';

class UserSignMethod with ChangeNotifier {
  String _signMethod = "email";

  String get signMethod => _signMethod;

  changeMethod(String method) {
    _signMethod = method;
    notifyListeners();
  }
}
