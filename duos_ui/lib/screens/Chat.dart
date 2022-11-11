import 'dart:ffi';

import 'package:duos_ui/screens/home_page.dart';
import 'package:duos_ui/widgets/Avatar.dart';
import 'package:duos_ui/widgets/icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final ValueNotifier<String> personName = ValueNotifier("Kevin");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                personName.value,
                style: TextStyle(color: Colors.black),
              ),
              leading: Material(
                child: IconButton(
                  onPressed: (null),
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Avatar.small(url: "https://picsum.photos/200/300")),
              ],
              shape: Border(bottom: BorderSide(color: Colors.black, width: 4)),
              elevation: 0),
          body: Column(
            children: [
              Expanded(child: demoMessage()
              ),
              actionBar()
            ],
            
            )
          ),
    );
  }
}

class demoMessage extends StatelessWidget {
  const demoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _DateLabel(lable: "Yesterday"),
        _messageTile(message: "Hey how is it going"),

        ownMessageTile(message: "how is your day"),

        _messageTile(message: "it is good"),

        _messageTile(message: "how about you"),

        ownMessageTile(message: "it could be better"),
      ],
      
      );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    Key? key,
    required this.lable,
  }) : super(key: key);

  final String lable;

  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Text(lable)
      )
      
    );
  }
}

class _messageTile extends StatelessWidget {
  const _messageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            decoration: BoxDecoration(color: Colors.lightBlue[50],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomRight: Radius.circular(18)
            )
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),

            )

          )
        ]),
      ),
      );
  }
}

class ownMessageTile extends StatelessWidget{
  const ownMessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Container(
            decoration: BoxDecoration(color: Colors.lightBlue[50],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18)
            )
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),

            )

          )
        ]),
      ),
      );
  }
}

class actionBar extends StatelessWidget{
  const actionBar({
    Key? key
  }) : super(key: key);


  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 2
                  )
              )
            ),

            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                  onPressed: (null),
                  icon: Icon(Icons.camera_alt_rounded),
                )
                )
          ),

          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "say hi!",
                  border: InputBorder.none
                ),
              ),
              ) 
          ),

          Padding(
            padding: const EdgeInsets.only(
            left: 12,
            right: 24
          ),
            child: IconButton(
              icon: Icon(Icons.send_sharp), 
              onPressed: (null),
              color: Colors.blue,),
          )
      ]),
    );
  }
}







