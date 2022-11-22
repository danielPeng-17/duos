import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getChatId(String uid1, String uid2) {
    List<String> temp = <String>[uid1, uid2];
    temp.sort();
    return "${temp[0]}.${temp[1]}";
  }

  static String formatDate(
      Timestamp timestamp, String format, bool checkIfYesterdayOrToday) {
    final date = timestamp.toDate();
    if (checkIfYesterdayOrToday) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);

      final aDate = DateTime(date.year, date.month, date.day);
      if (aDate == today) {
        return 'Today';
      } else if (aDate == yesterday) {
        return 'Yesterday';
      }
    }
    return DateFormat(format).format(date);
  }

  static bool isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
