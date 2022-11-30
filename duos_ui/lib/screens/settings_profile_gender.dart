import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:duos_ui/constants/api_constants.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class EditProfileDatingPref extends StatefulWidget {
  const EditProfileDatingPref({Key? key}) : super(key: key);

  @override
  State<EditProfileDatingPref> createState() => _EditProfileDatingPrefState();
}

class _EditProfileDatingPrefState extends State<EditProfileDatingPref> {
  final GlobalKey<FormState> _settingsForm = GlobalKey<FormState>();
  late AuthProvider authProvider;
  late ProfileProvider profileProvider;
  String myGenderDropDown = '';

  var myGenders = ['Man', 'Woman', 'Other'];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    profileProvider = context.read<ProfileProvider>();
    myGenderDropDown = profileProvider.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.0),
        centerTitle: true,
        leading: InkWell(
          onTap: () async {
            await updateGender();
            if (!mounted) return;
            context.read<ProfileProvider>().setGender(myGenderDropDown);
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: ' My Gender'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: 50,
                  height: 5,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0))
                        ),
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
            ],
          ),
        ),
      ),
    );
  }

  Future updateGender() async {
    String uid = authProvider.sub;
    final apiGender = "${ApiConstants.apiBaseUrl}/user/$uid";
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final headers = ApiConstants.apiHeader(token ?? '');

    final data = {
      "info": {"gender": myGenderDropDown.trim()}
    };
    final encodedJson = jsonEncode(data);

    http.patch(Uri.parse(apiGender), headers: headers, body: encodedJson);
  }
}
