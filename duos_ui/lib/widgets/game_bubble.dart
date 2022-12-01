import 'package:flutter/material.dart';

class GameBubble extends StatelessWidget {
  const GameBubble({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blue.withOpacity(0.25)),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}