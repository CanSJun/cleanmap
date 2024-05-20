import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  final String text;

  final void Function() onPressed;

  const IntroButton(
    this.text, {
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
              text,
              style: const TextStyle(
                fontSize: 24.0,
              )
          ),
        ),
      ),
    );
  }
}