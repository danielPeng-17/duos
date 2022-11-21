import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duos_ui/utils/utils.dart';
import 'package:duos_ui/widgets/avatar.dart';
import 'package:duos_ui/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/chat_provider.dart';

class ChatPageArguments {
  final String peerUid;
  final String peerName;
  final String peerImg;

  ChatPageArguments(
      {required this.peerUid, required this.peerName, required this.peerImg});
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.arguments}) : super(key: key);

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late String uid1;
  late String uid2;
  List<QueryDocumentSnapshot> listMessage = [];
  int limit = 25;

  TextEditingController textEditingController = TextEditingController();

  late ChatProvider chatProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();

    uid1 = authProvider.sub;
    uid2 = widget.arguments.peerUid;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 20),
                child: Avatar.small(url: widget.arguments.peerImg),
              ),
              Text(
                widget.arguments.peerName,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          leading: Material(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              color: Colors.grey[400],
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[buildListMessage(), messageInput()],
        ),
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: uid2.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream:
                  chatProvider.getActiveChatMessagesSnapshot(uid1, uid2, limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        bool showDate = false;

                        if (index == snapshot.data!.docs.length - 1) {
                          showDate = true;
                        } else {
                          final previousMessageDate =
                              (data.get("timestamp") as Timestamp).toDate();
                          final currentMessageDate =
                              (snapshot.data!.docs[index + 1].get("timestamp")
                                      as Timestamp)
                                  .toDate();

                          if (previousMessageDate
                              .isBefore(currentMessageDate)) {
                            showDate = true;
                          }
                        }

                        return buildItem(index, data, showDate);
                      },
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                    );
                  } else {
                    return const Center(child: Text("No messages yet..."));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amberAccent,
                    ),
                  );
                }
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.amberAccent,
              ),
            ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot data, bool showDate) {
    final message = data.get("content").toString();
    final senderId = data.get("sender_id").toString();
    final time = Utils.formatDate(
        data.get("timestamp") as Timestamp, "MMM. d, yyyy", true);

    return Column(
      children: [
        showDate
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(time),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Divider(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              )
            : Column(),
        Container(
          margin: EdgeInsets.fromLTRB(
              senderId == uid1 ? 48.0 : 0, 0, senderId == uid1 ? 0 : 48.0, 0),
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
          child: Align(
            alignment:
                (senderId == uid2 ? Alignment.topLeft : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (senderId == uid2
                    ? Colors.grey.shade200
                    : Colors.blue[200]),
              ),
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 18, right: 18),
              child: Text(
                message,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void sendMessage(String content) {
    String message = content.trim();
    if (message.isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(uid1, uid2, message);
    }
  }

  Widget messageInput() {
    return SafeArea(
      bottom: true,
      top: false,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, bottom: 8, top: 8, right: 16),
              child: TextField(
                controller: textEditingController,
                textInputAction: TextInputAction.go,
                onSubmitted: (text) => sendMessage(text),
                decoration: InputDecoration(
                  hintText: "Aa",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send_sharp),
                    onPressed: () => sendMessage(textEditingController.text),
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
