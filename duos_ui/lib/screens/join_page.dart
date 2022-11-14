import 'package:duos_ui/screens/login_page.dart';
import 'package:duos_ui/screens/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEBAFF),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/duosJoinPageBackground.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 425),
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
            padding: const EdgeInsets.only(top: 600),
            child: Center(
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    'Join Now',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 680),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: 'Already have an account?'),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => (Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()))),
                      text: ' Log in',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
