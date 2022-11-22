import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duos_ui/models/last_message.dart';
import 'package:duos_ui/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:duos_ui/providers/chat_provider.dart';
import 'package:duos_ui/models/models.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

import '../utils/utils.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage> {
  late String uid;
  final _searchFieldController = TextEditingController();

  late ContactsProvider contactsProvider;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    contactsProvider = context.read<ContactsProvider>();
    authProvider = context.read<AuthProvider>();
    uid = authProvider.sub;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchFieldController,
                onChanged: (_) {
                  // reloads tile list
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchFieldController.clear();
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: StreamBuilder(
                stream: contactsProvider.getContactsStream(uid),
                builder: (context, contactsSnapshot) {
                  if (contactsSnapshot.hasData) {
                    final matched = contactsSnapshot.data?.docs[0]["matched"];
                    List<Contact> contacts = List<Contact>.from(
                        matched.map((contact) => Contact.fromJson(contact)));
                    return StreamBuilder(
                        stream: contactsProvider.getLastMessageStream(uid),
                        builder: (context, lastMessageSnapshot) {
                          if (contactsSnapshot.hasData) {
                            List<LastMessage> lastMessages = [];

                            if (lastMessageSnapshot.hasData) {
                              final lastMessagesSnapshotDocs = lastMessageSnapshot.data!.docs;

                              lastMessages =
                                  List<LastMessage>.from(
                                      lastMessagesSnapshotDocs.map((message) =>
                                          LastMessage.fromDocument(message))) ?? [];
                            }

                            return ListView.builder(
                              itemCount: contacts.length,
                              itemBuilder: (context, index) =>
                                  contactsTile(contacts[index], lastMessages),
                            );
                          }
                          return Container();
                        });
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactsTile(Contact contact, List<LastMessage> lastMessages) {
    final lastMessage = lastMessages.firstWhere(
        (message) =>
            message.users[0].toString() == contact.uid ||
            message.users[1].toString() == contact.uid,
        orElse: () =>
            LastMessage(content: "", senderId: "", timestamp: "", users: []));

    return contact.firstName
                .toLowerCase()
                .contains(_searchFieldController.text.toLowerCase()) ||
            contact.lastName
                .toLowerCase()
                .contains(_searchFieldController.text.toLowerCase())
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    arguments: ChatPageArguments(
                        peerUid: contact.uid,
                        peerName: "${contact.firstName} ${contact.lastName}",
                        peerImg: contact.profileUrl),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 6),
              color: Colors.transparent,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12, left: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.network(
                              contact.profileUrl,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${contact.firstName} ${contact.lastName}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(lastMessages.isNotEmpty && lastMessage.senderId != ""
                                ? "${lastMessage.senderId == uid ? 'You: ' : ''} ${lastMessage.content}  •  ${Utils.formatDate(lastMessage.timestamp, "MMM. d, ''yy", true)}"
                                : "No messages yet")
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
