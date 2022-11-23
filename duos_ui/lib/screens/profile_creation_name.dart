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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _nameForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //   child: Text.rich(
              //     TextSpan(
              //       children: <InlineSpan>[
              //         WidgetSpan(
              //           child: Icon(
              //             Icons.create_sharp,
              //             color: Colors.black,
              //             size: 25,
              //           ),
              //         ),
              //         TextSpan(text: ' Profile Creation'),
              //       ],
              //     ),
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              const Center(
                child: Text(
                  "Your name",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: firstNameInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'First name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: lastNameInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Last name',
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
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
                      label: const Text(""),
                      onPressed: () async {
                        print(">>>>>>>> in here 7");
                        if (_nameForm.currentState!.validate()) {
                          print(">>>>>>>> in here 8");
                          context.read<ProfileProvider>().setFirstName(firstNameInput.text);
                          print(">>>>>>>> in here 9");
                          context.read<ProfileProvider>().setLastName(lastNameInput.text);
                          print(">>>>>>>> in here 10");
                          await _createProfile();
                          print(">>>>>>>> in here 11");
                          if (!mounted) return;
                          print(">>>>>>>> in here 12");
                          context.read<ProfileProvider>().setSetupStatus(true);
                          print(">>>>>>>> in here 13");
                          Navigator.of(context).popUntil((route) => route.isFirst);
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
    print(">>>>>>>> in here 14");
    dynamic user = FirebaseAuth.instance.currentUser;
    print(">>>>>>>> in here 15");
    String uid = user.uid;
    print(">>>>>>>> in here 16");
    String? token = await user.getIdToken();
    print(">>>>>>>> in here 17 " + token!);
    final apiMatchingEndpoint = "${ApiConstants.apiBaseUrl}/user";
    print(">>>>>>>> in here 8");
    final headers = ApiConstants.apiHeader(token ?? '');

    print(">>>>>>>> in here 1");
    if (!mounted) return;
    print(">>>>>>>> in here 2");
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
    print(">>>>>>>> in here 3");
    try {
      print(">>>>>>>> in here 4");
      await http.post(Uri.parse(apiMatchingEndpoint), headers: headers, body: json);
      print(">>>>>>>> in here 5");
    } catch (err) {
      // ignore
      print(">>>>>>>> in here 6");
    }
  }
}
