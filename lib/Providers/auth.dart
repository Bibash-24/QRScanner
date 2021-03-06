import 'dart:async';
import 'dart:convert';

import 'package:a2z_qr/Utils/user_preferance.dart';
import 'package:a2z_qr/Model/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String eventsId, String pinCode) async {
    var result;

    final Map<String, dynamic> loginData = {
      'eventsID': eventsId,
      // 'EVE-20007'
      'pinCode': pinCode,
      // '313922'
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await http.post(
        Uri.parse("https://api.a2zticketing.com/api/pinCode"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: json.encode(loginData));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      var userData = json.decode(responseData);

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
