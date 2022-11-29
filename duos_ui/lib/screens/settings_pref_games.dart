import 'package:flutter/material.dart';
import 'package:duos_ui/providers/providers.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:duos_ui/constants/api_constants.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class SettingsPageGames extends StatefulWidget {
  const SettingsPageGames({Key? key}) : super(key: key);

  @override
  State<SettingsPageGames> createState() => _SettingsPageGamesState();
}

class _SettingsPageGamesState extends State<SettingsPageGames> {
  //final GlobalKey<FormState> _gameform = GlobalKey<FormState>();
  late AuthProvider authProvider;
  late ProfileProvider profileProvider;
  var tempCategories = [];
  List<String> listOfChosenCategories = [];



  List<String> gameNames = [
    "Valorant",
    "League of Legends",
    "Apex Legends",
    "Overwatch 2",
    "Minecraft",
    "Fortnite"
  ];

  final List<bool> _selectedGames = <bool>[
    false,
    false,
    false,
    false,
    false,
    false
  ];

  bool vertical = false;
  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    profileProvider = context.read<ProfileProvider>();
    tempCategories = profileProvider.categories;
    for(var i=0; i<_selectedGames.length; i++){
      _selectedGames[i] = false;
      for (var j=0; j<tempCategories.length; j++){
        if(tempCategories[j] == gameNames[i]){
          _selectedGames[i] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.0),
        centerTitle: true,
        leading: InkWell(
          onTap: () async {
            for (var i = 0; i < _selectedGames.length; i++) {
              if (_selectedGames[i] == true) {
                listOfChosenCategories.add(gameNames[i]);
              }
            }
            await updateGames();
            if (!mounted) return;
            context.read<ProfileProvider>().setCategories(listOfChosenCategories);
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
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: ' Games'),
                  ],
                ),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            gameButton('valorant.jpg', 0),
            gameButton('lol.jpg', 1),
            gameButton('apexLegends.png', 2),
            gameButton('overwatch2.jpg', 3),
            gameButton('minecraft.jpeg', 4),
            gameButton('fortnite.jpg', 5),
          ],
        ),
      ),
    );
  }

  Widget gameButton(String gameImage, int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedGames[index] = !_selectedGames[index];
            });
          },
          child: Container(
            width: 100.0,
            height: 200.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/images/$gameImage"),
                colorFilter: _selectedGames[index] == true
                    ? null
                    : const ColorFilter.mode(Colors.black, BlendMode.hue),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _selectedGames[index] == true
                    ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    IconData(0xe156, fontFamily: 'MaterialIcons'),
                    color: Colors.green,
                    size: 45,
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future updateGames() async {
    String uid = authProvider.sub;
    final apiGames = "${ApiConstants.apiBaseUrl}/user/$uid";
    String token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final headers = ApiConstants.apiHeader(token ?? '');

    final data = {
      "categories": [listOfChosenCategories.toString()]
    };
    final encodedJson = jsonEncode(data);

    http.patch(Uri.parse(apiGames), headers: headers, body: encodedJson);
  }
}
