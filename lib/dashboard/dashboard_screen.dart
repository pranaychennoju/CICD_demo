import 'dart:async'; // For the timer
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller to track the current page of the carousel
  PageController _pageController = PageController();

  // List of image URLs
  final List<String> _imageUrls = [
    'https://mintbook.com/blog/wp-content/uploads/2019/08/5-Reasons-to-Invest-In-E-Learning-Tools-for-Your-Children.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgp6LN5eNcoeQ2lFbLhBeT6fAxyMyL0KW7FQ&s',
    'https://thumbs.dreamstime.com/b/e-learning-concept-white-background-drawn-79671281.jpg',
  ];

  // Timer for automatic sliding
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start automatic sliding
    _startAutoSlide();
  }

  // Start automatic sliding every 3 seconds
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < _imageUrls.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // Stop automatic sliding when the widget is disposed
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Pranay",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20), // Add space between text and carousel
            // Carousel using PageView
            Container(
              height: 200, // Decreased height of image
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    _imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20), // Add some space below the carousel
            // Dot indicators to show the current page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _imageUrls.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Row with flexible containers and icons + text with onPressed functionality
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action when the first container is tapped
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("First container pressed")),
                      );
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.library_books, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Cources",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20), // Space between containers
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Action when the second container is tapped
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Second container pressed")),
                      );
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.mood, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Free Cources",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
