import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tezda/models/models.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  final _baseUrl = dotenv.get('API_BASE_URL');

  Future<void> loadUserProfile() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/users.json"));
      final json = jsonDecode(response.body) as Map<String, dynamic>?;
      state = json == null ? null : User.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading products: $e');
      }
    }
  }

  Future<void> create(User user) async {
    try {
      final response = await http.post(Uri.parse("$_baseUrl/users.json"),
          body: jsonEncode(user));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      state = User.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading products: $e');
      }
    }
  }

  Future<void> update(String id, User user) async {
    try {
      final response = await http.patch(
          Uri.parse("$_baseUrl/users/$id.json"),
          body: jsonEncode(user));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      state = User.fromJson(json);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading products: $e');
      }
    }
  }
}

final userProvider = StateNotifierProvider((ref) => UserNotifier());
