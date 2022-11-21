import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/utils.dart';


class ContactsProvider {
  final FirebaseFirestore firebaseFirestore;

  ContactsProvider({required this.firebaseFirestore});

  // For chat contacts
  // When user clicks on a chat, set the lastSeen to now
  void setSeenTimestampForChat(String uid1, String uid2) {
    try {
      final chatId = Utils.getChatId(uid1, uid2);
      final uid1Seen = "${uid1}_last_seen";
      final now = Timestamp.now();

      FirebaseFirestore.instance.runTransaction((transaction) async {
        firebaseFirestore
            .collection("user_chats")
            .doc(chatId)
            .set({uid1Seen: now});
      });
    } catch (e) {
      log("Error: $e");
    }
  }

  Stream<QuerySnapshot> getLastMessageStream(String uid) {
    return firebaseFirestore
        .collection("last_messages")
        .where("users", arrayContains: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getContactsStream(String uid) {
    return firebaseFirestore
        .collection("user_profiles")
        .where("uid", isEqualTo: uid)
        .snapshots();
  }
}
