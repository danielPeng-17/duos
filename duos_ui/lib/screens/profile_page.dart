import 'dart:io';

import 'package:duos_ui/screens/profile_creation_age.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';
import 'package:duos_ui/widgets/games.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const TextStyle nameStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle descStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static const TextStyle descSmallStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.topCenter,
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(300),  for when user image is uploaded
              child: image == null
                  ? Image.asset(
                      'assets/images/duosDefaultProfilePic.png',
                      scale: 4,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(File(image!.path)),
                    ),
            ),
          ),
          Positioned(
              top: 200,
              right: 60,
              child: ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 200,
                      maxWidth: 200);
                  setState(() {
                    //update UI
                  });
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
                  // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.purple;
                    } // <-- Splash color
                  }),
                ),
                child: const Icon(Icons.upload),
              )),
          Positioned(
              top: 200,
              right: 15,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileCreationAge()));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
                  // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.purple;
                    } // <-- Splash color
                  }),
                ),
                child: const Icon(Icons.edit),
              )),
          Container(
            padding: EdgeInsets.only(top: 250),
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 0,
              color: Colors.blueGrey[50],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: SizedBox(
                width: 250,
                height: 75,
                child: Center(
                  child: Column(children: [
                    SizedBox(height: 10),
                    Text(
                        "${context.read<Profile>().firstName} ${context.read<Profile>().lastName}",
                        style: ProfilePage.nameStyle),
                    Text(context.read<Profile>().email),
                    Text(context.read<Profile>().location)
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 50),
      Card(
        elevation: 0,
        color: Colors.blueGrey[50],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SizedBox(
          width: 300,
          height: 50,
          child: Center(
            child: Column(children: [
              const SizedBox(height: 15),
              Text("Pronouns: ${context.read<Profile>().gender}",
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      Card(
        elevation: 0,
        color: Colors.blueGrey[50],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SizedBox(
          width: 300,
          height: 50,
          child: Center(
            child: Column(children: [
              const SizedBox(height: 15),
              Text("Hobbies: ${context.read<Profile>().hobbies}",
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      Card(
        elevation: 0,
        color: Colors.blueGrey[50],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SizedBox(
          width: 325,
          height: 50,
          child: Center(
            child: Column(children: [
              const SizedBox(height: 15),
              Text("Games: ${Games.listGames(context.read<Profile>().games)}",
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      Card(
        elevation: 0,
        color: Colors.blueGrey[50],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SizedBox(
          width: 300,
          height: 50,
          child: Center(
            child: Column(children: [
              const SizedBox(height: 15),
              Text("Dating Preference: ${context.read<Profile>().datingPref}",
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      Card(
        elevation: 0,
        color: Colors.blueGrey[50],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: SizedBox(
          width: 300,
          height: 150,
          child: Center(
            child: Column(children: [
              const SizedBox(height: 15),
              Text(context.read<Profile>().bio,
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      const SizedBox(height: 100)
    ]);
  }
}
