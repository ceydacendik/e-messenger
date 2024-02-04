// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UrlLauncherButton extends StatelessWidget {
  const UrlLauncherButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.08,
      margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
