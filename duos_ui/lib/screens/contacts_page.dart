import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duos_ui/screens/container_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//--------------------sample
class User {
  String name;
  String lastMsg;
  String image;
  bool unread;

  User({
    required this.name,
    required this.lastMsg,
    required this.image,
    required this.unread,
  });
}
List<User> users = [
  User(
      name: "Lunazoul",
      lastMsg: "Im hot asf",
      image: "https://dawsonvo.ca/daslkjlkfadsjflajslkj2134lkj234.png",
      unread: true,

  ),
  User(
      name: "Jesus",
      lastMsg: "hi im jesus",
      image: "https://i.pinimg.com/originals/84/97/68/849768009d5792d5d83c1bb6e0b3572d.jpg",
      unread: false,
  ),
  User(
    name: "Discord kitten",
    lastMsg: "Follow me on instagram @lunazoul",
    image: "https://dawsonvo.ca/20220529_035718927_iOS.png",
    unread: true,
  ),
  User(
  name: "Discord kitten2",
  lastMsg: "wanna buy me nitro",
  image: "https://dawsonvo.ca/asdlkhgskldjfsdoliu32109.JPG",
  unread: false,
  ),
  User(
    name: "Discord mod",
    lastMsg: "hey you want nitro?",
    image: "https://img.ifunny.co/images/38b99393f90225ae7cb9638593799791b3a88f9224007323e8d0e798e484e5b6_1.jpg",
    unread: false,
  )
];
//-----------------------sample

enum Actions {delete, report, unread}
class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}
class _ContactsPageState extends State<ContactsPage> {
  //const ContactsPage({super.key});
  final _searchFieldController = TextEditingController();
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
      body:

      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              controller: _searchFieldController,
              onChanged: (value) { //debug print text
                setState(() { // reloads tile list
                  print(_searchFieldController.text.toLowerCase());
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () { //debug print text
                    setState(() { //reloads tile list
                      _searchFieldController.clear();
                      //print(_searchFieldController.text.toLowerCase());
                    });
                  },
                )
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child:
            ListView.builder(itemCount: users.length, itemBuilder: (context, index) { //idk build off user info
              final user = users[index];
              return user.name.toLowerCase().contains(_searchFieldController.text.toLowerCase())?
                Slidable(
                key: const ValueKey(0),
                groupTag: 0,
                endActionPane: ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlidableAction(
                      padding: EdgeInsets.all(2),
                      spacing: 15,
                      onPressed: (context) => _onDismissed(index, Actions.delete),
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      padding: EdgeInsets.all(2),
                      spacing: 15,
                      onPressed: (context) => _onDismissed(index, Actions.report),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.report,
                      label: 'Report',
                    ),
                    SlidableAction(
                      padding: EdgeInsets.all(2),
                      spacing: 15,
                      onPressed: (context) => _onDismissed(index, Actions.unread),
                      backgroundColor: Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.mail,
                      label: 'Unread',
                    ),
                  ],
                ),
                child: buildUserListTile(user), //pass user info in
              )
              : Container();
            }),
          ),
        ],
      )


    );
  }

  // BUILD EACH CONTACT
  Widget buildUserListTile(User user) => ListTile( //buildUserListTile(User user) for input info
    contentPadding: const EdgeInsets.only(left: 30.00),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(user.image),
      backgroundColor: Colors.transparent,
    ),
    title: Text(user.name),
    subtitle: Text(user.lastMsg, //user.unread? "Unread" : "Unread",
      style: TextStyle(
          fontWeight: user.unread? FontWeight.bold : FontWeight.normal,
          color: user.unread? Colors.black : Color(0xFF3d3d3d),
      ),
    ),
    onTap: () {
      setState(() {
        user.unread = false;
      });
    }
  );
  void _onDismissed(int index, Actions action) {
    final user = users[index];
    switch (action) {
      case Actions.delete:
        setState(() {
          users.removeAt(index);
        });
        _showSnackBar(context, "Deleted", Colors.red);
        break;
      case Actions.unread:
        setState(() {
          users[index].unread=true;
        });
        _showSnackBar(context, "Unread", Colors.blue);
        break;
      case Actions.report:
        _showSnackBar(context, "Reported ${user.name}", Colors.blue);
        break;
    }
  }
  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}