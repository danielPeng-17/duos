import 'package:duos_ui/screens/settings_preferences.dart';
import 'package:duos_ui/screens/settings_notifications.dart';
import 'package:duos_ui/screens/settings_privacy.dart';
import 'package:duos_ui/screens/settings_terms_of_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _contactForm = GlobalKey<FormState>();
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _emailInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: _contactForm,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 50,
                  height: 10,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      TextSpan(text: ' Settings'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Text("Phone Number", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: TextFormField(
                  controller: _phoneInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Load stored phone number',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 50,
                  height: 10,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical:0),
                child: Text("Email", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: TextFormField(
                  controller: _emailInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Load stored email for this account',
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20, left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0.1),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0.0), // Shadow Color
                      ),
                      onPressed: () {
                        updateEmailAndPhone();
                      },
                      child: const Text('Update'),
                    ),
                  )
              ),

              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0), // Shadow Color
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text('Edit Profile'),
                                    ],
                                ),
                                ),
                              ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                    children: const[
                                      Icon(Icons.edit),
                                    ],
                                ),
                            ),
                            ),
                          ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsPagePreferences(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0), // Shadow Color
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Preferences'),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: const[
                                  Icon(Icons.settings),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsPagePrivacy(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0), // Shadow Color
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Privacy and Security'),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: const[
                                  Icon(Icons.lock),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsPageNotifications(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0), // Shadow Color
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Notifications'),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: const[
                                  Icon(Icons.notifications),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingsPageTOS(),
                          ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0), // Shadow Color
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Terms of Service'),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: const[
                                  Icon(Icons.person),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileProvider>().disposeValues();
                        FirebaseAuth.instance.signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(1),
                        elevation: 20, // Elevation
                        shadowColor:
                        Colors.black.withOpacity(0), // Shadow Color
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Sign Out'),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: const[
                                  Icon(Icons.arrow_right_alt_sharp),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
    final json = '{"email": "${_emailInput.text.trim()}", "phone": "${_phoneInput.text.trim()}"}';

    final res = http.put(Uri.parse(apiEmailAndPhone), headers: headers, body:json);
  }
}
