import 'package:duos_ui/widgets/avatar.dart';
import 'package:duos_ui/widgets/icon.dart';
import 'package:flutter/material.dart';

class ChatPageArguments {
  final String peerId;
  final String peerAvatar;
  final String peerName;

  ChatPageArguments({required this.peerId, required this.peerAvatar, required this.,peerName});
}


class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.arguments}) : super(key: key);
  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  
}



// class ChatPage extends StatelessWidget {
//   ChatPage({Key? key}) : super(key: key);
//
//   final ValueNotifier<String> personName = ValueNotifier("Kevin");
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             centerTitle: true,
//             title: Text(
//               personName.value,
//               style: const TextStyle(color: Colors.black),
//             ),
//             leading: const Material(
//               child: IconButton(
//                 onPressed: (null),
//                 icon: Icon(Icons.arrow_back),
//               ),
//             ),
//             actions: const [
//               Padding(
//                 padding: EdgeInsets.only(right: 24),
//                 child: Avatar.small(url: "https://picsum.photos/200/300"),
//               ),
//             ],
//             shape: const Border(bottom: BorderSide(color: Colors.black, width: 4)),
//             elevation: 0),
//         body: Column(
//           children: const [],
//         ),
//       ),
//     );
//   }
// }

// class DemoMessage extends StatelessWidget {
//   const DemoMessage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: const [
//         _DateLabel(label: "Yesterday"),
//         _MessageTile(message: "Hey how is it going"),
//         OwnMessageTile(message: "how is your day"),
//         _MessageTile(message: "it is good"),
//         _MessageTile(message: "how about you"),
//         OwnMessageTile(message: "it could be better"),
//       ],
//     );
//   }
// }

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

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right:
                    BorderSide(color: Theme.of(context).dividerColor, width: 2),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: (null),
                icon: Icon(Icons.camera_alt_rounded),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "say hi!", border: InputBorder.none),
              ),
            ),
          ),
          const Padding(
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
