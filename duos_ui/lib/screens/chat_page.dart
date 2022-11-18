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

  final ScrollController listScrollController = ScrollController();

  late ChatProvider chatProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    authProvider = context.read<AuthProvider>();

    listScrollController.addListener(_scrollListener);
    readLocal();
  }

  _scrollListener() {
    //  scroll to bottom of list scroll container
  }

  void readLocal() {
    // uid1 = authProvider.sub;
    // uid2 = widget.arguments.peerUid;
    uid1 = "hUy3VSkxeTaCqTmbJRTeZnGtxO33";
    uid2 = "j31OC5G5ILZb7t8WygODsWskJMh2";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "Name Here",
              style: TextStyle(color: Colors.black),
            ),
            leading: const Material(
              child: IconButton(
                onPressed: (null),
                icon: Icon(Icons.arrow_back),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Avatar.small(url: "https://picsum.photos/200/300"),
              ),
            ],
            shape: const Border(
                bottom: BorderSide(color: Colors.black, width: 4)),
            elevation: 0),
        body: Column(
          children: <Widget>[
            buildListMessage(),
            messageInput()
          ],
        ),
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: uid2.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
        stream: chatProvider.getActiveChatMessagesSnapshot(uid1, uid2, limit),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            listMessage = snapshot.data!.docs;
            if (listMessage.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) =>
                    buildItem(index, snapshot.data?.docs[index]),
                itemCount: snapshot.data?.docs.length,
                reverse: true,
                controller: listScrollController,
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

  Widget buildItem(int index, dynamic data) {
    print("in here >>>>>>>>>>>>>>>>>>");
    print(data);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          width: 200,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(8)),
          child: const Text("hello world"),
        ),
      ],
    );
  }

  Widget messageInput() {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: const [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Aa", border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 24),
            child: IconButton(
              icon: Icon(Icons.send_sharp),
              onPressed: (null),
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}


class _DateLabel extends StatelessWidget {
  const _DateLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Text(label),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OwnMessageTile extends StatelessWidget {
  const OwnMessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

