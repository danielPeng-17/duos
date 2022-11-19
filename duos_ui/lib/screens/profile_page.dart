import 'dart:io';

import 'package:duos_ui/screens/profile_creation_age.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

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
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.topCenter,
            child: ClipRRect(
              child: context.watch<ProfileProvider>().profilePicPath == ''
                  ? CircleAvatar(
                      radius: 110,
                      backgroundImage: NetworkImage(
                        context.watch<ProfileProvider>().profilePicURL.toString()
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                          File(context.watch<ProfileProvider>().profilePicPath)),
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
                  if (image != null) {
                    if (!mounted) return;
                    context.watch<ProfileProvider>().setProfilePicPath(image!.path);
                  }
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => const ProfileCreationAge()))
                      .then((_) => setState(
                            //This is done to refresh the profile page upon return from editing
                            () {},
                          ));
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
            padding: const EdgeInsets.only(top: 250),
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
                        "${context.watch<ProfileProvider>().firstName} ${context.watch<ProfileProvider>().lastName}",
                        style: ProfilePage.nameStyle),
                    Text(context.watch<ProfileProvider>().email),
                    Text(context.watch<ProfileProvider>().location)
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
              Text("Pronouns: ${context.watch<ProfileProvider>().gender}",
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
              Text("Hobbies: ${context.watch<ProfileProvider>().hobbies}",
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      // TODO: fix games => types from backend does not match up with the profile provider
      // Card(
      //   elevation: 0,
      //   color: Colors.blueGrey[50],
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(15))),
      //   child: SizedBox(
      //     width: 325,
      //     height: 50,
      //     child: Center(
      //       child: Column(children: [
      //         const SizedBox(height: 15),
      //         Text("Games: ${Games.listGames(context.watch<Profile>().games)}",
      //             style: ProfilePage.descSmallStyle)
      //       ]),
      //     ),
      //   ),
      // ),
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
              Text("Dating Preference: ${context.watch<ProfileProvider>().datingPref}",
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
              Text(context.watch<ProfileProvider>().bio,
                  style: ProfilePage.descSmallStyle)
            ]),
          ),
        ),
      ),
      const SizedBox(height: 100)
    ]);
  }
}
