import 'package:duos_ui/screens/profile_creation_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:duos_ui/constants/api_constants.dart';
import 'package:provider/provider.dart';

class ProfileCreationBio extends StatefulWidget {
  const ProfileCreationBio({Key? key}) : super(key: key);

  @override
  State<ProfileCreationBio> createState() => _ProfileCreationBioState();
}

class _ProfileCreationBioState extends State<ProfileCreationBio> {
  final GlobalKey<FormState> _bioForm = GlobalKey<FormState>();
  TextEditingController descInput = TextEditingController();
  TextEditingController hobbiesInput = TextEditingController();
  TextEditingController languagesInput = TextEditingController();
  TextEditingController pronounsInput = TextEditingController();
  TextEditingController datingPrefInput = TextEditingController();
  TextEditingController locationInput = TextEditingController();
  String prefGenderDropDown = '';
  String myGenderDropDown = '';
  var myGenders = ['Man', 'Woman', 'Other'];
  var genders = ['Men', 'Women', 'Both men and women'];

  @override
  void dispose() {
    descInput.dispose();
    hobbiesInput.dispose();
    languagesInput.dispose();
    pronounsInput.dispose();
    datingPrefInput.dispose();
    locationInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _bioForm,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
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
                child: Text("Your bio",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 3, left: 30),
                child: Text("Description", style: TextStyle(fontSize: 16)),
              ),
              TextFormField(
                controller: descInput,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'Tell us about yourself',
                ),
              ),

              label("Hobbies"),
              TextFormField(
                controller: hobbiesInput,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Hobbies field is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'E.g. Badminton, Chess, Gaming',
                ),
              ),

              label("Dating Preferences"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                      value: prefGenderDropDown.isNotEmpty
                          ? prefGenderDropDown
                          : null,
                      items: genders.map((String gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          prefGenderDropDown = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              label("Languages"),
              TextFormField(
                controller: languagesInput,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Language field is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'E.g. English, French, Spanish',
                ),
              ),

              label("My gender"),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                      value:
                          myGenderDropDown.isNotEmpty ? myGenderDropDown : null,
                      items: myGenders.map((String myGenders) {
                        return DropdownMenuItem(
                          value: myGenders,
                          child: Text(myGenders),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          myGenderDropDown = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              label("Location"),
              TextFormField(
                controller: locationInput,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  hintText: 'City, Country',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_bioForm.currentState!.validate()) {
                      context.read<ProfileProvider>().setBio(descInput.text);
                      context
                          .read<ProfileProvider>()
                          .setHobbies(hobbiesInput.text);
                      context
                          .read<ProfileProvider>()
                          .setDatingPref(prefGenderDropDown);
                      context
                          .read<ProfileProvider>()
                          .setLanguages(languagesInput.text);
                      context
                          .read<ProfileProvider>()
                          .setGender(myGenderDropDown);
                      context
                          .read<ProfileProvider>()
                          .setLocation(locationInput.text);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileCreationGame()));
                      // Validate returns true if the form is valid, or false otherwise.
                      // if (_formKey.currentState!.validate()) {
                      //   // If the form is valid, display a snackbar. In the real world,
                      //   // you'd often call a server or save the information in a database.
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Processing Data')),
                      //   );
                      // }
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Continue",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 30, top: 12),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
