import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duos_ui/utils/chat_utils.dart';
import 'dart:developer';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.firebaseFirestore});

  // For chat contacts
  // When user clicks on a chat, set the lastSeen to now
  void setSeenTimestampForChat(String uid1, String uid2) {
    try {
      final chatId = ChatUtils.getChatId(uid1, uid2);
      final uid1Seen = "${uid1}_last_seen";
      final now = Timestamp.now();

      FirebaseFirestore.instance.runTransaction((transaction) async {
        firebaseFirestore.collection("user_chats").doc(chatId).update({uid1Seen: now});
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

  // For chat
  // Get messages for active chat
  Stream<QuerySnapshot> getActiveChatMessagesSnapshot(String uid1, String uid2, int limit) {
    final chatId = ChatUtils.getChatId(uid1, uid2);
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

    print("IN HERE 1 >>>>>>>>");

    try {
      final chatId = ChatUtils.getChatId(uid1, uid2);
      print("IN HERE 2 >>>>>>>>");
      final now = Timestamp.now();

      final message = ({
        "sender_id": uid1,
        "timestamp": now,
        "content": content
      });
      print("IN HERE 3 >>>>>>>>");
      FirebaseFirestore.instance.runTransaction((transaction) async {
        print("IN HERE 4 >>>>>>>>");
        firebaseFirestore.collection("user_chats").doc(chatId).collection("messages").add(message);
        firebaseFirestore.collection("user_chats").doc(chatId).update({"last_updated": now});
        print("IN HERE 5 >>>>>>>>");
      });
    } catch(e) {
      log("Error: $e");
      print("IN HERE 6 >>>>>>>>");
    }
  }

}