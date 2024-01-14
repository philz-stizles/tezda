import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tezda/models/models.dart';
import 'package:tezda/providers/auth_provider.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(this.auth) : super(null);
  final AuthUser auth;
  final _baseUrl = dotenv.get('FIRE_BASE_URL');

  Future<void> loadUserProfile() async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/users/${auth.userId}.json"));
      final json = jsonDecode(response.body);
      if (json == null) {
        state = null;
        return;
      }

      if (json['error'] != null) {
        throw HttpException(json['error']['message']);
      }
      state = User.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user profile: $e');
      }
    }
  }

  Future<void> save(Map<String, dynamic> user) async {
    try {
      http.Response response;
      if (state == null) {
        response = await http.put(
            Uri.parse("$_baseUrl/users/${auth.userId}.json"),
            body: jsonEncode(user));
      } else {
        response = await http.patch(
            Uri.parse("$_baseUrl/users/${auth.userId}.json"),
            body: jsonEncode(user));
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      state = User.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving user profile: $e');
      }
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  final auth = ref.read(authProvider);

  return UserNotifier(auth);
});
