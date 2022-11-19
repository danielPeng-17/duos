import 'package:duos_ui/constants/api_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:duos_ui/providers/providers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class ProfileCreationName extends StatefulWidget {
  const ProfileCreationName({Key? key}) : super(key: key);

  @override
  State<ProfileCreationName> createState() => _ProfileCreationNameState();
}

class _ProfileCreationNameState extends State<ProfileCreationName> {
  final GlobalKey<FormState> _nameForm = GlobalKey<FormState>();
  TextEditingController firstNameInput = TextEditingController();
  TextEditingController lastNameInput = TextEditingController();

  @override
  void dispose() {
    firstNameInput.dispose();
    lastNameInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _nameForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 250,
                  height: 100,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        child: Icon(
                          Icons.create_sharp,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      TextSpan(text: ' Profile Creation'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text("What is your name?",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextFormField(
                  controller: firstNameInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'First name is required';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your first name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextFormField(
                  controller: lastNameInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Last name is required';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your last name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(0),
                        elevation: 20, // Elevation
                        shadowColor:
                            Colors.black.withOpacity(0), // Shadow Color
                      ),
                      icon: Image.asset(
                          "assets/images/profile_creation_next.png",
                          width: 100,
                          height: 100),
                      label: Text(""),
                      onPressed: () async {
                        if (_nameForm.currentState!.validate()) {
                          context
                              .read<ProfileProvider>()
                              .setFirstName(firstNameInput.text);

                          context
                              .read<ProfileProvider>()
                              .setLastName(lastNameInput.text);

                          await _createProfile();

                          if (!mounted) return;
                          context.read<ProfileProvider>().setSetupStatus(true);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }

                        // Validate returns true if the form is valid, or false otherwise.
                        // if (_formKey.currentState!.validate()) {
                        //   // If the form is valid, display a snackbar. In the real world,
                        //   // you'd often call a server or save the information in a database.
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Processing Data')),
                        //   );
                        // }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future _createProfile() async {
    dynamic user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;
    String? token = await user.getIdToken();
    final apiMatchingEndpoint = "${ApiConstants.apiBaseUrl}/user";
    final headers = ApiConstants.apiHeader(token ?? '');

    if (!mounted) return;
    final json = jsonEncode({
      "info": {
        "first_name": context.read<ProfileProvider>().firstName,
        "last_name": context.read<ProfileProvider>().lastName,
        "email": context.read<ProfileProvider>().email,
        "gender": context.read<ProfileProvider>().gender,
        "bio": context.read<ProfileProvider>().bio,
        "date_of_birth": context.read<ProfileProvider>().dob,
        "hobbies": context.read<ProfileProvider>().hobbies,
        "languages": context.read<ProfileProvider>().languages,
        "location": context.read<ProfileProvider>().location,
        "profile_picture_url": context.read<ProfileProvider>().profilePicURL,
        "dating_pref": context.read<ProfileProvider>().datingPref,
        "igns": context.read<ProfileProvider>().igns,
      },
      "uid": uid,
      "categories": context.read<ProfileProvider>().categories
    });

    try {
      final res = await http.post(Uri.parse(apiMatchingEndpoint), headers: headers, body: json);
    } catch (err) {
      // ignore
    }
  }
}
