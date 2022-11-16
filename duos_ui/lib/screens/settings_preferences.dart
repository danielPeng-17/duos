import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';

class SettingsPagePreferences extends StatefulWidget {
  const SettingsPagePreferences({Key? key}) : super(key: key);

  @override
  State<SettingsPagePreferences> createState() => _SettingsPagePreferencesState();
}

class _SettingsPagePreferencesState extends State<SettingsPagePreferences> {
  final GlobalKey<FormState> _settingsform = GlobalKey<FormState>();
  TextEditingController descInput = TextEditingController();
  TextEditingController hobbiesInput = TextEditingController();
  TextEditingController languagesInput = TextEditingController();
  TextEditingController pronounsInput = TextEditingController();
  TextEditingController locationInput = TextEditingController();

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
          key: _settingsform,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[

                      TextSpan(text: ' Preferences'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Game List", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: descInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load game list',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Age Range", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical:3),
                child: TextFormField(
                  controller: hobbiesInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load age range',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("I'm interested in", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: languagesInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load gender interest',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Gender", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: pronounsInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load user gender',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Ethnicity", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                child: TextFormField(
                  controller: locationInput,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '-';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Load preferred ethnicities',
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
                      onPressed: () {},
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
}
