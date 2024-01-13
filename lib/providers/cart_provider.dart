import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/models/models.dart';

class CartNotifier extends StateNotifier<Map<String, CartItem>> {
  CartNotifier() : super({});

  int get cartProductCount => state.length;

  double get totalAmount {
    var totalAmount = 0.0;
    state.forEach((key, value) {
      totalAmount += (value.quantity * value.price);
    });

    return totalAmount;
  }

  void add({required int id, required String title, required image, required double price}) {
    if (state.containsKey(id)) {
      state.update(
          id.toString(),
          (existing) => CartItem(
              id: existing.id,
              title: existing.title,
              image: existing.image,
              price: existing.price,
              quantity: existing.quantity + 1));
    } else {
      state.putIfAbsent(
          id.toString(),
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              image: image,
              price: price,
              quantity: 1));
    }
  }

  void removeSingleItem(int id) {
    if (!state.containsKey(id)) {
      return;
    }

    if (state[id]!.quantity > 1) {
      state.update(id.toString(), (cartItemModel) {
        cartItemModel.quantity - 1;
        return cartItemModel;
      });
    } else {
      state.remove(id);
    }
  }

  void clear() {
    state.clear();
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartItem>>(
    (ref) => CartNotifier());
