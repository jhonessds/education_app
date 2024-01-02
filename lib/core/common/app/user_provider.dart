import 'package:education_app/src/auth/data/models/local_user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? value) {
    if (_user != value) _user = value;
    notifyListeners();
  }

  set user(LocalUserModel? value) {
    if (_user != value) {
      _user = value;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
