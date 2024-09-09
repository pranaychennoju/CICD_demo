import 'package:elearning_app/dashboard/Bottomnavigationbar.dart';
import 'package:elearning_app/landing_page.dart';
import 'package:elearning_app/login_screen.dart';
import 'package:flutter/material.dart';

import 'dashboard/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
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
        home: const BottomNavigationBarWidget());
  }
}
