// import 'package:flutter/material.dart';

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   List<Map<String, String>> users = [
//     {'name': 'Alice', 'email': 'alice@example.com', 'mobile': '1234567890'},
//     {'name': 'Bob', 'email': 'bob@example.com', 'mobile': '0987654321'},
//   ];

//   String selectedUser = "New User"; // Default value
//   bool isSubmitEnabled = true;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();

//   void _addNewUser() {
//     if (nameController.text.isNotEmpty &&
//         emailController.text.isNotEmpty &&
//         mobileController.text.isNotEmpty) {
//       // Check for duplicate user entry
//       bool isDuplicate = users.any((user) =>
//           user['name'] == nameController.text &&
//           user['email'] == emailController.text &&
//           user['mobile'] == mobileController.text);

//       if (isDuplicate) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("User already exists!")),
//         );
//         return;
//       }

//       setState(() {
//         // Add new user to the list
//         users.add({
//           'name': nameController.text,
//           'email': emailController.text,
//           'mobile': mobileController.text,
//         });

//         // Reset the fields after adding
//         nameController.clear();
//         emailController.clear();
//         mobileController.clear();

//         // Set selectedUser to the newly added name and enable submit button
//         selectedUser = nameController.text;
//         isSubmitEnabled = true;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("User added successfully!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill in all the fields")),
//       );
//     }
//   }

//   String formatMobile(String mobile) {
//     return '*' * (mobile.length - 4) + mobile.substring(mobile.length - 4);
//   }

//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.0),
//         borderSide: BorderSide(color: Colors.grey, width: 1.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.0),
//         borderSide: BorderSide(color: Colors.grey, width: 1.0),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.0),
//         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Ensure selectedUser is valid
//     if (!users.any((user) => user['name'] == selectedUser) &&
//         selectedUser != "New User") {
//       selectedUser = "New User";
//     }

//     // Create a list of unique names for the dropdown
//     List<String> dropdownItems = ["New User"];
//     dropdownItems.addAll(users.map((user) => user['name']).toSet().toList());

//     return Scaffold(
//       appBar: AppBar(title: Text("User Details")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Dropdown with box decoration
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey, width: 1.0),
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//               child: DropdownButton<String>(
//                 value: selectedUser,
//                 isExpanded: true,
//                 onChanged: (value) {
//                   setState(() {
//                     if (value != null) {
//                       selectedUser = value;
//                       if (value == "New User") {
//                         nameController.clear();
//                         emailController.clear();
//                         mobileController.clear();
//                         isSubmitEnabled = true;
//                       } else {
//                         final user =
//                             users.firstWhere((user) => user['name'] == value);
//                         nameController.text = user['name']!;
//                         emailController.text = user['email']!;
//                         mobileController.text = formatMobile(user['mobile']!);
//                         isSubmitEnabled =
//                             true; // Keep the submit button enabled for modifications
//                       }
//                     }
//                   });
//                 },
//                 items: dropdownItems.map((name) {
//                   return DropdownMenuItem(
//                     value: name,
//                     child: Text(name),
//                   );
//                 }).toList(),
//               ),
//             ),

//             SizedBox(height: 16),

//             // Name field
//             TextField(
//               controller: nameController,
//               enabled: selectedUser == "New User",
//               decoration: _inputDecoration("Name"),
//             ),

//             SizedBox(height: 16),

//             // Email field
//             TextField(
//               controller: emailController,
//               enabled: selectedUser == "New User",
//               decoration: _inputDecoration("E-Mail Id"),
//             ),

//             SizedBox(height: 16),

//             // Mobile field
//             TextField(
//               controller: mobileController,
//               enabled: selectedUser == "New User",
//               decoration: _inputDecoration("Mobile Number"),
//             ),

//             SizedBox(height: 24),

//             // Submit button
//             ElevatedButton(
//               onPressed: isSubmitEnabled ? _addNewUser : null,
//               child: Text("Submit"),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
