import 'dart:convert';
import 'package:duos_ui/constants/api_constants.dart';
import 'package:duos_ui/screens/settings_profile_bio.dart';
import 'package:duos_ui/screens/settings_profile_gender.dart';
import 'package:duos_ui/screens/settings_profile_hobbies.dart';
import 'package:duos_ui/screens/settings_profile_languages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _contactForm = GlobalKey<FormState>();

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
                          Icons.person,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      TextSpan(text: ' Edit Profile'),
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
                          builder: (context) => const EditProfileBio(),
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
                                  Text('Bio', style: TextStyle(fontSize: 18)),
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
                          builder: (context) => const EditProfileLanguages(),
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
                                Text('Languages', style: TextStyle(fontSize: 18)),
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
                          builder: (context) => const EditProfileHobbies(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Hobbies', style: TextStyle(fontSize: 18)),
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
                          builder: (context) =>
                          const EditProfileDatingPref(),
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
                                Text('Gender', style: TextStyle(fontSize: 18)),
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
}
