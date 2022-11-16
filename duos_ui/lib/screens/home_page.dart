import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  dynamic _currentProfile;
  static const List _profiles = [
    {
      "categories": ["valorant", "Apex Legends"],
      "info": {
        "bio": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac"
            " maximus justo, nec vestibulum turpis. Pellentesque mollis eget lore"
            "m sed viverra. Ut convallis leo a fermentum fermentum.",
        "date_of_birth": "2000-04-23",
        "first_name": "FirstName",
        "last_name": "LastName",
        "gender": "Female",
        "profile_picture_url": "https://images.unsplash.com/photo-1506691318991-c91e"
            "7df669b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG9"
            "0by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w"
            "=673&q=80",
        "location": "Toronto, Ontario",
      },
      "matches": [],
      "uuid": "8OTxBd5tLeMxzdvnkUBOt861V5g1",
    },
    {
      "categories": ["Minecraft", "Overwatch"],
      "info": {
        "bio": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac"
            " maximus justo, nec vestibulum turpis. Pellentesque mollis eget lore"
            "m sed viverra. Ut convallis leo a fermentum fermentum.",
        "date_of_birth": "2001-04-23",
        "first_name": "FirstName2",
        "last_name": "LastName2",
        "gender": "Male",
        "profile_picture_url": "https://images.unsplash.com/photo-1542751371-a"
            "dc38448a05e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8"
            "fHx8&auto=format&fit=crop&w=1470&q=80",
        "location": "Markham, Ontario",
      },
      "matches": [],
      "uuid": "z8wbVHhaQfPq1KDnX1iwqprG8DR2",
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentProfile = _profiles[_currentIndex];
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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1506691318991-c91e"
                              "7df669b1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG9"
                              "0by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w"
                              "=673&q=80"),
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
                                children: const [
                                  Text(
                                    "Firstname, Age",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Toronto, Ontario",
                                    style: TextStyle(
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
                                  fontSize: 20,
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
                            child: const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac maximus justo, nec vestibulum turpis. Pellentesque mollis eget lorem sed viverra. Ut convallis leo a fermentum fermentum.",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
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
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            margin: EdgeInsets.only(left: 10,right: 10,),
                            child: Wrap(
                              children: [
                                Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.blue.withOpacity(0.25)
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7 ),
                                      child: Text("Valorant", style: TextStyle(fontFamily: "ProximaNova-Regular",
                                          fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400
                                      ),),
                                    )
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.orange.withOpacity(0.25)
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7 ),
                                      child: Text("Apex Legends", style: TextStyle(fontFamily: "ProximaNova-Regular",
                                          fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400
                                      ),),
                                    )
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: Colors.pink.withOpacity(0.25)
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7 ),
                                      child: Text("Minecraft", style: TextStyle(fontFamily: "ProximaNova-Regular",
                                          fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400
                                      ),),
                                    )
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
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
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac maximus justo, nec vestibulum turpis. Pellentesque mollis eget lorem sed viverra. Ut convallis leo a fermentum fermentum.",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
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
                left: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex += 1;
                    });
                  },
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
              right: MediaQuery.of(context).size.width * 0.25,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex += 1;
                  });
                },
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
}
