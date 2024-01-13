import 'dart:async';

class AuthUser {
  AuthUser({this.userId, this.token, this.expiryDate, this.authTimer});

  String? userId;
  String? token;
  DateTime? expiryDate;
  Timer? authTimer;

  @override
  String toString() {
    return '''{
      id: $userId, 
      token: $token, 
      expiryDate: ${expiryDate?.toIso8601String()}, 
      authTimer: ${authTimer.toString()}
      }''';
  }
}
