import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    //RESPONSİVE
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/welcome.png', height: screenSize.height * 0.35),
          SizedBox(height: screenSize.height * 0.15),
          Row(
            children: [
              customButton(
                screenSize,
                'Login',
                Icons.login_outlined,
                () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
              ),
              customButton(
                screenSize,
                'Register',
                Icons.app_registration_rounded,
                () => Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false),
              )
            ],
          )
        ],
      ),
    ));
  }

  Padding customButton(Size screenSize, String text, IconData icon, Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: SizedBox(
        height: screenSize.height * 0.07,
        width: screenSize.width * 0.4,
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
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
