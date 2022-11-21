import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:duos_ui/providers/chat_provider.dart';
import 'package:duos_ui/models/models.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage> {
  final _searchFieldController = TextEditingController();

  late ContactsProvider contactsProvider;

  @override
  void initState() {
    super.initState();
    contactsProvider = context.read<ContactsProvider>();
    print(contactsProvider.contacts.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: _searchFieldController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    //debug print text
                    setState(() {
                      //reloads tile list
                      _searchFieldController.clear();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
