import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: SingleChildScrollView(
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
                height: MediaQuery.of(context).size.height * 0.7,
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
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      child: Container(
                        margin: const EdgeInsets.all(15),
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
          ],
        )),
      ),
    );

/*    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Image.asset('assets/images/duosBlackLogo.png',
                fit: BoxFit.contain, height: 60),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Adjust preferences',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
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
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: <Widget>[
            ListView(
              children: [
                const Text(
                  'Shang Chi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                      'https://imagesvc.meredithcorp.io/v3/mm/image?q=60&c=sc&rect=0%2C54%2C1997%2C1053&poi=face&w=1997&h=999&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2021%2F09%2F07%2FGettyImages-488099013.jpg'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                      'https://etcanada.com/wp-content/uploads/2021/08/GettyImages-493170697.jpg?quality=80&strip=all'),
                ),
                const SizedBox(height: 50),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(22)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(0.75)),
                  // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red;
                    } // <-- Splash color
                  }),
                ),
                child: const Icon(Icons.close),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(22)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(0.75)),
                  // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    } // <-- Splash color
                  }),
                ),
                child: const Icon(Icons.videogame_asset_rounded),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
