import 'package:flutter/material.dart';
import 'package:duos_ui/providers/providers.dart';
import 'package:duos_ui/screens/profile_creation_picture.dart';
import 'package:provider/provider.dart';

class SettingsPageGames extends StatefulWidget {
  const SettingsPageGames({Key? key}) : super(key: key);

  @override
  State<SettingsPageGames> createState() => _SettingsPageGamesState();
}

class _SettingsPageGamesState extends State<SettingsPageGames> {
  //final GlobalKey<FormState> _gameform = GlobalKey<FormState>();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.0),
        centerTitle: true,
        leading: InkWell(
          onTap: () async {

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
}
