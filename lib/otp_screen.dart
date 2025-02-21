import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearning_app/confirm_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _seconds = 60;
  Timer? _timer; // Make timer nullable
  bool _isResendButtonDisabled = true;
  bool _isLoading = false; // Add loading state

  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode(debugLabel: "OTP Focus"));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _isResendButtonDisabled = true;
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel(); // Cancel timer when done
        setState(() {
          _isResendButtonDisabled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer if it's running
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _resendOtp() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber:
            '+91${widget.phoneNumber}', // Use the original phone number
        verificationCompleted: (PhoneAuthCredential credential) {
          setState(() {
            _isLoading = false;
          });
          // Auto-retrieval (handle if needed)
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          _showSnackBar("Resend failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false;
          });
          widget.verificationId == verificationId; // Update verificationId
          _startTimer(); // Restart the timer
          _showSnackBar("OTP resent successfully!");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false;
          });
          _showSnackBar("Auto retrieval timeout.");
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Error resending OTP: ${e.toString()}");
    }
  }

  Future<void> _verifyOtpAndSubmit() async {
    String otp = _controllers.map((c) => c.text).join();

    if (otp.length != 6) {
      _showSnackBar("Invalid OTP");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'phone': widget.phoneNumber,
          'uid': userCredential.user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ConfirmSignup(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar("Verification failed: ${e.toString()}");
    }
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      height: 68,
                      width: 48,
                      child: TextFormField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (value) {
                          if (value.length == 1) {
                            if (index < _focusNodes.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index + 1]);
                            }
                          } else if (value.isEmpty) {
                            if (index > 0) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index - 1]);
                            }
                          }
                        },
                        decoration: const InputDecoration(hintText: '0'),
                        style: Theme.of(context).textTheme.headlineSmall,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _isResendButtonDisabled
                    ? 'Resend OTP in $_seconds seconds'
                    : 'You can now resend the OTP',
                style: TextStyle(
                  color: _isResendButtonDisabled ? Colors.grey : Colors.green,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _isResendButtonDisabled || _isLoading
                        ? null
                        : _resendOtp, // Disable while loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue),
                    ),
                    child: _isLoading &&
                            _isResendButtonDisabled // Show loading only for resend
                        ? const CircularProgressIndicator(
                            color: Colors.blue, strokeWidth: 2)
                        : const Text(
                            'Resend',
                            style: TextStyle(color: Colors.blue),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : _verifyOtpAndSubmit, // Disable while loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    child: _isLoading // Show loading for submit as well
                        ? const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2)
                        : const Text(
                            'Submit',
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
