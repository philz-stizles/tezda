import 'dart:async';

class AuthUser {
  AuthUser({this.userId, this.token, this.expiryDate, this.isLoading = false});

  String? userId;
  String? token;
  DateTime? expiryDate;
  Timer? authTimer;
  bool isLoading;

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
