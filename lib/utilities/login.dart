class Login {
  final String token;

  Login(this.token);

  factory Login.fromJson(dynamic json) {
    return Login(json['token'] as String);
  }

  @override
  String toString() {
    return '{ ${this.token} }';
  }
}
