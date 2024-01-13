import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tezda/models/models.dart';

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super(const []);

  final _baseUrl = dotenv.get('API_BASE_URL');

  Future<void> loadProducts({bool filterByUser = false}) async {
    try {
      final response = await http.get(Uri.https(_baseUrl, 'products'));
      final json = jsonDecode(response.body) as List<dynamic>;
      state = json.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading products: $e');
      }
    }
  }

  Product findById(int id) =>
      state.firstWhere((element) => element.id == id);
}

final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
    (ref) => ProductNotifier());
