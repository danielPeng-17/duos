import 'package:duos_ui/providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:duos_ui/screens/join_page.dart';
import 'package:provider/provider.dart';
import 'package:duos_ui/screens/container_page.dart';
import 'package:duos_ui/screens/profile_creation_picture.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Profile())],
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
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            foregroundColor: Colors.black,
          )),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error has occurred'));
          } else if (snapshot.hasData) {
            return const ProfileCreationPicture();
          } else {
            return const JoinPage();
          }
        },
      ),
    );
  }
}
