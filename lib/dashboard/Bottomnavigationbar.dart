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
    HomeScreen(),
    const MylearningsScreen(),
    const ProfileScreen()
  ];

  // Define the gradient colors for reuse
  final Color appBarColor = const Color.fromARGB(255, 66, 51, 160);
  final Color bottomNavEndColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assects/images/Hackethos4u.jpg',
          width: 50,
        ),

        centerTitle: true,
        backgroundColor: appBarColor, // Match the AppBar color
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appBarColor, bottomNavEndColor],
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
            onTap: (index) {
              setState(() {
                myIndex = index;
              });
            },
            currentIndex: myIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_library), label: "My Purchases"),
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
