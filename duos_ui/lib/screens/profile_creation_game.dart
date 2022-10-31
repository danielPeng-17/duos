import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';

class ProfileCreationGame extends StatefulWidget {
  const ProfileCreationGame({Key? key}) : super(key: key);

  @override
  State<ProfileCreationGame> createState() => _ProfileCreationGameState();
}

class _ProfileCreationGameState extends State<ProfileCreationGame> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText:
                  'Search.... e.g. Valorant, League of Legends, Stardew Valley',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black.withOpacity(0),
                    onPrimary: Colors.black.withOpacity(0),
                    elevation: 20, // Elevation
                    shadowColor: Colors.black.withOpacity(0), // Shadow Color
                  ),
                  icon: Image.asset(
                      "assets/images/profile_creation_next.png",
                      width: 100,
                      height: 100),
                  label: Text(""),
                  onPressed: () {
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
    );
  }
}
