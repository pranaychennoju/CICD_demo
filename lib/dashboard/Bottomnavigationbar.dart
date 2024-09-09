import 'package:elearning_app/dashboard/dashboard_screen.dart';
import 'package:elearning_app/dashboard/mylearnings_screen.dart';
import 'package:elearning_app/dashboard/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int myIndex = 0;
  List<Widget> WidgetList = [
    const DashboardScreen(),
    const MylearningsScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E learning App'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 12, 1, 82), Colors.blue],
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            stops: [0.0, 0.8],
            tileMode: TileMode.clamp,
          ),
        ),
        child: BottomNavigationBar(
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.transparent,
            showUnselectedLabels: false,
            // type: BottomNavigationBarType.,
            onTap: (index) {
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_library), label: "My Learnings"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ]),
      ),
      body: Center(
        child: WidgetList[myIndex],
      ),
    );
  }
}
