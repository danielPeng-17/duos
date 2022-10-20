import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              child: Image.asset('assets/images/duosJoinPageBackground.png',
                  scale: 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 425),
            child: Center(
              child: SizedBox(
                width: 250,
                height: 200,
                child: Image.asset('assets/images/duosBlackLogoText.png',
                    scale: 10.0),
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
                    //Navigator.push();
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
            padding: const EdgeInsets.only(top: 740),
            child: Center(child: Container(color: const Color(0xFFCEBAFF))),
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
                            ..onTap = () =>
                                (print("Placeholder for login navigator")),
                          text: ' Log in',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
