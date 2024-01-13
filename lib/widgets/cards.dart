import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tezda/models/models.dart';
import 'package:tezda/providers/providers.dart';
import 'package:tezda/screens/screens.dart';

class ProductItemCard extends ConsumerWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    required this.onSelectProduct,
  });

  final Product product;
  final void Function() onSelectProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final favoritesP = ref.watch(favoritesProvider.notifier);
    final cart = ref.read(cartProvider.notifier);
    final isFavorite = favorites.contains(product);

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
                onPressed: () => {favoritesP.toggleFavorite(product)},
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                )),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.add(
                    id: product.id!,
                    title: product.title,
                    price: product.price);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Product added to cart!'),
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () => cart.removeSingleItem(product.id!)),
                ));
              },
              icon: Icon(Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.secondary),
            )),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product))),
          child: SizedBox(
            width: double.infinity,
            child: Image.network(
              product.image!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemCard extends ConsumerWidget {
  const CartItemCard(
      {super.key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.title,
      required this.productId});

  final int productId;
  final String id;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider.notifier);
    return Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: const Icon(Icons.delete),
        ),
        onDismissed: (direction) => cart.removeSingleItem(productId),
        confirmDismiss: (direction) => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  icon: Icon(Icons.remove_shopping_cart_rounded,
                      color: Theme.of(context).colorScheme.secondary),
                  title: const Text(
                    'Are you sure?',
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                      'Do you want to remove the selected item from the cart?',
                      textAlign: TextAlign.center),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('No')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Yes'))
                  ],
                )),
        direction: DismissDirection.endToStart,
        key: ValueKey(id),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FittedBox(
                      child: Text('\$$price'),
                    ),
                  ),
                ),
                title: Text(title),
                subtitle: Text('Total: \$${quantity * price}'),
                trailing: Text('${quantity}x'),
              )),
        ));
  }
}

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? icon;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}
