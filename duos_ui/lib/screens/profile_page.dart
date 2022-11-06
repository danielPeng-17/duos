import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const TextStyle nameStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const TextStyle descStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Image.asset(
          'assets/images/duosDefaultProfilePic.png',
          scale: 5,
        ),
      ),
      SizedBox(height: 50),
      Text(
          "${context.read<Profile>().firstName} ${context.read<Profile>().lastName}",
          style: nameStyle),
      SizedBox(height: 20),
      Text(context.read<Profile>().email),
      SizedBox(height: 20),
      Text(context.read<Profile>().location),
      SizedBox(height: 75),
      Text("asdasldlasdlewasdasjdkasdjlkas\ndaklsjdaslkjdaskldjasjdklaasda",
          style: descStyle),
      SizedBox(height: 50),
      Text("Pronouns: ${context.read<Profile>().gender}", style: descStyle),
      SizedBox(height: 50),
      Text("Dating Preference: ${context.read<Profile>().datingPref}",
          style: descStyle),
      SizedBox(height: 50),
      Text("Games: ${context.read<Profile>().games[0]}", style: descStyle)
    ]);
  }
}
