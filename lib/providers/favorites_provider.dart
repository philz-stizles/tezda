
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/models/models.dart';

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]);

  bool toggleFavorite(Product product) {
    final isFavorite = state.contains(product);
    if (isFavorite) {
      state = state.where((element) => element.id != product.id).toList();
      return false;
    } else {
      state = [...state, product];
      return true;
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>(
        (ref) => FavoritesNotifier());
