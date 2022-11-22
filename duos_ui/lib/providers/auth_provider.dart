import 'package:duos_ui/providers/disposable_provider.dart';
import 'package:flutter/material.dart';

class AuthProvider extends DisposableProvider {
  String _uid = '';

  String get sub => _uid;

  void setSub(String s) {
    _uid = s;
    notifyListeners();
  }

  @override
  void disposeValues() {
    _uid = '';
  }
}
