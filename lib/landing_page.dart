import 'package:elearning_app/login_screen.dart';
import 'package:elearning_app/signup_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assects/images/logo.png',
              height: 200,
            ),
            const SizedBox(
              height: 28,
            ),
            const Text(
              "Hello !",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
            ),
            const Text(
              textAlign: TextAlign.center,
              "Sign up or log in to embark on your journey and unlock endless learning opportunities!",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 44.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 12, 1, 82), Colors.blue])),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white, letterSpacing: 2),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 44.0,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 12, 1, 82), Colors.blue])),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: const Text(
                  'SIGNUP',
                  style: TextStyle(color: Colors.white, letterSpacing: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
