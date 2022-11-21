import 'package:flutter/material.dart';

class Utils {
    static String getChatId(String uid1, String uid2) {
        List<String> temp = <String>[uid1, uid2];
        temp.sort();
        return "${temp[0]}.${temp[1]}";
    }
}
