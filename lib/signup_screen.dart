import 'package:elearning_app/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _sendOtp() async {
    final phoneNumber = _phoneController.text.trim();

    // Input Validation (Improved)
    if (phoneNumber.isEmpty) {
      _showSnackBar("Phone number is required");
      return;
    }

    if (phoneNumber.length != 10) {
      _showSnackBar("Phone number must be 10 digits");
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      _showSnackBar("Invalid phone number format");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber', // Always include country code
        verificationCompleted: (PhoneAuthCredential credential) {
          setState(() {
            _isLoading = false;
          });
          // Auto-retrieval (Handle if needed, but often not reliable)
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          _showSnackBar("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false;
          });
          _showSnackBar(
              "Auto retrieval timeout. Please enter the code manually."); // User feedback
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Error: ${e.toString()}");
    }
  }

  // Helper function for SnackBars
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: SingleChildScrollView(
          // Important for keyboard avoiding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Enter your Phone Number to Receive OTP',
                        border: OutlineInputBorder(),
                        prefixText: '+91 ', // Show country code prefix
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  // Use SizedBox to constrain button size
                  height: 44.0,
                  width: double.infinity, // or a specific width
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 12, 1, 82), // Set background color directly
                      foregroundColor: Colors.white, // Set text color
                      shape: RoundedRectangleBorder(
                        // Set button shape
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'SEND OTP',
                            style: TextStyle(
                              letterSpacing: 2,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
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
