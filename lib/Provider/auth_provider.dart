import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _verificationId; // Store verification ID

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          _isLoading = false;
          notifyListeners();
          await _auth.signInWithCredential(credential);

          final User? user = _auth.currentUser;
          if (user != null) {
            await _firestore.collection('users').doc(user.uid).set({
              'uid': user.uid,
              'phone': phoneNumber,
              'createdAt': FieldValue.serverTimestamp(),
            });
          }

          Navigator.pushReplacementNamed(
              context, '/confirm_signup'); // Navigate to confirm signup
        },
        verificationFailed: (FirebaseAuthException e) {
          _isLoading = false;
          notifyListeners();
          _showSnackBar(
              "Phone number verification failed: ${e.message}", context);
        },
        codeSent: (String verificationId, int? resendToken) {
          _isLoading = false;
          notifyListeners();
          _verificationId = verificationId;
          Navigator.pushNamed(context, '/otp');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _isLoading = false;
          notifyListeners();
          _showSnackBar("Auto retrieval timeout.", context);
        },
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      _showSnackBar("Error during phone number verification: $e", context);
    }
  }

  Future<void> verifyOTP(String otp, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      _isLoading = false;
      notifyListeners();

      // No need to save to Firestore here, it's done in verificationCompleted

      Navigator.pushReplacementNamed(
          context, '/confirm_signup'); // Navigate to confirm signup
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      _showSnackBar("Invalid OTP: ${e.toString()}", context);
    }
  }

  Future<void> completeSignup(
      String name, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': name,
          'password': password, // Insecure - Hash in real app
        });
      }

      _isLoading = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to home
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      _showSnackBar("Error completing signup: $e", context);
    }
  }

  Future<void> logout(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _auth.signOut();
      _isLoading = false;
      notifyListeners();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      _showSnackBar("Error during logout: $e", context);
    }
  }

  void _showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
