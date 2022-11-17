import 'package:duos_ui/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileCreationName extends StatefulWidget {
  const ProfileCreationName({Key? key}) : super(key: key);

  @override
  State<ProfileCreationName> createState() => _ProfileCreationNameState();
}

class _ProfileCreationNameState extends State<ProfileCreationName> {
  final GlobalKey<FormState> _nameform = GlobalKey<FormState>();
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
          key: _nameform,
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
                      onPressed: () {
                        if (_nameform.currentState!.validate()) {
                          context
                              .read<Profile>()
                              .setFirstName(firstNameInput.text);

                          context
                              .read<Profile>()
                              .setLastName(lastNameInput.text);

                          context.read<Profile>().setSetupStatus(true);

                          _createProfile();

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
    const apiMatchingEndpoint = "http://10.0.2.2:3000/user";
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    if (!mounted) return;
    final json = jsonEncode({
      "info": {
        "first_name": context.read<Profile>().firstName,
        "last_name": context.read<Profile>().lastName,
        "email": context.read<Profile>().email,
        "gender": context.read<Profile>().gender,
        "bio": context.read<Profile>().bio,
        "date_of_birth": context.read<Profile>().dob,
        "hobbies": context.read<Profile>().hobbies,
        "languages": context.read<Profile>().languages,
        "location": context.read<Profile>().location,
        "profile_picture_url": "https://images.unsplash.com/photo-1506691318991-c91e7df669b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=673&q=80",
        "dating_pref": context.read<Profile>().datingPref,
        "igns": context.read<Profile>().igns,
      },
      "uid": uid,
    });

    try {
      final res = await http.post(Uri.parse(apiMatchingEndpoint), headers: headers, body: json);
    } catch (err) {
      // ignore
    }
  }
}
