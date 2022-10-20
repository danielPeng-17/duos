import 'package:flutter/material.dart';

class ProfileCreationName extends StatefulWidget {
  const ProfileCreationName({Key? key}) : super(key: key);

  @override
  State<ProfileCreationName> createState() => _ProfileCreationNameState();
}

class _ProfileCreationNameState extends State<ProfileCreationName> {
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
          child: Text("What is your name?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your first name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your last name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
              child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              // if (_formKey.currentState!.validate()) {
              //   // If the form is valid, display a snackbar. In the real world,
              //   // you'd often call a server or save the information in a database.
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Processing Data')),
              //   );
              // }
            },
            child: const Text('Next'),
          )),
        ),
      ],
    );
  }
}
