import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:duos_ui/constants/api_constants.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class SettingsPageGender extends StatefulWidget {
  const SettingsPageGender({Key? key}) : super(key: key);

  @override
  State<SettingsPageGender> createState() => _SettingsPageGenderState();
}

class _SettingsPageGenderState extends State<SettingsPageGender> {
  final GlobalKey<FormState> _settingsForm = GlobalKey<FormState>();
  late AuthProvider authProvider;
  late ProfileProvider profileProvider;
  final TextEditingController _gameInput = TextEditingController();
  final TextEditingController _ageInput = TextEditingController();
  final TextEditingController _genderInput = TextEditingController();
  final TextEditingController _ethnicityInput = TextEditingController();
  String genderDropDown = '';

  bool vertical = false;

  var genders = ['Men', 'Women', 'Both men and women'];

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    profileProvider = context.read<ProfileProvider>();
    genderDropDown = profileProvider.gender;
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
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _settingsForm,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: ' Gender'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Gender", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                        value:
                            genderDropDown.isNotEmpty ? genderDropDown : null,
                        items: genders.map((String gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderDropDown = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateGender() async {
    String uid = authProvider.sub;
    final apiEmail = "${ApiConstants.apiBaseUrl}/user/$uid";
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final headers = ApiConstants.apiHeader(token ?? '');

    final data = {
      "info": {"gender": genderDropDown.trim()}
    };
    final encodedJson = jsonEncode(data);

    http.patch(Uri.parse(apiEmail), headers: headers, body: encodedJson);
  }
}
