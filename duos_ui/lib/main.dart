import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duos_ui/screens/join_page.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/screens/container_page.dart';
import 'package:duos_ui/screens/chat_page.dart';
import 'package:duos_ui/providers/providers.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ChangeNotifierProvider<ContactsProvider>(
          create: (_) => ContactsProvider(firebaseFirestore: firebaseFirestore)),
      Provider<ChatProvider>(
          create: (_) => ChatProvider(firebaseFirestore: firebaseFirestore)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Duos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              foregroundColor: Colors.black,
            )),
        home: const RootPage()
        // home: ChatPage(arguments: ChatPageArguments(peerUid: "1234567", peerName: "Test Name", peerImg: "test")),
        );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error has occurred'));
          } else if (snapshot.hasData &&
              context.watch<ProfileProvider>().doneSetup == true) {
            return const ContainerPage();
          } else {
            return const JoinPage();
          }
        },
      ),
    );
  }
}
