import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/providers.dart';
import 'package:tezda/utils/constants.dart';

class CartCard extends ConsumerWidget {
  const CartCard(
      {super.key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.image,
      required this.title,
      required this.productId});

  final int productId;
  final String id;
  final String title;
  final String image;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider.notifier);

    return Dismissible(
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE6E6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: const [Spacer(), Icon(Icons.delete_forever)],
          ),
        ),
        onDismissed: (direction) => cart.removeSingleItem(productId),
        direction: DismissDirection.endToStart,
        key: ValueKey(id),
        child: Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: "\$$price",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: "  x$quantity",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
