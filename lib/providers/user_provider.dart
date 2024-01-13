import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/models/models.dart';
import 'package:tezda/providers/product_provider.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);
}

final userProvider = StateNotifierProvider((ref) => UserNotifier());
