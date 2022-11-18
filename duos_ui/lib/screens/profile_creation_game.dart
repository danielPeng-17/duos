import 'package:duos_ui/screens/profile_creation_name.dart';
import 'package:duos_ui/widgets/games.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';

class ProfileCreationGame extends StatefulWidget {
  const ProfileCreationGame({Key? key}) : super(key: key);

  @override
  State<ProfileCreationGame> createState() => _ProfileCreationGameState();
}

class _ProfileCreationGameState extends State<ProfileCreationGame> {
  //final GlobalKey<FormState> _gameform = GlobalKey<FormState>();

  List<Widget> games = <Widget>[
    Text('Valorant'),
    Text('LoL'),
    Text('Apex Legends'),
    Text('Overwatch')
  ];

  List<String> gameNames = [
    "Valorant",
    "LoL",
    "Apex Legends",
    "Overwatch"
  ];

  final List<bool> _selectedGames = <bool>[false, false, false, false];

  bool vertical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: 250,
                height: 100,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: Icon(
                        Icons.create_sharp,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                    TextSpan(text: ' Profile Creation'),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Favourite Games?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Text("", style: TextStyle(fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  // All buttons are selectable.
                  setState(() {
                    _selectedGames[index] = !_selectedGames[index];
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.grey,
                selectedColor: Colors.black,
                fillColor: Colors.grey[300],
                color: Colors.black,
                constraints: const BoxConstraints(
                  minHeight: 60.0,
                  minWidth: 80.0,
                ),
                isSelected: _selectedGames,
                children: games,
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            //   child: TextFormField(
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return '';
            //       }
            //     },
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText:
            //           'Search.... e.g. Valorant, League of Legends, Stardew Valley',
            //     ),
            //   ),
            // ),
            SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0),
                        onPrimary: Colors.black.withOpacity(0),
                        elevation: 20, // Elevation
                        shadowColor:
                            Colors.black.withOpacity(0), // Shadow Color
                      ),
                      icon: Image.asset(
                          "assets/images/profile_creation_next.png",
                          width: 100,
                          height: 100),
                      label: Text(""),
                      onPressed: () {
                        var index = 0;
                        List<Games> listofchosengames = [];
                        List<String> listOfChosenCategories = [];
                        for (var selected in _selectedGames) {
                          if (selected == true) {
                            listofchosengames.add(allGames[index]);
                            listOfChosenCategories.add(gameNames[index]);
                          }
                          index++;
                        }
                        print(listOfChosenCategories);
                        context.read<Profile>().setCategories(listOfChosenCategories);
                        context.read<Profile>().setGames(listofchosengames);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfileCreationName()));

                        // Validate returns true if the form is valid, or false otherwise.
                        // if (_formKey.currentState!.validate()) {
                        //   // If the form is valid, display a snackbar. In the real world,
                        //   // you'd often call a server or save the information in a database.
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Processing Data')),
                        //   );
                        // }
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
