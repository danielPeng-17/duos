import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contacts.dart';
import '../utils/utils.dart';
import 'disposable_provider.dart';
import 'package:duos_ui/constants/constants.dart';

class ContactsProvider extends DisposableProvider {
  List<Contacts> _contacts = [];
  final FirebaseFirestore firebaseFirestore;

  ContactsProvider({required this.firebaseFirestore});

  List<Contacts> get contacts => _contacts;

  void setContacts(List<Contacts> c) {
    _contacts = c;
    notifyListeners();
  }

  // For chat contacts
  // When user clicks on a chat, set the lastSeen to now
  void setSeenTimestampForChat(String uid1, String uid2) {
    try {
      final chatId = Utils.getChatId(uid1, uid2);
      final uid1Seen = "${uid1}_last_seen";
      final now = Timestamp.now();

      FirebaseFirestore.instance.runTransaction((transaction) async {
        firebaseFirestore.collection("user_chats").doc(chatId).set({uid1Seen: now});
      });
    } catch(e) {
      log("Error: $e");
    }
  }

  // For chat contacts
  // Allows user to see which chats got new messages
  Stream<QuerySnapshot> getChatsSnapshot(String uid1) {
    return firebaseFirestore
        .collection("user_chats")
        .where('users', arrayContains: [uid1])
        .orderBy('last_updated', descending: true)
        .snapshots();
  }

  void setUserStatus(String uid, Status status) {

  }

  void getUserStatus() {

  }

  @override
  void disposeValues() {
    _contacts = [];
  }
}