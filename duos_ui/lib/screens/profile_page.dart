import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/providers/providers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const TextStyle nameStyle =
      TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white);

  static const TextStyle headerStyle =
      TextStyle(fontSize: 16, color: Colors.white);

  static const TextStyle descSmallStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 80),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // ============== option 1
                      // Color(0xff9e768f),
                      // Color(0xff9fa4c4),
                      // ============== option 2
                      // Color(0xff2E4057),
                      // Color(0xffDBCBD8),
                      // ============== option 3
                      Color(0xffA1BAFE),
                      Color(0xff8D5185),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      child:
                          context.watch<ProfileProvider>().profilePicPath == ''
                              ? CircleAvatar(
                                  radius: 110,
                                  backgroundImage: NetworkImage(context
                                      .watch<ProfileProvider>()
                                      .profilePicURL
                                      .toString()),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(File(context
                                      .watch<ProfileProvider>()
                                      .profilePicPath)),
                                ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 35),
                      child: Column(
                        children: [
                          Text(
                              "${context.watch<ProfileProvider>().firstName} ${context.watch<ProfileProvider>().lastName}",
                              style: ProfilePage.nameStyle),
                          const Padding(padding: EdgeInsets.only(top: 7)),
                          Text(
                            context.watch<ProfileProvider>().email,
                            style: ProfilePage.headerStyle,
                          ),
                          Text(
                            context.watch<ProfileProvider>().location,
                            style: ProfilePage.headerStyle,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 35, bottom: 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoTile(
                              "My Bio", context.watch<ProfileProvider>().bio),
                          infoTile("Dating Preferences",
                              context.watch<ProfileProvider>().datingPref),
                          infoTile("Hobbies",
                              context.watch<ProfileProvider>().hobbies),
                          const Text(
                            "Favourite Games",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Wrap(
                              spacing: 10.0,
                              children: context
                                  .watch<ProfileProvider>()
                                  .categories
                                  .map<Widget>(
                                      (category) => gameBubble(category))
                                  .toList(),
                            ),
                          ),
                          infoTile("Languages",
                              context.watch<ProfileProvider>().languages),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoTile(String heading, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 25),
          child: Text(description, style: ProfilePage.descSmallStyle),
        ),
      ],
    );
  }

  Widget gameBubble(String title) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blue.withOpacity(0.25)),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
