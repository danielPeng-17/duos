import 'package:duos_ui/screens/profile_creation_bio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:duos_ui/providers/providers.dart';
import 'package:provider/provider.dart';

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
    context.read<ProfileProvider>().setSetupStatus(false);
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    dateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _ageform,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 120,
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
                  "Your birthday",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 140,
              ),
              TextFormField(
                controller: dateInput,
                validator: (value) {
                  if (value!.isEmpty) return 'Empty';
                  try {
                    DateFormat('yyyy-MM-dd').parse(value);
                  } on FormatException {
                    return 'Invalid Date';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.calendar_today),
                  ),
                  hintText: "Enter Date",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2099));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    if (!mounted) return;
                    context
                        .read<ProfileProvider>()
                        .setDateofBirth(formattedDate);
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
                        foregroundColor: Colors.black.withOpacity(0),
                        backgroundColor: Colors.black.withOpacity(0),
                        elevation: 20, // Elevation
                        shadowColor:
                            Colors.black.withOpacity(0), // Shadow Color
                      ),
                      icon: Image.asset(
                          "assets/images/profile_creation_next.png",
                          width: 80,
                          height: 80),
                      label: const Text(""),
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
