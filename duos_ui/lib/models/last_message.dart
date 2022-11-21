import 'package:cloud_firestore/cloud_firestore.dart';

class LastMessage {
  String content;
  List<dynamic> users;
  String senderId;
  dynamic timestamp;

  LastMessage({
    required this.content,
    required this.senderId,
    required this.timestamp,
    required this.users
  });

  factory LastMessage.fromDocument(DocumentSnapshot doc) {
    return LastMessage(
        content: doc.get("content"),
        senderId: doc.get("sender_id"),
        timestamp: doc.get("timestamp"),
        users: doc.get("users")
    );
  }

  @override
  String toString() {
    return '{ $content, $senderId, $timestamp, ${users.toString()} }';
  }
}
