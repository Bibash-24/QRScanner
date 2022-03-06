class User {
  String token;
  String eventID;
  String pin;

  User({this.token, this.eventID, this.pin});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      token: responseData['token'] as String,
      eventID: responseData['eventID'] as String,
      pin: responseData['pin'] as String,
    );
  }
}
