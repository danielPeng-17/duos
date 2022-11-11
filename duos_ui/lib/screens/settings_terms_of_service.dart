import 'package:flutter/material.dart';

class SettingsPageTOS extends StatefulWidget {
  const SettingsPageTOS({Key? key}) : super(key: key);

  @override
  State<SettingsPageTOS> createState() => _SettingsPageTOSState();
}

class _SettingsPageTOSState extends State<SettingsPageTOS> {
  final GlobalKey<FormState> _contactform = GlobalKey<FormState>();

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
          key: _contactform,
          child: ListView(
            //Listview is a fix in order to prevent overflow, (scrollable) works well needs formatting
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[

                      TextSpan(text: ' Terms of Service'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("1. Acceptance of Terms of Use Agreement",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("Not our problem ",
                    style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("2. Eligibility",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("Please be of age ",
                    style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("3. Your Account",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("Not our problem ",
                    style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("4. Safety; Your Interactions with Other Members",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("At your own risk ",
                    style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
