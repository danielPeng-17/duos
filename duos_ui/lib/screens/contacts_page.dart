import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
        // Text('Duos'),
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
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Stack(
    //       children: <Widget>[
    //         ListView(
    //           children: [
    //             const Text(
    //               'MESSAGES',
    //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(
    //               height: 15,
    //             ),
    //             //CONTACT 1
    //             const SizedBox(
    //               height: 15,
    //             ),
    //             //contact 2
    //             const SizedBox(height: 50),
    //
    //           ],
    //         ),
    //
    //       ],
    //     ),
    //   ),
    // );
      body: ListView.builder(itemCount: 2, itemBuilder: (context, index) {
        return Slidable(
          key: const ValueKey(0),
          groupTag: 0,
          endActionPane: ActionPane(
            motion: BehindMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                onPressed: (context) => print("hi"),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.report,
                label: 'Report',
              ),
              SlidableAction(
                flex: 2,
                onPressed: (context) => print("hi"),
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'delete',
              ),
              SlidableAction(
                flex: 2,
                onPressed: (context) => print("hi"),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.mail,
                label: 'Unread',
              ),
            ],
          ),
          child: buildUserListTile(),
        );
      }),
    );
  }
  Widget buildUserListTile() => ListTile(
    contentPadding: const EdgeInsets.all(10),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage('https://scontent-ord5-2.cdninstagram.com/v/t51.2885-19/313390331_2356829467815590_1024991815729709224_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-ord5-2.cdninstagram.com&_nc_cat=102&_nc_ohc=z2JjID7bZ8gAX-NBKm9&tn=FxfBeXjfe6p1DrfU&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAeWp97B9IODGLwlh2sYUZk7RvJ7sC7_upfEr9CCGAHQA&oe=637977E3&_nc_sid=1527a3'),
      backgroundColor: Colors.transparent,
    ),
    title: Text("Lunazoul"),
    subtitle: Text("sup - 15m"),
  );
}