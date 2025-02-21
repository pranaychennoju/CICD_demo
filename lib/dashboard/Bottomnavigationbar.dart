import 'package:elearning_app/Provider/navigation_provider.dart';
import 'package:elearning_app/Provider/profile_provider.dart';
import 'package:elearning_app/dashboard/courses_screen.dart';
import 'package:elearning_app/dashboard/home_screen.dart';
import 'package:elearning_app/dashboard/mylearnings_screen.dart';
import 'package:elearning_app/dashboard/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DashboardScreenContent();
  }
}

class _DashboardScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            backgroundColor: Colors.orange,
            automaticallyImplyLeading: false,
            actions:
                _buildAppBarActions(context, navigationProvider.selectedIndex),
          ),
          body: _buildBody(navigationProvider.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationProvider.selectedIndex,
            onTap: (index) {
              navigationProvider.setSelectedIndex(index);
            },
            backgroundColor: const Color(0xFF1A237E), // Thick blue
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Courses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books),
                label: 'My Courses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context, int index) {
    if (index == 3) {
      // Profile screen index
      return [
        Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
          return IconButton(
            icon: Icon(profileProvider.isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              profileProvider.toggleEditing();
            },
          );
        }),
      ];
    } else {
      return []; // Empty list for other screens
    }
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomeScreen(); // Replace with your Home widget
      case 1:
        return CoursesScreen(); // Replace with your Courses widget
      case 2:
        return MylearningsScreen(); // Replace with your My Courses widget
      case 3:
        return ProfileScreen(); // Replace with your Profile widget
      default:
        return const Center(child: Text('Unknown Content'));
    }
  }
}
