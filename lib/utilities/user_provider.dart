import 'package:a2z_qr/utilities/users.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
