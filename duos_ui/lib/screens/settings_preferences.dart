import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class SettingsPagePreferences extends StatefulWidget {
  const SettingsPagePreferences({Key? key}) : super(key: key);

  @override
  State<SettingsPagePreferences> createState() => _SettingsPagePreferencesState();
}

class _SettingsPagePreferencesState extends State<SettingsPagePreferences> {
  final GlobalKey<FormState> settingsform = GlobalKey<FormState>();
  final TextEditingController _gameInput = TextEditingController();
  final TextEditingController _ageInput = TextEditingController();
  final TextEditingController _genderInput = TextEditingController();
  final TextEditingController _ethnicityInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.0),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
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
          key: settingsform,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[

                      TextSpan(text: ' Preferences'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Game List", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: _gameInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load game list',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Age Range", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical:3),
                child: TextFormField(
                  controller: _ageInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load age range',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Gender", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: _genderInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load user gender',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Ethnicity", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: _ethnicityInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load preferred ethnicities',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0.1),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0.0), // Shadow Color
                      ),
                      onPressed: () {
                        updatePreferences();
                      },
                      child: const Text('Save'),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future updatePreferences() async {
    final apiPreferences = 'http://10.0.2.2:3000/user/x';
    String? token;
    FirebaseAuth.instance.currentUser!.getIdTokenResult(true).then((result){
      token = result.token;
    });
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    final json = '{"game": "${_gameInput.text.trim()}", '
        '"age": "${_ageInput.text.trim()}", '
        '"game": "${_genderInput.text.trim()}", '
        '"ethnicity": "${_ethnicityInput.text.trim()}",}';

    final res = http.put(Uri.parse(apiPreferences), headers: headers, body:json);
  }
}
