import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            // Text('Duos'),
            Image.asset('assets/images/duosBlackLogo.png', fit: BoxFit.contain, height: 60),
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
      bottomNavigationBar: const CustomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Shang Chi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                  'https://wegotthiscovered.com/wp-content/uploads/2021/09/simu-reddit-e1631092903317.jpeg'),
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
            // const Text(
            //   'Signed In as',
            //   style: TextStyle(fontSize: 16),
            // ),
            // const SizedBox(height: 8),
            // Text(
            //   user.email!,
            //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 50),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
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
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
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
              ],
            ),
            // ElevatedButton.icon(
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: const Size.fromHeight(50)),
            //   icon: const Icon(Icons.arrow_back, size: 32),
            //   label: const Text(
            //     'Sign Out',
            //     style: TextStyle(fontSize: 24),
            //   ),
            //   onPressed: () => FirebaseAuth.instance.signOut(),
            // ),
          ],
        ),
      ),
    );
  }
}
