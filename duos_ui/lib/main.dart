import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:duos_ui/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:duos_ui/screens/join_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
        primarySwatch: Colors.purple,
      ),
      home: const RootPage(),
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
          if (snapshot.hasData) {
            // temporary, replace with HomePage when it is complete
            return const LoginPage();
          } else {
            return const JoinPage();
          }
        },
      ),
    );
  }
}