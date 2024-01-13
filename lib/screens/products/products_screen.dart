import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/providers.dart';
import 'package:tezda/screens/screens.dart';
import 'package:tezda/widgets/widgets.dart';

import '../../models/models.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});
  static const String routeName = '/products-screen';

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  late Future<void> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ref.read(productProvider.notifier).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);

    void selectProduct(BuildContext context, Product product) {}

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/avatar.png',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
        ),
        title: const Text('Tezda Mall'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavoritesScreen())),
              icon: const Icon(Icons.favorite_border_outlined)),
          Consumer(
              builder: (_, ref, ch) => AppBadge(
                    value: "${ref.watch(cartProvider).length}",
                    child: ch!,
                  ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)))
        ],
      ),
      body: FutureBuilder(
          future: _productsFuture,
          builder: (context, snapshot) {
            return Stack(
              children: [
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 2),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          var product = products[index];
                          return ProductItemCard(
                            product: product,
                            onSelectProduct: () =>
                                selectProduct(context, product),
                          );
                        },
                      )
              ],
            );
          }),
    );
  }
}
