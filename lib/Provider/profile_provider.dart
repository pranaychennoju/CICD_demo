import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  bool _isEditing = false;

  bool get isEditing => _isEditing;

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }
}
