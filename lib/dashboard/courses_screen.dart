import 'package:flutter/material.dart';
import 'course_overview_screen.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final List<Map<String, String>> courses = [
    {
      "title": "Python Course",
      "subtitle": "Learn Python Basics",
      "price": "\$49",
      "image": "https://via.placeholder.com/400x200"
    },
    {
      "title": "Marketing Mastery",
      "subtitle": "Master Digital Marketing",
      "price": "\$99",
      "image": "https://via.placeholder.com/400x200"
    },
    {
      "title": "Graphic Design",
      "subtitle": "Design like a Pro",
      "price": "\$79",
      "image": "https://via.placeholder.com/400x200"
    },
    {
      "title": "Data Science",
      "subtitle": "Analyze Big Data",
      "price": "\$129",
      "image": "https://via.placeholder.com/400x200"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Courses"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Large Full-Width Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    course['image']!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course['title']!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(course['subtitle']!,
                          style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 6),
                      Text(course['price']!,
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseOverviewScreen(
                                  courseTitle: course['title']!,
                                  courseImage: course['image']!,
                                  coursePrice: double.parse(course['price']!
                                      .replaceAll('\$', '')
                                      .replaceAll(',', '')),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Enroll Now'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
