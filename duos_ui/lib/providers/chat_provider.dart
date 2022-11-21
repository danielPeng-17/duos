import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duos_ui/utils/utils.dart';
import 'dart:developer';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.firebaseFirestore});

  // For chat
  // Get messages for active chat
  Stream<QuerySnapshot> getActiveChatMessagesSnapshot(String uid1, String uid2, int limit) {
    final chatId = Utils.getChatId(uid1, uid2);
    return firebaseFirestore
        .collection("user_chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots();
  }

  // send message
  void sendMessage(String uid1, String uid2, String content) {
    if (uid1.isEmpty || uid2.isEmpty || content.isEmpty) {
      log('Error sending message. Missing uid1 or uid2 or content');
    }

    try {
      final chatId = Utils.getChatId(uid1, uid2);
      final now = Timestamp.now();

      final message = ({
        "sender_id": uid1,
        "timestamp": now,
        "content": content
      });

      FirebaseFirestore.instance.runTransaction((transaction) async {
        firebaseFirestore.collection("user_chats").doc(chatId).collection("messages").add(message);
        firebaseFirestore.collection("user_chats").doc(chatId).set({"last_updated": now});
      });
    } catch(e) {
      log("Error: $e");
    }
  }

}