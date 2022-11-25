import 'package:duos_ui/screens/settings_pref_games.dart';
import 'package:duos_ui/screens/settings_pref_gender.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class SettingsPagePreferences extends StatefulWidget {
  const SettingsPagePreferences({Key? key}) : super(key: key);

  @override
  State<SettingsPagePreferences> createState() => _SettingsPagePreferencesState();
}

class _SettingsPagePreferencesState extends State<SettingsPagePreferences> {
  final GlobalKey<FormState> _contactForm = GlobalKey<FormState>();
  final TextEditingController _emailInput = TextEditingController();

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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _contactForm,
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
                      WidgetSpan(
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      TextSpan(text: ' Preferences'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 50,
                  height: 10,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffCDCDCD),
                      width: 0.8,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPageGender(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black.withOpacity(1),
                      backgroundColor: Colors.black.withOpacity(0),
                      elevation: 20, // Elevation
                      shadowColor:
                      Colors.black.withOpacity(0), // Shadow Color
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Gender'),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffCDCDCD),
                      width: 0.8,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPageGames(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black.withOpacity(1),
                      backgroundColor: Colors.black.withOpacity(0),
                      elevation: 20, // Elevation
                      shadowColor: Colors.black.withOpacity(0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Games'),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        ),
                      ],
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

  Future updateEmailAndPhone() async {
    final apiEmailAndPhone = 'http://10.0.2.2:3000/user/x';
    String? token;
    FirebaseAuth.instance.currentUser!.getIdTokenResult(true).then((result){
      token = result.token;
    });
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    final json = '{"email": "${_emailInput.text.trim()}"}';

    final res = http.put(Uri.parse(apiEmailAndPhone), headers: headers, body:json);
  }
}
