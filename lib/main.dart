import 'package:elearning_app/landing_page.dart'; // Import your screens
import 'package:elearning_app/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase FIRST

  await FirebaseAppCheck.instance.activate(
    // Activate App Check IMMEDIATELY AFTER Firebase initialization
    androidProvider:
        AndroidProvider.debug, // Correct: Debug provider for development
    // webProvider:  WebProvider.debug, // If you have web, use this for web
  );

  runApp(const MyApp()); // THEN run the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SignupScreen(), // Or LandingPage, whichever is your initial screen
    );
  }
}
