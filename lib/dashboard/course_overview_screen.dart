import 'package:flutter/material.dart';

class CourseOverviewScreen extends StatelessWidget {
  final String courseTitle;
  final String courseImage;
  final double coursePrice;

  const CourseOverviewScreen({
    required this.courseTitle,
    required this.courseImage,
    required this.coursePrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context)),
                  Text(
                    'Course Overview',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 16),

              // Course Title
              Text(
                courseTitle,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(courseImage),
              ),
              SizedBox(height: 24),

              // Course Overview
              Text(
                'Course Overview',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'In this course, you will learn how to create professional looking presentations using Microsoft PowerPoint. We will cover everything from the basics of PowerPoint to more advanced features such as animations and slide transitions. By the end of the course, you will be able to create presentations that will impress your colleagues and clients.',
              ),
              SizedBox(height: 24),

              // Learning Objectives
              Text(
                'Key Learning Objectives',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Learn the basics of PowerPoint and how to navigate the interface.\n'
                '• Create a presentation from scratch using templates and themes.\n'
                '• Insert and format text, images, and videos into slides.\n'
                '• Apply animations and slide transitions to enhance presentations.\n\n'
                'By applying these skills, you will be able to create visually appealing and engaging presentations that communicate your ideas effectively.',
              ),
              SizedBox(height: 24),

              // Instructor
              Text(
                'Instructor: John Doe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'John Doe is a presentation expert with over 10 years of experience in creating and delivering impactful presentations. He has worked with Fortune 500 companies and has taught thousands of students how to master PowerPoint.',
              ),
              SizedBox(height: 32),

              // Price and Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Course price: \$${coursePrice.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Buy Now
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
