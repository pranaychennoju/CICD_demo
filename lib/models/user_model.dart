// import 'package:cloud_firestore/cloud_firestore.dart';

// class User {
//   final String uid; // Firebase UID (required)
//   final String name; // (required)
//   final String? email; // Nullable
//   final String? userId; // Nullable
//   //... other user fields as needed

//   User({
//     required this.uid,
//     required this.name,
//     this.email,
//     this.userId,
//   });

//   // Factory constructor to create a User object from a Firestore document
//   factory User.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return User(
//       uid: doc.id, // The document ID is the UID
//       name: data['name'] ?? '', // Provide default values if fields are missing
//       email: data['email'],
//       userId: data['userId'],
//     );
//   }

//   // Method to convert a User object to a map for Firestore updates
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'userId': userId,
//     };
//   }

//   // Named constructor for creating a User from form data
//   User.fromFormData({
//     required this.uid,
//     required String name,
//     String? email,
//     String? userId,
//   })  : name = name,
//         email = email,
//         userId = userId;
// }
