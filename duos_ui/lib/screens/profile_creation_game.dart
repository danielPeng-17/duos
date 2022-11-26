import 'package:flutter/material.dart';
import 'package:duos_ui/providers/providers.dart';
import 'package:duos_ui/screens/profile_creation_picture.dart';
import 'package:provider/provider.dart';

class ProfileCreationGame extends StatefulWidget {
  const ProfileCreationGame({Key? key}) : super(key: key);

  @override
  State<ProfileCreationGame> createState() => _ProfileCreationGameState();
}

class _ProfileCreationGameState extends State<ProfileCreationGame> {
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
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //   child: Text.rich(
            //     TextSpan(
            //       children: <InlineSpan>[
            //         WidgetSpan(
            //           child: Icon(
            //             Icons.create_sharp,
            //             color: Colors.black,
            //             size: 25,
            //           ),
            //         ),
            //         TextSpan(text: ' Profile Creation'),
            //       ],
            //     ),
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            const Center(
              child: Text(
                "You favourite games",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            gameButton('valorant.jpg', 0),
            gameButton('lol.jpg', 1),
            gameButton('apexLegends.png', 2),
            gameButton('overwatch2.jpg', 3),
            gameButton('minecraft.jpeg', 4),
            gameButton('fortnite.jpg', 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: () {
                  List<String> listOfChosenCategories = [];

                  for (var i = 0; i < _selectedGames.length; i++) {
                    if (_selectedGames[i] == true) {
                      listOfChosenCategories.add(gameNames[i]);
                    }
                  }
                  context
                      .read<ProfileProvider>()
                      .setCategories(listOfChosenCategories);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileCreationPicture()));

                  // Validate returns true if the form is valid, or false otherwise.
                  // if (_formKey.currentState!.validate()) {
                  //   // If the form is valid, display a snackbar. In the real world,
                  //   // you'd often call a server or save the information in a database.
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Processing Data')),
                  //   );
                  // }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
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
