import 'dart:collection';
import 'package:duos_ui/constants/api_constants.dart';
import 'package:duos_ui/widgets/game_bubble.dart';
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
            if (!mounted) return;
            setState(() {
              _currentProfile = _profiles.removeFirst();
              existingMatches = true;
              loading = false;
            });
          });
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (!mounted) return;
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ShaderMask(
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.black
                                      ],
                                      stops: [0, 0.8, 0.95],
                                    ).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child:
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height,
                                          width: MediaQuery.of(context).size.width,
                                          child: Image.network(
                                              _currentProfile["info"]
                                              ["profile_picture_url"],
                                              fit: BoxFit.cover),
                                        ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _currentProfile["info"]["first_name"] +
                                            " " +
                                            _currentProfile["info"]
                                                ["last_name"],
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        _currentProfile["info"]["location"],
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: const TextStyle(
                                            fontSize: 18,
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
                                    spacing: 6.0,
                                    runSpacing: 6.0,
                                    children: _currentProfile["categories"]
                                        .map<Widget>((category) =>
                                            GameBubble(title: category))
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
                    ),
                  ),
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
                  margin: const EdgeInsets.only(left: 150, right: 150),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin,
                        colors: [
                          Colors.black,
                        ],
                        strokeWidth: 4,
                        backgroundColor: Colors.transparent,
                        pathBackgroundColor: Colors.transparent,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const Text(
                          "Loading . . .",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
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
        "${ApiConstants.apiBaseUrl}/matching/$uid/like/${_currentProfile["uid"]}";
    final headers = ApiConstants.apiHeader(token ?? '');

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
    if (!mounted) return;
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
    if (!mounted) return;
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
