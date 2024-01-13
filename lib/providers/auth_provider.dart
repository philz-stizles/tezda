import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda/models/models.dart';

class AuthUserKeys {
  static const storeKey = 'userData';
  static const userId = 'userId';
  static const token = 'token';
  static const expiryDate = 'expiryDate';
}

class AuthNotifier extends StateNotifier<AuthUser> {
  AuthNotifier() : super(AuthUser());

  final _baseUrl = dotenv.get('AUTH_BASE_URL');
  final _apiKey = dotenv.get('AUTH_API_KEY');

  bool get isAuthenticated => state.token != null;

  String? get token {
    if (state.token != null &&
        state.expiryDate != null &&
        state.expiryDate!.isAfter(DateTime.now())) {
      return state.token;
    }

    return null;
  }

  String? get userId => state.userId.toString();

  Future<void> register(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl:signUp?key=$_apiKey'),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      print(json);
      if (json['error'] != null) {
        throw HttpException(json['error']['message']);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await http.post(
          Uri.parse('$_baseUrl:signInWithPassword?key=$_apiKey'),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final json = jsonDecode(response.body);

      if (json['error'] != null) {
        throw HttpException(json['error']['message']);
      }

      final expiryDate =
          DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));

      final authUser = AuthUser(
        token: json['idToken'],
        userId: json['localId'],
        expiryDate: expiryDate,
      );

      print(authUser);

      // // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();

      // _setAutoLogoutTimer();

      final userDataString = jsonEncode({
        AuthUserKeys.token: authUser.token,
        AuthUserKeys.userId: authUser.userId,
        AuthUserKeys.expiryDate: expiryDate.toIso8601String(),
      });

      await prefs.setString(AuthUserKeys.storeKey, userDataString);

      state = authUser;

       print(state);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    state.token = null;
    state.userId = null;
    state.expiryDate = null;

    if (state.authTimer != null) {
      state.authTimer?.cancel();
    }

    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AuthUserKeys.storeKey)) {
      await prefs.remove(AuthUserKeys.storeKey);
    }
  }

  void _setAutoLogoutTimer() {
    if (state.authTimer != null) {
      state.authTimer?.cancel();
      state.authTimer = null;
    }
    // if (state.expiryDate != null) {
    final secondsToExpiry =
        state.expiryDate!.difference(DateTime.now()).inSeconds;
    state.authTimer = Timer(Duration(seconds: secondsToExpiry), logout);
    // } else {
    //   await logout();
    // }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(AuthUserKeys.storeKey)) {
      return false;
    }

    final userDataString = prefs.getString(AuthUserKeys.storeKey);
    if (userDataString == null) {
      return false;
    }

    final userData = jsonDecode(userDataString) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData[AuthUserKeys.expiryDate]);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    state.token = userData[AuthUserKeys.token];
    state.userId = userData[AuthUserKeys.userId];
    state.expiryDate = expiryDate;

    _setAutoLogoutTimer();

    return true;
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthUser>((ref) => AuthNotifier());
