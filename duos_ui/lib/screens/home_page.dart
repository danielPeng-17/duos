import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loading_indicator/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _profiles = Queue<dynamic>();
  final dynamic user = FirebaseAuth.instance.currentUser!;

  dynamic _currentProfile;
  bool loading = true;
  bool existingMatches = false;
  String? token = "";

  @override
  void initState() {
    user.getIdTokenResult(true).then((result) {
      token = result.token;
      _getProfiles().then((profiles) {
          _profiles.addAll(profiles);
          if (_profiles.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                _currentProfile = _profiles.removeFirst();
                existingMatches = true;
                loading = false;
              });
            });
          } else {
            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                existingMatches = false;
                loading = false;
              });
            });
          }
      });
    });
    super.initState();
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
      body: (existingMatches && !loading)
          ? Container(
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(_currentProfile["info"]
                                    ["profile_picture_url"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _currentProfile["info"]
                                                  ["first_name"] +
                                              " " +
                                              _currentProfile["info"]
                                                  ["last_name"],
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
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
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
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
            )
          : (loading
              ? Container(
                  alignment: Alignment.center,
                  child: const LoadingIndicator(
                      indicatorType: Indicator.pacman,
                      colors: [
                        Colors.yellow,
                        Colors.orange,
/*                        Colors.purple,
                        Colors.pink,
                        Colors.red,
                        Colors.yellow*/
                      ],
                      strokeWidth: 2,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.transparent),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: const Text(
                    "No more matches",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
    );
  }

  Future _getProfiles() async {
    final String uid = user.uid;
    final apiGetProfilesEndpoint = "http://10.0.2.2:3000/matching/$uid";
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    try {
      final res =
          await http.get(Uri.parse(apiGetProfilesEndpoint), headers: headers);
      return jsonDecode(res.body);
    } catch (err) {
      // ignore
    }
  }

  Future postLikeProfile() async {
    final String uid = user.uid;
    final apiMatchingEndpoint =
        "http://10.0.2.2:3000/matching/$uid/like/${_currentProfile["uid"]}";
    final headers = {
      "Content-type": 'application/json',
      "Authorization": token ?? '',
    };
    try {
      final res =
          await http.post(Uri.parse(apiMatchingEndpoint), headers: headers);
      return res.body;
    } catch (err) {
      // ignore
    }
  }

  void likeProfile() async {
    var result = await postLikeProfile();
    var resultDecoded = jsonDecode(result);
    if (resultDecoded["matched"] == true) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            content: const Text('Matched!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }
    setState(() {
      if (_profiles.isNotEmpty) {
        _currentProfile = _profiles.removeFirst();
      } else {
        _currentProfile = {};
        existingMatches = false;
      }
    });
  }

  void skipProfile() {
    setState(() {
      if (_profiles.isNotEmpty) {
        _profiles.addLast(_currentProfile);
        _currentProfile = _profiles.removeFirst();
      } else {
        _currentProfile = {};
        existingMatches = false;
      }
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
