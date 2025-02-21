import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import your provider (replace with your actual path)
import 'package:elearning_app/Provider/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data (replace with your actual data loading)
  Map<String, dynamic> _userData = {
    'name': 'Avlin Thomus',
    'location': 'New York',
    'email': 'avlin_tms@gmail.com',
    // ... other user data
  };

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isLoading = false; // Add loading state

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: _userData['name']);
    _emailController = TextEditingController(text: _userData['email']);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                icon: Icon(profileProvider.isEditing ? Icons.save : Icons.edit),
                onPressed: () {
                  if (profileProvider.isEditing) {
                    // Save changes
                    _saveProfile(profileProvider);
                  }
                  profileProvider.toggleEditing(); // Toggle editing mode
                },
              ),
            ],
          ),
          body: _isLoading // Show loading indicator while data is loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    // Add SingleChildScrollView for scrollability
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        if (!profileProvider.isEditing)
                          ..._buildDetailWidgets(),
                        if (profileProvider.isEditing)
                          ..._buildTextFieldWidgets(profileProvider),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // You can add an image here if you have one
              // image: DecorationImage(
              //   image: AssetImage('path/to/your/image.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: const Icon(Icons.person, size: 80), // Placeholder icon
          ),
          const SizedBox(height: 10),
          Text(
            _userData['name'] ?? "Name",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            _userData['location'] ?? "Location",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDetailWidgets() {
    return [
      _buildDetailRow('Name', _userData['name']),
      const SizedBox(height: 10),
      _buildDetailRow('Email', _userData['email']),
      // Add other details here...
    ];
  }

  List<Widget> _buildTextFieldWidgets(ProfileProvider profileProvider) {
    return [
      _buildTextField('Name', _nameController, profileProvider.isEditing),
      const SizedBox(height: 10),
      _buildTextField('Email', _emailController, profileProvider.isEditing,
          keyboardType: TextInputType.emailAddress),
      // Add other text fields here...
    ];
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isEditing,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: isEditing ? const OutlineInputBorder() : InputBorder.none,
      ),
      enabled: isEditing,
      keyboardType: keyboardType,
    );
  }

  Future<void> _saveProfile(ProfileProvider profileProvider) async {
    setState(() {
      _isLoading = true; // Set loading to true
    });

    try {
      // Simulate saving to database (replace with your actual save logic)
      await Future.delayed(
          const Duration(seconds: 2)); // Simulate a 2-second delay

      _userData['name'] = _nameController.text;
      _userData['email'] = _emailController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading =
            false; // Set loading to false, regardless of success/failure
      });
    }
  }
}
