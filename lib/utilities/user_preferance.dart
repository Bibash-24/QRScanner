import 'package:a2z_qr/utilities/users.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("token", user.token);
    prefs.setString("eventID", user.eventID);
    prefs.setString("pin", user.pin);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token");
    String eventID = prefs.getString("eventID");
    String pin = prefs.getString("pin");

    return User(
      token: token,
      eventID: eventID,
      pin: pin,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("token");
    prefs.remove("eventID");
    prefs.remove("pin");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
