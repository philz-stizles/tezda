import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/providers.dart';
import 'package:tezda/widgets/widgets.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            favorites.isEmpty
                ? const Center(
                    child:
                        Text('You have no favorites yet - Start adding some!'))
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width * 0.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 2),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      var product = favorites[index];
                      return ProductItemCard(
                        product: product,
                        onSelectProduct: () {},
                      );
                    },
                  )
          ],
        ));
  }
}
