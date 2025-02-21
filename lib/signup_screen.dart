import 'package:elearning_app/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number (+91...)',
                border: OutlineInputBorder(), // Add border
                prefixText: '+91 ', // Show country code prefix
              ),
            ),
            const SizedBox(height: 20),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () {
                          final phoneNumber = _phoneController.text.trim();

                          // Basic validation (you can add more robust checks)
                          if (phoneNumber.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Phone number is required')),
                            );
                            return;
                          }

                          if (phoneNumber.length != 10) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Phone number must be 10 digits')),
                            );
                            return;
                          }

                          if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid phone number format')),
                            );
                            return;
                          }

                          authProvider.verifyPhoneNumber(
                              '+91$phoneNumber', context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 12, 1, 82), // Set background color directly
                    foregroundColor: Colors.white, // Set text color
                    shape: RoundedRectangleBorder(
                      // Set button shape
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Send OTP'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
