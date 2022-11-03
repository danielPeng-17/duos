import 'dart:ffi';

import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _gender = '';
  String _bio = '';
  String _datingPref = '';
  DateTime _dateOfBirth = DateTime.utc(1900, 01, 01);
  List<String> _igns = [];

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get gender => _gender;
  String get bio => _bio;
  String get datingPref => _datingPref;
  DateTime get dob => _dateOfBirth;
  List<String> get igns => _igns;

  void setFirstName(String s) {
    _firstName = s;
    notifyListeners();
  }

  void setLastName(String s) {
    _lastName = s;
    notifyListeners();
  }

  void setEmail(String s) {
    _email = s;
    notifyListeners();
  }

  void setGender(String s) {
    _gender = s;
    notifyListeners();
  }

  void setBio(String s) {
    _bio = s;
    notifyListeners();
  }

  void setDatingPref(String s) {
    _datingPref = s;
    notifyListeners();
  }

  void setDateofBirth(DateTime date) {
    _dateOfBirth = date;
    notifyListeners();
  }

  void setIgns(List<String> igns) {
    _igns = igns;
    notifyListeners();
  }

  void addIgn(String ign) {
    _igns.add(ign);
    notifyListeners();
  }
}
