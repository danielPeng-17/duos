import 'dart:convert';

import 'package:duos_ui/screens/contacts_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:duos_ui/screens/home_page.dart';
import 'package:provider/provider.dart';
import '../screens/profile_page.dart';
import 'package:duos_ui/screens/settings_page.dart';
import 'package:provider/provider.dart';
import '../constants/api_constants.dart';
import 'package:duos_ui/providers/providers.dart';
import 'package:http/http.dart' as http;

class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  ContainerPageState createState() => ContainerPageState();
}

class ContainerPageState extends State<ContainerPage> {
  late String uid;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    ProfilePage(),
    ContactsPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchUserData());
  }

  _fetchUserData() async {
    if (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser?.uid != null) {
      uid = FirebaseAuth.instance.currentUser!.uid;
    } else {
      // if uid is null => users need to sign in
      context.read<ProfileProvider>().disposeValues();
      context.read<AuthProvider>().disposeValues();
      FirebaseAuth.instance.signOut();
    }

    if (uid.isNotEmpty) {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.get(
          Uri.parse("${ApiConstants.apiBaseUrl}/user/$uid"),
          headers: ApiConstants.apiHeader(token));

      final decodedRes = jsonDecode(response.body);

      if (!mounted) return;
      context.read<AuthProvider>().setSub(uid);

      if (decodedRes.isNotEmpty) {
        context.read<ProfileProvider>().setFirstName(decodedRes["info"]["first_name"]);
        context.read<ProfileProvider>().setLastName(decodedRes["info"]["last_name"]);
        context.read<ProfileProvider>().setEmail(decodedRes["info"]["email"]);
        context.read<ProfileProvider>().setGender(decodedRes["info"]["gender"]);
        context.read<ProfileProvider>().setBio(decodedRes["info"]["bio"]);
        context.read<ProfileProvider>().setDateofBirth(decodedRes["info"]["date_of_birth"]);
        context.read<ProfileProvider>().setHobbies(decodedRes["info"]["hobbies"]);
        context.read<ProfileProvider>().setProfilePicURL(decodedRes["info"]["profile_picture_url"]);
        context.read<ProfileProvider>().setDatingPref(decodedRes["info"]["dating_pref"]);
        context.read<ProfileProvider>().setCategories(List<String>.from(decodedRes['categories']));
        context.read<ProfileProvider>().setLanguages(decodedRes["info"]["languages"]);
        context.read<ProfileProvider>().setLocation(decodedRes["info"]["location"]);
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff8D5185),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
