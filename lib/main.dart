import 'package:elearning_app/Provider/auth_provider.dart';
import 'package:elearning_app/Provider/navigation_provider.dart';
import 'package:elearning_app/Provider/profile_provider.dart';
import 'package:elearning_app/screens/confirm_signup.dart';
import 'package:elearning_app/dashboard/Bottomnavigationbar.dart';
import 'package:elearning_app/dashboard/courses_screen.dart';
import 'package:elearning_app/dashboard/mylearnings_screen.dart';
import 'package:elearning_app/dashboard/profile_screen.dart';
import 'package:elearning_app/login_screen.dart';
import 'package:elearning_app/otp_screen.dart';

import 'package:elearning_app/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ) // Add this line
      ],
      child: MaterialApp(
        title: 'E-learning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute:
            '/signup', // Or '/home' if you want to skip signup for testing
        routes: {
          '/signup': (context) => const SignupScreen(),
          '/otp': (context) => OtpScreen(),
          '/confirm_signup': (context) => const ConfirmSignupScreen(),
          '/home': (context) => DashboardScreen(), // Or HomeScreen
          '/login': (context) => LoginScreen(),
          '/courses': (context) =>
              CoursesScreen(), // Add routes for other screens
          '/my_courses': (context) => MylearningsScreen(),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
