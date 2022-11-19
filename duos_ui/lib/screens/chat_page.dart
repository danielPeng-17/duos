import 'package:cloud_firestore/cloud_firestore.dart';
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
  ScrollController listScrollController = ScrollController();

  late ChatProvider chatProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();

    readLocal();
  }


  void readLocal() {
    // uid1 = authProvider.sub;
    // uid2 = widget.arguments.peerUid;
    uid1 = "PbsHaVsmcZQtspSJvAPlzgCPmP72";
    uid2 = "zmUYi77QgaSPX6lmSSx0LlT67EV2";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 12, left: 20),
                child: Avatar.small(url: "https://picsum.photos/200/300"),
              ),
              Text(
                "Name Here",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          leading: const Material(
            child: IconButton(
              onPressed: (null),
              icon: Icon(Icons.arrow_back),
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
                itemBuilder: (context, index) =>
                    buildItem(index, snapshot.data!.docs[index]),
                itemCount: snapshot.data?.docs.length,
                reverse: true,
              );
            } else {
              return const Center(child: Text("No message here yet..."));
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

  Widget buildItem(int index, DocumentSnapshot data) {
    final message = data.get("content").toString();
    final senderId = data.get("sender_id").toString();
    // final time =
    //     DateTime.fromMillisecondsSinceEpoch(data.get("timestamp") * 1000);

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
      child: Align(
        alignment: (senderId == uid2 ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (senderId == uid2 ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding:
          const EdgeInsets.only(top: 15, bottom: 15, left: 18, right: 18),
          child: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
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
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 8, top: 8),
              child: TextField(
                controller: textEditingController,
                textInputAction: TextInputAction.go,
                onSubmitted: (text) => sendMessage(text),
                decoration: InputDecoration(
                  hintText: "Aa",
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 14),
            child: IconButton(
              icon: const Icon(Icons.send_sharp),
              onPressed: () => sendMessage(textEditingController.text),
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
