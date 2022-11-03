import 'package:duos_ui/screens/profile_creation_bio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';

class ProfileCreationAge extends StatefulWidget {
  const ProfileCreationAge({Key? key}) : super(key: key);

  @override
  State<ProfileCreationAge> createState() => _ProfileCreationAgeState();
}

class _ProfileCreationAgeState extends State<ProfileCreationAge> {
  final GlobalKey<FormState> _ageform = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Form(
          key: _ageform,
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
                child: Text("What is your age?",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: dateInput,
                validator: (value) {
                  if (value!.isEmpty) return 'Empty';
                  try {
                    DateFormat('yyyy-MM-dd').parse(value!);
                  } on FormatException {
                    return 'Invalid Date';
                  }
                  return null;
                },
                //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2030));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);

                    context.read<Profile>().setDateofBirth(formattedDate);
                    //formatted date output using intl package =>  2021-03-16

                    //no longer need to use default state, can use provider ^ above
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
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
                        if (_ageform.currentState!.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ProfileCreationBio()));
                        }
                        // Validate returns true if the form is valid, or false otherwise.
                        // if (_formKey.currentState!.validate()) {
                        //   // If the form is valid, display a snackbar. In the real world,
                        //   // you'd often call a server or save the information in a database.
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Processing Data')),
                        //   );
                        // }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
