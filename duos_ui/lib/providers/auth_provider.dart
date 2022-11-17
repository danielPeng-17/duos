import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _uid = '';

  String get sub => _uid;

  void setSub(String s) {
    _uid = s;
    notifyListeners();
  }
}
