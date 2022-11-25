import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class SettingsPageGames extends StatefulWidget {
  const SettingsPageGames({Key? key}) : super(key: key);

  @override
  State<SettingsPageGames> createState() => _SettingsPageGamesState();
}

class _SettingsPageGamesState extends State<SettingsPageGames> {
  final GlobalKey<FormState> _settingsForm = GlobalKey<FormState>();
  final TextEditingController _gameInput = TextEditingController();
  final TextEditingController _ageInput = TextEditingController();
  final TextEditingController _genderInput = TextEditingController();
  final TextEditingController _ethnicityInput = TextEditingController();
  String genderDropDown = '';
  String ethnicityDropDown = '';
  String ageMinDropDown = '';
  String ageMaxDropDown = '';
  List<Widget> games = <Widget>[
    Text('Valorant'),
    Text('LoL'),
    Text('Stardew'),
    Text('Overwatch')
  ];

  final List<bool> _selectedGames = <bool>[false, false, false, false];

  bool vertical = false;

  var genders = [
    'Men',
    'Women',
    'Both men and women'
  ];


  var ethnicities = [
    'East Asian',
    'American Indian',
    'Black/African Descent',
    'Hispanic/Latino',
    'Middle Eastern',
    'Pacific Islander',
    'South Asian',
    'Southeast Asian',
    'White/Caucasian',
    'Other',
    'Open to all'
  ];

  var ages = [
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
  ];

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
          key: _settingsForm,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Favourite games", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Age Range (min - max)", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: DropdownButton(
                                  value: ageMinDropDown.isNotEmpty ? ageMinDropDown : null, //get gender from user
                                  items: ages.map((String age) {
                                    return DropdownMenuItem(
                                      value: age,
                                      child: Text(age),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue){
                                    setState((){
                                      ageMinDropDown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: DropdownButton(
                                  value: ageMaxDropDown.isNotEmpty ? ageMaxDropDown : null, //get gender from user
                                  items: ages.map((String age) {
                                    return DropdownMenuItem(
                                      value: age,
                                      child: Text(age),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue){
                                    setState((){
                                      ageMaxDropDown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
