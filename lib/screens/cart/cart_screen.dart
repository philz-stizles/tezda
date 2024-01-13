import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/providers.dart';
import 'package:tezda/widgets/widgets.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartP = ref.watch(cartProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Chip(
                      label: Text('\$${cartP.totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).primaryTextTheme.titleLarge),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    const Spacer(),
                    // OrderButton(cartProvider: cartProvider)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                var value = cart.values.toList()[index];
                var key = cart.keys.toList()[index];
                return CartItemCard(
                    productId: int.parse(key),
                    id: value.id!,
                    title: value.title,
                    price: value.price,
                    quantity: value.quantity);
              },
            ))
          ],
        ));
  }
}
