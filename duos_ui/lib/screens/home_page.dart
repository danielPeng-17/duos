import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? token = "";
  final dynamic user = FirebaseAuth.instance.currentUser!;
  dynamic _currentProfile;
  dynamic _profiles = [];
  // static const List _profiles = [
  //   {
  //     "categories": ["Valorant", "Apex Legends"],
  //     "info": {
  //       "bio": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac"
  //           " maximus justo, nec vestibulum turpis. Pellentesque mollis eget lore"
  //           "m sed viverra. Ut convallis leo a fermentum fermentum.",
  //       "date_of_birth": "2000-04-23",
  //       "first_name": "FirstName",
  //       "last_name": "LastName",
  //       "gender": "Female",
  //       "profile_picture_url":
  //           "https://images.unsplash.com/photo-1506691318991-c91e"
  //               "7df669b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG9"
  //               "0by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w"
  //               "=673&q=80",
  //       "location": "Toronto, Ontario",
  //       "hobbies":
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac"
  //               " maximus justo, nec vestibulum turpis. Pellentesque mollis eget lore"
  //               "m sed viverra. Ut convallis leo a fermentum fermentum."
  //     },
  //     "matches": [],
  //     "uuid": "8OTxBd5tLeMxzdvnkUBOt861V5g1",
  //   },
  //   {
  //     "categories": ["Minecraft", "Overwatch"],
  //     "info": {
  //       "bio": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac"
  //           " maximus justo, nec vestibulum turpis. Pellentesque mollis eget lore"
  //           "m sed viverra. Ut convallis leo a fermentum fermentum.",
  //       "date_of_birth": "2001-04-23",
  //       "first_name": "FirstName2",
  //       "last_name": "LastName2",
  //       "gender": "Male",
  //       "profile_picture_url": "https://images.unsplash.com/photo-1542751371-a"
  //           "dc38448a05e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8"
  //           "fHx8&auto=format&fit=crop&w=1470&q=80",
  //       "location": "Markham, Ontario",
  //       "hobbies":
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac"
  //               " maximus justo, nec vestibulum turpis. Pellentesque mollis eget lore"
  //               "m sed viverra. Ut convallis leo a fermentum fermentum."
  //     },
  //     "matches": [],
  //     "uuid": "z8wbVHhaQfPq1KDnX1iwqprG8DR2",
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    user.getIdTokenResult(true).then((result) {
      token = result.token;
      _getProfiles().then((profiles){
        _profiles = profiles;
        _currentProfile = _profiles[_currentIndex];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/duosBlackLogo.png',
            fit: BoxFit.contain, height: 60),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Adjust preferences',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Preferences'),
                      ),
                      body: const Center(
                        child: Text(
                          'Preference setting page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_currentProfile["info"]["profile_picture_url"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentProfile["info"]["first_name"] +
                                        " " +
                                        _currentProfile["info"]["last_name"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    _currentProfile["info"]["location"],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              "About Me",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Text(
                              _currentProfile["info"]["bio"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              "Favourite Games",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Wrap(
                              spacing: 10.0,
                              children: _currentProfile["categories"]
                                  .map<Widget>((category) =>
                                      _GameBubble(title: category))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              "Hobbies",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Text(
                              _currentProfile["info"]["hobbies"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 90,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: MediaQuery.of(context).size.width * 0.03,
                child: ElevatedButton(
                  onPressed: () => skipProfile(),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(18),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.75)),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.red;
                        }
                        return null;
                      },
                    ),
                  ),
                  child: const Icon(Icons.close),
                )),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.width * 0.03,
              child: ElevatedButton(
                onPressed: () => likeProfile(),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const CircleBorder(),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(18),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.black.withOpacity(0.75),
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      return null;
                    },
                  ),
                ),
                child: const Icon(Icons.videogame_asset_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getProfiles() async {
    final String uid = user.uid;
    String? token;
    final apiGetProfilesEndpoint = "http://10.0.2.2:3000/matching/$uid}";
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    try {
      final res = await http.put(Uri.parse(apiGetProfilesEndpoint), headers: headers);
      return jsonDecode(res.body);
    } catch (err) {
      // ignore
    }
  }

  Future postLikeProfile() async {
    final String uid = user.uid;
    final apiMatchingEndpoint = "http://10.0.2.2:3000/matching/$uid/like/${_currentProfile["uid"]}";
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    try {
      final res = await http.put(Uri.parse(apiMatchingEndpoint), headers: headers);
    } catch (err) {
      // ignore
    }
  }

  void likeProfile() async {
    await postLikeProfile();
    setState(() {
      _currentIndex += 1;
      if (_currentIndex > _profiles.length - 1) {
        _currentIndex = 0;
        // put a snackbar indicating it refreshed
      }
      _currentProfile = _profiles[_currentIndex];
    });
  }

  void skipProfile() {
    setState(() {
      _currentIndex += 1;
      if (_currentIndex > _profiles.length - 1) {
        _currentIndex = 0;
        // put a snackbar indicating it refreshed
      }
      _currentProfile = _profiles[_currentIndex];
    });
  }
}

class _GameBubble extends StatelessWidget {
  const _GameBubble({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blue.withOpacity(0.25)),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
