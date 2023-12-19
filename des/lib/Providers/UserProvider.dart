import 'package:flutter/material.dart';
import '../Models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  
  User? get user => _user; 
  
  void setUser(User newUser) {
    _user = newUser;
    notifyListeners(); // Notify listeners of changes
  }
}
