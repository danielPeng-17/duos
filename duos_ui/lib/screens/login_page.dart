import 'dart:convert';

import 'package:duos_ui/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:duos_ui/screens/forgot_password_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String uid;
  final GlobalKey<FormState> _signinform = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _signinform,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 200,
                    child: Image.asset(
                      'assets/images/duosBlackLogoText.png',
                      scale: 10.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _emailController,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Empty';
                    }
                    if (email != null) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (emailValid) {
                        return null;
                      }
                      return 'Enter Valid Email';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    //hintText:
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 15, bottom: 0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Empty';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),
                  ),
                ),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    if (_signinform.currentState!.validate()) {
                      signIn();
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ).then((value) {
        if (value.user != null) {
          uid = value.user!.uid;
        }
      });

      if (uid.isNotEmpty) {
        final token = await FirebaseAuth.instance.currentUser!.getIdToken();

        final response = await http.get(
            Uri.parse("http://10.0.2.2:3000/user/$uid"),
            headers: {
              "content-type": "application/json",
              "authorization": 'Bearer $token',
            });
        final decodedRes = jsonDecode(response.body);
        print(decodedRes);
        if(!mounted) return;
        if (decodedRes.isNotEmpty) {
          print(decodedRes["info"]["first_name"]);
          context.read<Profile>().setFirstName(decodedRes["info"]["first_name"]);
          context.read<Profile>().setLastName(decodedRes["info"]["last_name"]);
          context.read<Profile>().setEmail(decodedRes["info"]["email"]);
          context.read<Profile>().setGender(decodedRes["info"]["gender"]);
          context.read<Profile>().setBio(decodedRes["info"]["bio"]);
          context.read<Profile>().setDateofBirth(decodedRes["info"]["date_of_birth"]);
          context.read<Profile>().setHobbies(decodedRes["info"]["hobbies"]);
          context.read<Profile>().setProfilePicURL(decodedRes["info"]["profile_picture_url"]);
          context.read<Profile>().setDatingPref(decodedRes["info"]["dating_pref"]);
          // context.read<Profile>().setCategories(decodedRes["categories"]);
          context.read<Profile>().setLanguages(decodedRes["info"]["languages"]);
          context.read<Profile>().setLocation(decodedRes["info"]["location"]);

        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    }

    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
